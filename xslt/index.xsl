<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>

    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select='"Litterae Annuae Societatis Jesu"'/>
        </xsl:variable>
        <html class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <style>
                    <!--body {
                    font-family: Arial, sans-serif;
                    line-height: 1.6;
                    margin: 0;
                    padding: 0;
                    background-color: #f8f9fa;
                    color: #212529;
                    }
                    
                    main {
                    padding: 20px;
                    }-->
                    
                    .container {
                    max-width: 1000px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #ffffff;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }
                    
                    h1 {
                    font-size: 2em;
                    margin-bottom: 0.5em;
                    }
                    
                    h2 {
                    font-size: 1.5em;
                    margin-bottom: 1em;
                    color: #6c757d;
                    }
                    
                    figure {
                    margin: 0 0 1em 1em;
                    max-width: fit-content;
                    }
                    
                    img {
                    max-width: 100%;
                    height: auto;
                    object-fit: contain;
                    }
                    
                    .figure-caption {
                    font-size: 0.9em;
                    color: #6c757d;
                    text-align: right;
                    }
                    
                    p {
                    margin: 1em 0;
                    }
                    
                    p ul {
                    list-style-type: disc;
                    margin: 1em 0 1em 20px;
                    padding: 0;
                    }
                    
                    p a {
                    color: #007bff;
                    text-decoration: none;
                    }
                    
                    p a:hover {
                    text-decoration: underline;
                    }
                    
                    @media (max-width: 768px) {
                    figure {
                    float: none;
                    margin: 0 0 1em 0;
                    max-width: 100%;
                    }
                    }
                    
                </style>
            </head>            
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0">
                    <div class="container">
                        <h1><xsl:value-of select="$project_short_title"/></h1>
                        <h2><xsl:value-of select="$project_title"/></h2>
                        <div>
                            
                            <p>Willkommen auf der Website des Projekts zu den Litterae Annuae der <a href="https://www.onb.ac.at/">Österreichischen Nationalbibliothek</a>. Diese Plattform bietet einfachen Zugang zu den im Rahmen des Projekts generierten Daten: 
                              <ul>
                                <li><a href="toc.html">Handschriftenbeschreibungen</a></li>
                                <li><a href="listplace.html">Ortsregister</a></li>
                                <li><a href="listorg.html">Institutionsregister</a></li>
                            </ul>sowie Links zu den Digitalisaten. Eine kurze Projektbeschreibung finden Sie unter <a href="about.html">'Über das Projekt'</a>.
                            </p>
                        </div>
                        <figure>
                            <img src="images/karte.jpg"/>
                            <figcaption class="figure-caption text-end">Johann Baptist Mayr, <i>Provincia Austriaca Societatis Iesu</i> (Augsburg ca. 1746) - <a href="http://data.onb.ac.at/rec/AC11183479">ÖNB, K I 133647</a></figcaption>
                        </figure>                
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul id="{generate-id()}"><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li id="{generate-id()}"><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>