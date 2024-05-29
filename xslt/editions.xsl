<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/aot-options.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <style>
                    .navBarNavDropdown ul li:nth-child(2) {
                        display: none !important;
                    }
                </style>
            </head>
             <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12">
                                <xsl:if test="ends-with($prev,'.html')">
                                    <h1>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="$prev"/>
                                            </xsl:attribute>
                                            <i class="bi bi-chevron-left" title="vorrige"/>
                                        </a>
                                    </h1>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12">
                                <h1 align="center">
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <h3 align="center">
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download" title="TEI/XML"/>
                                    </a>
                                </h3>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12" style="text-align:right">
                                <xsl:if test="ends-with($next, '.html')">
                                    <h1>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="$next"/>
                                            </xsl:attribute>
                                            <i class="bi bi-chevron-right" title="nächste"/>
                                        </a>
                                    </h1>
                                </xsl:if>
                            </div>                            
                        </div>
                        <div >	                                
                            <xsl:choose>
                                <xsl:when test="//tei:msDesc/tei:head/tei:note[@type='facs']">
                                    <a class="btn btn-outline-dark" href="{//tei:msDesc/tei:head/tei:note[@type='facs']/tei:ref/@target}"  target="_blank" title="opens in a new tab">
                                        <xsl:value-of select="//tei:msDesc/tei:head/tei:note[@type='facs']/tei:ref"/>
                                        <xsl:text>Digital facsimile</xsl:text>
                                    </a>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="//tei:msDesc/tei:head/tei:note[@type='catalogue']">
                                    <a class="btn btn-outline-dark" href="{//tei:msDesc/tei:head/tei:note[@type='catalogue']/tei:ref/@target}"  target="_blank" title="opens in a new tab">
                                        <xsl:text>Library catalogue</xsl:text>
                                    </a>
                                </xsl:when>
                            </xsl:choose>                                 
                            
                        </div>
                        <div class="card-body"> 
                            
                            <xsl:text>Codex &#8212; </xsl:text><xsl:apply-templates select=".//tei:support"/><xsl:text> &#8212; </xsl:text><xsl:apply-templates select=".//tei:extent/tei:measure"/><xsl:text> &#8212; </xsl:text><xsl:apply-templates select=".//tei:dimensions/tei:height"/><xsl:text>×</xsl:text><xsl:apply-templates select=".//tei:dimensions/tei:width"></xsl:apply-templates><xsl:text> mm &#8212; </xsl:text><xsl:apply-templates select=".//tei:head/origDate"/><br/>
                            
                            <h2><xsl:apply-templates select=".//tei:head/tei:title"></xsl:apply-templates></h2> 
                            <p><xsl:apply-templates select=".//tei:msContents/tei:summary/text()[normalize-space()]"></xsl:apply-templates></p>
                            
                            <h2><xsl:text>Äußeres</xsl:text></h2>
                            <xsl:apply-templates select=".//tei:foliation"></xsl:apply-templates><br/>
                            <xsl:apply-templates select=".//tei:binding"></xsl:apply-templates>                                
                            <xsl:choose>
                                <xsl:when test=".//tei:accMat != ''">
                                    <xsl:apply-templates select=".//tei:accMat"></xsl:apply-templates>
                                </xsl:when>
                            </xsl:choose>                                    
                                                        
                            <xsl:if test=".//tei:msItem">
                                <h2><xsl:text>Inhalt</xsl:text></h2>
                                <xsl:for-each select=".//tei:msItem">                                        
                                    <xsl:apply-templates select="./tei:locus"/><xsl:text> </xsl:text>
                                    <xsl:apply-templates select="./tei:title"/>
                                    <xsl:apply-templates select=".//tei:orgName"/>
                                    <xsl:apply-templates select=".//tei:placeName"/>
                                    <xsl:if test=".//tei:date">
                                        <xsl:text> (a. </xsl:text><xsl:apply-templates select=".//tei:date"/><xsl:text>)</xsl:text>
                                    </xsl:if>
                                    <br/>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:if test=".//tei:listOrg">                                    
                                <xsl:apply-templates select=".//tei:listOrg/tei:head"/>
                                <ul class="collapsible" onclick="toggleList('orgList')">
                                    <button type="button" class="btn btn-outline-dark">Im Text erwähnte Körperschaften:</button>                                       
                                    <ul class="content" id="orgList">
                                        <xsl:for-each-group select=".//tei:org" group-by=".//tei:orgName[not(@type='alt')]">
                                            <xsl:sort select=".//tei:orgName[not(@type='alt')]" />
                                            <li>
                                                <xsl:apply-templates select="current-group()[1]//tei:orgName[not(@type='alt')]"/>
                                            </li>
                                        </xsl:for-each-group>
                                    </ul>
                                </ul>
                            </xsl:if>                               
                            
                            <xsl:if test=".//tei:listPlace">
                                <xsl:apply-templates select=".//tei:listPlace/tei:head"/>
                                <ul class="collapsible" onclick="toggleList('placeList')">
                                    <button type="button" class="btn btn-outline-dark">Im Text erwähnte Orte:</button>
                                    <ul class="content" id="placeList">
                                        <xsl:for-each-group select=".//tei:place" group-by=".//tei:placeName[not(@type='alt')]">
                                            <xsl:sort select=".//tei:placeName[not(@type='alt')]" />
                                            <li>
                                                <xsl:apply-templates select="current-group()[1]//tei:placeName[not(@type='alt')]"/>
                                            </li>
                                        </xsl:for-each-group>
                                    </ul>                                         
                                </ul>
                            </xsl:if>
                        </div>
                        <xsl:apply-templates select=".//tei:body"></xsl:apply-templates>
                        <!--<p style="text-align:center;">
                            <xsl:for-each select=".//tei:note[not(./tei:p)]">
                                <div class="footnotes" id="{local:makeId(.)}">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna_</xsl:text>
                                                <xsl:number level="any" format="1" count="tei:note"/>
                                            </xsl:attribute>
                                            <span style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                                <xsl:number level="any" format="1" count="tei:note"/>
                                            </span>
                                        </a>
                                    </xsl:element>
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </p>-->

                    </div>
                    <xsl:for-each select="//tei:back">
                        <div class="tei-back">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:for-each>
                </main>
                <xsl:call-template name="html_footer"/>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.0/openseadragon.min.js"/>
                <script src="https://unpkg.com/de-micro-editor@0.3.4/dist/de-editor.min.js"></script>
                <script type="text/javascript" src="js/run.js"></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
