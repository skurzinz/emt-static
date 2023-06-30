<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:wfw="http://wellformedweb.org/CommentAPI/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
    xmlns:slash="http://purl.org/rss/1.0/modules/slash/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//channel/title[1]/text()"/>
        </xsl:variable>
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
                            <xsl:for-each select=".//item">
                                <div class="card">
                                    <div class="card-header" style="text-align:center">
                                        <h2><xsl:value-of select="./title"/></h2>
                                        <h3><xsl:value-of select="./dc:creator" disable-output-escaping="yes"/></h3>
                                        <xsl:for-each select="./category">
                                            <span class="badge badge-primary p-1 m-1"><xsl:value-of select="." disable-output-escaping="yes"/></span>
                                        </xsl:for-each>
                                    </div>
                                    <div class="card-body">
                                        <xsl:value-of select="./description" disable-output-escaping="yes"/>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
   
</xsl:stylesheet>