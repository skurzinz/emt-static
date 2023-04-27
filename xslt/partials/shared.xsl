<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:function name="local:makeId" as="xs:string">
        <xsl:param name="currentNode" as="node()"/>
        <xsl:variable name="nodeCurrNr">
            <xsl:value-of select="count($currentNode//preceding-sibling::*) + 1"/>
        </xsl:variable>
        <xsl:value-of select="concat(name($currentNode), '__', $nodeCurrNr)"/>
    </xsl:function>
    
    <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note"/>
            </sup>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <xsl:variable name="reason">
            <xsl:value-of select="@reason"/>
        </xsl:variable>
        <span class="unclear"><abbr title="{$reason}"><xsl:apply-templates/></abbr></span>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    
    <xsl:template match="tei:rs">
        <xsl:variable name="entityType">
            <xsl:choose>
                <xsl:when test="contains(data(@ref), 'person') or ./@type='person'">person</xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="contains(data(@ref), 'place') or ./@type='place'">place</xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="contains(data(@ref), 'org') or ./@type='org'">org</xsl:when>
            </xsl:choose>
            
        </xsl:variable>
        <strong><span>
            <xsl:attribute name="class">
                <xsl:value-of select="concat('entity entity-', $entityType)"/>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:attribute name="data-toggle">modal</xsl:attribute>
                <xsl:attribute name="data-target">
                    <xsl:value-of select="data(@ref)"/>
                    <!-- <xsl:value-of select="concat('#', @key)"/> -->
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </span></strong>
    </xsl:template>
    
    <xsl:template match="tei:choice">
        <abbr>
            <xsl:attribute name="title">
                <xsl:value-of select="./tei:expan/text()"/>
            </xsl:attribute>
            <xsl:value-of select="./tei:abbr"/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:expan"></xsl:template>
    
</xsl:stylesheet>