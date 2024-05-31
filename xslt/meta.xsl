<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>


    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <html class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <style>
                    .container {
                    max-width: 1000px;                    
                    padding: 20px;}
                    h1 {
                    font-size: 2em;
                    margin-bottom: 0.5em;
                    }
                    
                    h2 {
                    font-size: 1.5em;
                    margin-bottom: 1em;
                    }
                    
                    figure {
                    margin: 0 0 1em 1em;
                    max-width: 80%;
                    }
                </style>
            </head>
            
            <body class="d-flex flex-column h-100">
            <xsl:call-template name="nav_bar"/>
                <main>
                    <div class="container">                        
                        <h1><xsl:value-of select="$doc_title"/></h1>    
                        <xsl:apply-templates select=".//tei:body"></xsl:apply-templates>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

     <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>

    <xsl:template match="tei:figure">
        <div class="text-center">
            <figure class="figure">
                <img src="{tei:graphic/@url}" class="figure-img img-fluid rounded" alt=""/>
                <figcaption class="figure-caption text-end"><xsl:value-of select="tei:figDesc"/></figcaption>
            </figure>
        </div>
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
    <xsl:template match="tei:listBibl">
        <div>
            <h3><xsl:value-of select="tei:listBibl/tei:head/text()"/></h3>
            <ul>
                <xsl:apply-templates/>
            </ul>
        </div>
        
    </xsl:template>
    <xsl:template match="tei:bibl">
        <li><xsl:value-of select="."/>
            <xsl:apply-templates/></li>
    </xsl:template>


</xsl:stylesheet>