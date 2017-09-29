<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Thin layer on MathBook XML -->
<xsl:import href="../../mathbook/xsl/mathbook-latex.xsl" />


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

<xsl:template match="exercise" mode="backmatter">
    <xsl:variable name="serial">
        <xsl:apply-templates select="." mode="serial-number" />
    </xsl:variable>
    <xsl:if test="$serial mod 2 = 1">
    <xsl:choose>
        <xsl:when test="webwork-reps/static/stage and (webwork-reps/static/stage/hint or webwork-reps/static/stage/solution)">
            <!-- Lead with the problem number and some space -->
            <xsl:text>\noindent\textbf{</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>.}\quad{}</xsl:text>
            <!-- Within each stage enforce order -->
            <xsl:apply-templates select="webwork-reps/static/stage" mode="backmatter"/>
        </xsl:when>
        <xsl:when test="webwork-reps/static and (webwork-reps/static/hint or webwork-reps/static/solution)">
            <!-- Lead with the problem number and some space -->
            <xsl:text>\noindent\textbf{</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>.}\quad{}</xsl:text>
            <xsl:if test="$exercise.backmatter.statement='yes'">
                <xsl:apply-templates select="webwork-reps/static/statement" />
                <xsl:text>\par\smallskip&#xa;</xsl:text>
            </xsl:if>
            <xsl:if test="webwork-reps/static/hint and $exercise.backmatter.hint='yes'">
                <xsl:apply-templates select="webwork-reps/static/hint" mode="backmatter"/>
            </xsl:if>
            <xsl:if test="webwork-reps/static/solution and $exercise.backmatter.solution='yes'">
                <xsl:apply-templates select="webwork-reps/static/solution" mode="backmatter"/>
            </xsl:if>
        </xsl:when>
        <xsl:when test="hint or answer or solution">
            <!-- Lead with the problem number and some space -->
            <xsl:text>\noindent\textbf{</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>.}\quad{}</xsl:text>
            <xsl:if test="$exercise.backmatter.statement='yes'">
                <!-- TODO: not a "backmatter" template - make one possibly? Or not necessary -->
                <xsl:apply-templates select="statement" />
                <xsl:text>\par\smallskip&#xa;</xsl:text>
            </xsl:if>
            <xsl:if test="//hint and $exercise.backmatter.hint='yes'">
                <xsl:apply-templates select="hint" mode="backmatter" />
            </xsl:if>
            <xsl:if test="answer and $exercise.backmatter.answer='yes'">
                <xsl:apply-templates select="answer" mode="backmatter" />
            </xsl:if>
            <xsl:if test="solution and $exercise.backmatter.solution='yes'">
                <xsl:apply-templates select="solution" mode="backmatter" />
            </xsl:if>
        </xsl:when>
    </xsl:choose>
    </xsl:if>
</xsl:template>


</xsl:stylesheet>
