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

<xsl:param name="tableheader.color">#A1E061</xsl:param>

</xsl:stylesheet>
