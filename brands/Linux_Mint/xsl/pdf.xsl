<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<xsl:import href="/usr/share/publican/xsl/pdf.xsl" />

<xsl:template name="table.cell.block.properties">
  <!-- highlight this entry? -->
  <xsl:if test="ancestor::thead or ancestor::tfoot">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
	<xsl:attribute name="background-color"><xsl:value-of select="$tableheader.color"/></xsl:attribute>
	<xsl:attribute name="color">white</xsl:attribute>
  </xsl:if>
</xsl:template>

<xsl:template name="table.row.properties">
  <xsl:variable name="bgcolor">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="pis" select="processing-instruction('dbfo')"/>
      <xsl:with-param name="attribute" select="'bgcolor'"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:if test="$bgcolor != ''">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$bgcolor"/>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="ancestor::thead or ancestor::tfoot">
	<xsl:attribute name="background-color"><xsl:value-of select="$tableheader.color"/></xsl:attribute>
  </xsl:if>
</xsl:template>

<xsl:param name="tableheader.color">#3c3c3c</xsl:param>
<xsl:param name="title.color">#3c3c3c</xsl:param>

<xsl:attribute-set name="admonition.title.properties">
  <xsl:attribute name="padding-left">0em</xsl:attribute>
  <xsl:attribute name="padding-bottom">0em</xsl:attribute>
  <xsl:attribute name="margin-left">0em</xsl:attribute>
  <xsl:attribute name="margin-bottom">0em</xsl:attribute>
  <xsl:attribute name="text-indent">3em</xsl:attribute>
  <xsl:attribute name="font-size">13pt</xsl:attribute>
  <xsl:attribute name="color">#eeeeec</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">true</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  <xsl:attribute name="background-color">
    <xsl:choose>
    <xsl:when test="local-name(.)='note'">
      <xsl:text>#3c3c3c</xsl:text>
    </xsl:when>
    <xsl:when test="local-name(.)='important'">
      <xsl:text>#d08e13</xsl:text>
    </xsl:when>
    <xsl:when test="local-name(.)='warning'">
      <xsl:text>#9e0000</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>#dddddd</xsl:text>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

</xsl:stylesheet>
