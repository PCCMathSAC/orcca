<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Thin layer on MathBook XML -->
<xsl:import href="../../mathbook/xsl/mathbook-html.xsl" />

<!-- temporary hack to fix a mathbook bug -->
<xsl:template match="webwork/hint|webwork/solution" mode="structure-number">
    <xsl:apply-templates select="parent::webwork/parent::*" mode="number" />
</xsl:template>

<xsl:template match="webwork/stage/hint|webwork/stage/solution" mode="structure-number">
    <xsl:apply-templates select="parent::stage/parent::webwork/parent::*" mode="number" />
</xsl:template>

</xsl:stylesheet>
