<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    
    <xsl:template match="tei:org" name="org_detail">
        <table class="table entity-table">
            <tbody>
                <xsl:if test="./tei:orgName">
                    <tr>
                        <th>
                            Name
                        </th>
                        <td>
                            <xsl:value-of select="./tei:orgName[1]/text()"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:orgName[@type='alt']">
                    <tr>
                        <th>
                            Alternative Name
                        </th>
                        <td>
                            <xsl:value-of select="./tei:orgName[@type='alt']/text()"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:location">
                    <tr>
                        <th>
                            loacted in
                        </th>
                        <td>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="./tei:location[1]/tei:placeName[1]/@key||'.html'"/>
                                </xsl:attribute>
                                <xsl:value-of select=".//tei:location/tei:placeName/text()"/>
                            </a>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:desc">
                    <tr>
                        <th>
                            Beschreibung
                        </th>
                        <td>
                            <xsl:value-of select="./tei:desc"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:idno[@type='gnd']">
                    <tr>
                        <th>
                            GND
                        </th>
                        <td>
                            <a href="{./tei:idno[@type='gnd']}" target="_blank">
                                <xsl:value-of select="tokenize(./tei:idno[@type='gnd'], '/')[last()]"/>
                            </a>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:idno[@type='WIKIDATA']">
                    <tr>
                        <th>
                            Wikidata ID
                        </th>
                        <td>
                            <a href="{./tei:idno[@type='WIKIDATA']}" target="_blank">
                                <xsl:value-of select="tokenize(./tei:idno[@type='WIKIDATA'], '/')[last()]"/>
                            </a>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:idno[@type='GEONAMES']">
                <tr>
                    <th>
                        Geonames ID
                    </th>
                    <td>
                        <a href="{./tei:idno[@type='GEONAMES']}" target="_blank">
                            <xsl:value-of select="tokenize(./tei:idno[@type='GEONAMES'], '/')[4]"/>
                        </a>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:note">
                    <tr>
                        <th>
                            Notiz
                        </th>
                        <td>
                            <xsl:if test="starts-with(./tei:note/text(), 'http')">
                                <a href="{./tei:note/text()}">
                                    <xsl:value-of select="./tei:note"/>
                                </a>
                            </xsl:if>
                            
                        </td>
                    </tr>
                </xsl:if>
                
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
