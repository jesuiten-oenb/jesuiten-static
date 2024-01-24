<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
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
        <xsl:value-of select=".//tei:title[@type='label'][1]/text()"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <style>
                    .navBarNavDropdown ul li:nth-child(2) {
                        display: none !important;
                    }
                </style>
                <style>
                    /* Add some basic styling for the collapsible list */
                    .collapsible {
                    list-style-type: none;
                    cursor: pointer;
                    }
                    .content {
                    display: none;
                    }
                </style>
                <!-- Include JavaScript for the collapsible behavior -->
                <script>
                    function toggleList(id) {
                    var content = document.getElementById(id);
                    if (content.style.display === "none") {
                    content.style.display = "block";
                    } else {
                    content.style.display = "none";
                    }
                    }
                </script>
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <div class="card" data-index="true">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-2 col-lg-2 col-sm-12">
                                        <xsl:if test="ends-with($prev,'.html')">
                                            <h1>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="$prev"/>
                                                    </xsl:attribute>
                                                    <i class="fas fa-chevron-left" title="prev"/>
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
                                                <i class="fas fa-download" title="show TEI source"/>
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
                                                    <i class="fas fa-chevron-right" title="next"/>
                                                </a>
                                            </h1>
                                        </xsl:if>
                                    </div>
                                </div>
                                <!--<div id="editor-widget">
                                    <p>Text Editor</p>
                                    <xsl:call-template name="annotation-options"></xsl:call-template>
                                </div>-->
                            </div>
                            <div class="d-grid gap-2 d-md-block">	                                
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
                                <h1><xsl:apply-templates select=".//tei:head/tei:title"></xsl:apply-templates></h1>
                                <xsl:apply-templates select=".//tei:support"></xsl:apply-templates><xsl:text> </xsl:text><xsl:apply-templates select=".//tei:extent/tei:measure"></xsl:apply-templates><xsl:text> (</xsl:text><xsl:apply-templates select=".//tei:dimensions/tei:height"></xsl:apply-templates><xsl:text>×</xsl:text><xsl:apply-templates select=".//tei:dimensions/tei:width"></xsl:apply-templates><xsl:text> mm) </xsl:text><xsl:apply-templates select=".//tei:head/origDate"></xsl:apply-templates><br/>
                                <xsl:apply-templates select=".//tei:foliation"></xsl:apply-templates><br/>
                                <xsl:apply-templates select=".//tei:binding"></xsl:apply-templates>                                
                                    <xsl:choose>
                                        <xsl:when test=".//tei:accMat != ''">
                                            <xsl:apply-templates select=".//tei:accMat"></xsl:apply-templates>
                                        </xsl:when>
                                    </xsl:choose>                                    
                                
                                <p><xsl:apply-templates select=".//tei:msContents/tei:summary/text()[normalize-space()]"></xsl:apply-templates></p>
                                <xsl:if test=".//tei:msItem">
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
                            
                        </div>                       
                    </div>
                    <xsl:for-each select="//tei:back">
                        <div class="tei-back">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:for-each>
                    <xsl:call-template name="html_footer"/>
                </div>
                <script src="https://unpkg.com/de-micro-editor@0.2.6/dist/de-editor.min.js"></script>
                <script type="text/javascript" src="js/run.js"></script>
                <script type="text/javascript" src="js/osd_scroll.js"></script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{local:makeId(.)}" class="yes-index">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{local:makeId(.)}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:variable name='site'>https://jesuiten-oenb.github.io/jesuiten-static/</xsl:variable>
    <xsl:template match="tei:placeName">
        <a href="{concat($site, replace(./@key, '#', ''), '.html')}"><xsl:apply-templates/></a>       
    </xsl:template>
    <xsl:template match="tei:orgName">
        <a href="{concat($site, replace(./@key, '#', ''), '.html')}"><xsl:apply-templates/></a>       
    </xsl:template>
</xsl:stylesheet>
