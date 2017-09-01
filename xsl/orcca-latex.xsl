<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Thin layer on MathBook XML -->
<xsl:import href="/Users/alex.jordan/mathbook/xsl/mathbook-latex.xsl" />


<!-- Intend output for rendering by xelatex -->
<xsl:output method="text" />

<!-- Omit objectives and CCOGs -->
<xsl:template match="objectives" />
<xsl:template match="appendix[@xml:id='appendix-ccogs']" />

<!-- Omit alternative video lessons; important to increment counter -->
<xsl:template match="figure[contains(child::caption,'Alternative Video Lesson')]">
    <xsl:text>\stepcounter{theorem}&#xa;&#xa;</xsl:text>
</xsl:template>

<!-- Omit solutions to sectional exercises -->
<xsl:template match="webwork[@insec='sectional']//solution" />
<xsl:template match="exercises//solution" />

<xsl:param name="exercise.text.hint" select="'no'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'yes'" />
<xsl:param name="latex.preamble.early" select="concat(document('latex-preamble/latex.preamble.xml')//latex-preamble-early, document('latex-preamble/print.preamble.xml')//latex-preamble-early)" />
<xsl:param name="latex.preamble.late" select="concat(document('latex-preamble/latex.preamble.xml')//latex-preamble-late, document('latex-preamble/print.preamble.xml')//latex-preamble-late)" />

</xsl:stylesheet>
