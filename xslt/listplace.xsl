<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/place.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Ortsregister'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <div class="card">
                            <div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                            </div>
                            <div class="card-body">     
                                <div id="map"/>
                                <table class="table table-striped display" id="myTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Ortsname</th>
                                            <th scope="col">Erwähnungen</th>
                                            <th scope="col">Geonames</th>
                                            <th scope="col">Lat</th>
                                            <th scope="col">Long</th>
                                            <th scope="col">ID</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select=".//tei:place">
                                            <xsl:variable name="id">
                                                <xsl:value-of select="data(@xml:id)"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="concat($id, '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select=".//tei:placeName[1]/text()"/>
                                                    </a> 
                                                </td>
                                                <td>
                                                    <xsl:value-of select="count(.//tei:note[@type='mentions'])"/>
                                                </td>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test=".//tei:idno[@type='GEONAMES']/text()">
                                                            <a>
                                                                <xsl:attribute name="href"><xsl:value-of select=".//tei:idno[@type='GEONAMES']/text()"/></xsl:attribute><xsl:value-of select=".//tei:idno[@type='GEONAMES']/text()"/>
                                                            </a>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            keine ID
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test="./tei:location/tei:geo">
                                                            <xsl:value-of select="tokenize(./tei:location/tei:geo/text(), ' ')[1]"/>
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </td>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test="./tei:location/tei:geo">
                                                            <xsl:value-of select="tokenize(./tei:location/tei:geo/text(), ' ')[last()]"/>
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </td>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="concat($id, '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="$id"/>
                                                    </a> 
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
                        integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
                        crossorigin=""/>
                    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.4.1/dist/MarkerCluster.css"/>
                    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster@1.4.1/dist/MarkerCluster.Default.css"/>
                    <!-- ############### leaflet script ################ -->
                    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
                        integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
                        crossorigin=""></script>
                    <script src="https://unpkg.com/leaflet.markercluster@1.4.1/dist/leaflet.markercluster.js"></script>
                    <script src="js/dt_map.js">
                        
                    </script>
                </div>
            </body>
        </html>
        <xsl:for-each select=".//tei:place">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="./tei:placeName[1]/text()"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                    </xsl:call-template>
                    
                    <body class="page">
                        <div class="hfeed site" id="page">
                            <xsl:call-template name="nav_bar"/>
                            
                            <div class="container-fluid">
                                <div class="card">
                                    <div class="card-header">
                                        <h1 align="center">
                                            <xsl:value-of select="$name"/>
                                        </h1>
                                    </div>
                                    <div class="card-body">
                                        <xsl:call-template name="place_detail"/>
                                    </div>
                                </div>
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>