<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>

    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/osd-container.xsl"/>
    <xsl:import href="./partials/tei-facsimile.xsl"/>
    <xsl:import href="./partials/person.xsl"/>
    <xsl:import href="./partials/place.xsl"/>
    <xsl:import href="./partials/org.xsl"/>

    <xsl:variable name="iiifBase" select="'https://viewer.acdh.oeaw.ac.at/viewer/api/v1/records/'"/>
    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="folderName">
        <xsl:value-of select="replace(replace($teiSource, '.xml', ''), 'kasten', 'Kasten')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:title[@type = 'label'][1]/text()"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type = 'main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"/>
            </xsl:call-template>

            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div>
                        <div class="card" data-index="true">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-2">
                                        <xsl:if test="ends-with($prev, '.html')">
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
                                    <div class="col-md-8">
                                        <h1 align="center">
                                            <xsl:value-of select="$doc_title"/>
                                        </h1>
                                        <h3 align="center">
                                            <a href="{$teiSource}">
                                                <i class="fas fa-download" title="show TEI source"/>
                                            </a>
                                        </h3>
                                    </div>
                                    <div class="col-md-2" style="text-align:right">
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
                            </div>
                            <div class="card-body">

                                <xsl:for-each select=".//tei:div[@type='page']">
                                    <xsl:variable name="pbFacs">
                                        <xsl:value-of
                                            select="replace(data(./tei:pb/@xml:id), '.jpg', '')"
                                        />
                                    </xsl:variable>
                                    <xsl:variable name="pbFolio" as="node()">
                                        <xsl:value-of
                                            select="data(./tei:pb/@n)"
                                        />
                                    </xsl:variable>
                                    <xsl:variable name="openSeadragonId">
                                        <xsl:value-of select="concat('os-id-', position())"/>
                                    </xsl:variable>
                                    <xsl:variable name="facs-url"
                                        select="normalize-space(concat($iiifBase, $folderName, '/files/images/', $pbFacs, '.jpg/info.json'))"/>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h5>
                                                <xsl:value-of select="$pbFolio"/>
                                            </h5>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div id="{$openSeadragonId}" style="height:700px; padding:2em">
                                                <script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/3.0.0/openseadragon.min.js"/>
                                                <script type="text/javascript">
                                                    var viewer = OpenSeadragon({
                                                        id: '<xsl:value-of select="$openSeadragonId"/>',
                                                        prefixUrl: "https://cdnjs.cloudflare.com/ajax/libs/openseadragon/3.0.0/images/",
                                                        defaultZoomLevel: 0,
                                                        fitHorizontally: true,
                                                        tileSources:['<xsl:value-of select="normalize-space($facs-url)"/>'],
                                                    // Initial rotation angle
                                                    degrees: 0,
                                                    // Show rotation buttons
                                                    showRotationControl: true,
                                                    // Enable touch rotation on tactile devices
                                                    gestureSettingsTouch: {
                                                        pinchRotate: true
                                                    }
                                                });</script>
                                            </div>
                                        </div>
                                        <div class="col-md-6 editionstext">
                                            <xsl:apply-templates/>
                                        </div>
                                    </div>
                                    <div class="row"><div class="col-md-12"><hr /></div></div>
                                </xsl:for-each>

                            </div>
                            <div class="card-footer">
                                <p style="text-align:center;">
                                    <xsl:for-each select=".//tei:note[not(./tei:p)]">
                                        <div class="footnotes" id="{local:makeId(.)}">
                                            <xsl:element name="a">
                                                <xsl:attribute name="name">
                                                  <xsl:text>fn</xsl:text>
                                                  <xsl:number level="any" format="1"
                                                  count="tei:note"/>
                                                </xsl:attribute>
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:text>#fna_</xsl:text>
                                                  <xsl:number level="any" format="1"
                                                  count="tei:note"/>
                                                  </xsl:attribute>
                                                  <span
                                                  style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                                  <xsl:number level="any" format="1"
                                                  count="tei:note"/>
                                                  </span>
                                                </a>
                                            </xsl:element>
                                            <xsl:apply-templates/>
                                        </div>
                                    </xsl:for-each>
                                </p>
                            </div>
                        </div>
                    </div>
                    <xsl:for-each select=".//tei:back//tei:org[@xml:id]">

                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                            <xsl:attribute name="id">
                                <xsl:value-of select="./@xml:id"/>
                            </xsl:attribute>
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of select=".//tei:orgName[1]/text()"/>
                                        </h5>

                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="org_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:person[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>

                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"
                            id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of
                                                select="normalize-space(string-join(.//tei:persName[1]//text()))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"/>
                                            </a>
                                        </h5>

                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="person_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select=".//tei:back//tei:place[@xml:id]">
                        <xsl:variable name="xmlId">
                            <xsl:value-of select="data(./@xml:id)"/>
                        </xsl:variable>

                        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"
                            id="{$xmlId}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <xsl:value-of
                                                select="normalize-space(string-join(.//tei:placeName[1]/text()))"/>
                                            <xsl:text> </xsl:text>
                                            <a href="{concat($xmlId, '.html')}">
                                                <i class="fas fa-external-link-alt"/>
                                            </a>
                                        </h5>
                                    </div>
                                    <div class="modal-body">
                                        <xsl:call-template name="place_detail">
                                            <xsl:with-param name="showNumberOfMentions" select="5"/>
                                        </xsl:call-template>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-dismiss="modal">Schließen</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{local:makeId(.)}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{local:makeId(.)}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
</xsl:stylesheet>
