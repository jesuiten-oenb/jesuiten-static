<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">

    <xsl:template match="tei:place" name="place_detail">
        <table class="table entity-table">
            <tbody>
                <xsl:if test="./tei:placeName[@type='alt']">
                    <tr>
                        <th>
                            Alternative Namen
                        </th>
                        <td>
                            <xsl:for-each select="./tei:placeName[@type='alt']">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()"> | </xsl:if>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:location[@type='located_in_place']">
                    <tr>
                        <th>
                            Teil von
                        </th>
                        <td>
                            <ul>
                                <xsl:for-each select="./tei:location[@type='located_in_place']">
                                    
                                    <li>
                                        <a href="{./tei:placeName/@key}.html">
                                            <xsl:value-of select="./tei:placeName"/>
                                        </a>            
                                    </li>
                                    
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if> 
                <xsl:if test="./tei:country">
                <tr>
                    <th>
                        Land
                    </th>
                    <td>
                        <xsl:value-of select="./tei:country"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:settlement">
                <tr>
                    <th>
                        Ortstyp
                    </th>
                    <td>
                        <xsl:value-of select="./tei:settlement/@type"/>, <xsl:value-of select="./tei:desc[@type='entity_type']"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:idno[@type='geonames']">
                <tr>
                    <th>
                        Geonames ID
                    </th>
                    <td>
                        <a href="{./tei:idno[@type='geonames']}" target="_blank">
                            <xsl:value-of select="tokenize(./tei:idno[@type='geonames'], '/')[4]"/>
                        </a>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:idno[@type='wikidata']">
                <tr>
                    <th>
                        Wikidata ID
                    </th>
                    <td>
                        <a href="{./tei:idno[@type='wikidata']}" target="_blank">
                            <xsl:value-of select="tokenize(./tei:idno[@type='wikidata'], '/')[last()]"/>
                        </a>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:idno[@type='GND']">
                <tr>
                    <th>
                        GND ID
                    </th>
                    <td>
                        <a href="{./tei:idno[@type='GND']}" target="_blank">
                            <xsl:value-of select="tokenize(./tei:idno[@type='GND'], '/')[last()]"/>
                        </a>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test=".//tei:location">
                <tr>
                    <th>
                        Latitude
                    </th>
                    <td>
                        <xsl:value-of select="tokenize(./tei:location[1]/tei:geo[1], '\s')[1]"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test=".//tei:location">
                <tr>
                    <th>
                        Longitude
                    </th>
                    <td>
                        <xsl:value-of select="tokenize(./tei:location[1]/tei:geo[1], '\s')[2]"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:noteGrp/tei:note[@type='mentions']">
                    <tr>
                        <th>
                            Erwähnt in
                        </th>
                        <td>
                            <ul>
                                <xsl:for-each select="./tei:noteGrp/tei:note[@type='mentions']">
                                    <li>
                                        <a href="{replace(@target, '.xml', '.html')}">
                                            <xsl:value-of select="./text()"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
