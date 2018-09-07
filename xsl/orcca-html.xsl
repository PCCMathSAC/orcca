<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Thin layer on MathBook XML -->
<xsl:import href="../../mathbook/xsl/mathbook-html.xsl" />

<!-- Temporary hack until mathbook can handle sidebyside within webwork -->
<xsl:template match="image[ancestor::sidebyside][ancestor::webwork]" mode="get-width-percentage">
    <xsl:value-of select="parent::sidebyside/@widths" />
</xsl:template>

</xsl:stylesheet>
