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
    <xsl:text>\stepcounter{cthm}&#xa;&#xa;</xsl:text>
</xsl:template>

<!-- Omit solutions to sectional exercises -->
<!-- <xsl:template match="webwork[@insec='sectional']//solution" />
<xsl:template match="exercises//solution" /> -->

<xsl:param name="latex.preamble.early" select="concat(document('latex-preamble/latex.preamble.xml')//latex-preamble-early, document('latex-preamble/print.preamble.xml')//latex-preamble-early)" />
<xsl:param name="latex.preamble.late" select="concat(document('latex-preamble/latex.preamble.xml')//latex-preamble-late, document('latex-preamble/print.preamble.xml')//latex-preamble-late)" />

<!--<xsl:template match="exercise" mode="backmatter">
    <xsl:variable name="serial">
        <xsl:apply-templates select="." mode="serial-number" />
    </xsl:variable>
    <xsl:if test="$serial mod 2 = 1">
    <xsl:choose>
        <xsl:when test="webwork-reps/static/stage and (webwork-reps/static/stage/hint or webwork-reps/static/stage/solution)">
-->            <!-- Lead with the problem number and some space -->
<!--            <xsl:text>\noindent\textbf{</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>.}\quad{}</xsl:text>
-->            <!-- Within each stage enforce order -->
<!--            <xsl:apply-templates select="webwork-reps/static/stage" mode="backmatter"/>
        </xsl:when>
        <xsl:when test="webwork-reps/static and (webwork-reps/static/hint or webwork-reps/static/solution)">
-->            <!-- Lead with the problem number and some space -->
<!--            <xsl:text>\noindent\textbf{</xsl:text>
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
-->            <!-- Lead with the problem number and some space -->
<!--            <xsl:text>\noindent\textbf{</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>.}\quad{}</xsl:text>
            <xsl:if test="$exercise.backmatter.statement='yes'">
-->                <!-- TODO: not a "backmatter" template - make one possibly? Or not necessary -->
<!--                <xsl:apply-templates select="statement" />
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
-->

<!--If all exercises are webwork, and if they all open with the same p, then print that p after the introduction. -->
<!--Later, in each such exercise statement, ignore that p -->
<xsl:template match="exercisegroup[count(exercise)>1][not(exercise[not(webwork-reps)])][exercise/webwork-reps][count(exercise/webwork-reps/static/statement[not(p[1] = ancestor::exercise/preceding-sibling::exercise/webwork-reps/static/statement/p[1])]) = 1]">
    <xsl:if test="title">
        <xsl:text>\subparagraph</xsl:text>
        <!-- keep optional title if LaTeX source is re-purposed -->
        <xsl:text>[{</xsl:text>
        <xsl:apply-templates select="." mode="title-simple" />
        <xsl:text>}]</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="title-full" />
        <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="." mode="label" />
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="introduction" />
    <xsl:if test="title or introduction">
        <xsl:text>\par%&#xa;</xsl:text>
    </xsl:if>
    <!-- <xsl:text>For the following exercises: </xsl:text> -->
    <xsl:apply-templates select="exercise[1]/webwork-reps/static/statement/p[1]" />
    <xsl:text>\begin{exercisegroup}(</xsl:text>
    <xsl:choose>
        <xsl:when test="not(@cols)">
            <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:when test="@cols = 1 or @cols = 2 or @cols = 3 or @cols = 4 or @cols = 5 or @cols = 6">
            <xsl:value-of select="@cols"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:message terminate="yes">MBX:ERROR: invalid value <xsl:value-of select="@cols" /> for cols attribute of exercisegroup</xsl:message>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>)&#xa;</xsl:text>
    <xsl:apply-templates select="exercise">
        <xsl:with-param name="b-has-hint" select="$b-has-divisional-hint" />
        <xsl:with-param name="b-has-answer" select="$b-has-divisional-answer" />
        <xsl:with-param name="b-has-solution" select="$b-has-divisional-solution" />
        </xsl:apply-templates>
    <xsl:text>\end{exercisegroup}</xsl:text>
    <xsl:apply-templates select="conclusion" />
    <xsl:text>\par\medskip\noindent&#xa;</xsl:text>
</xsl:template>

<xsl:template match="statement[ancestor::webwork-reps][count(ancestor::exercisegroup/exercise)>1][count(ancestor::exercisegroup/exercise/webwork-reps/static/statement[not(p[1] = ancestor::exercise/preceding-sibling::exercise/webwork-reps/static/statement/p[1])]) = 1]">
    <xsl:apply-templates select="*[not(self::p and position()=1)]" />
</xsl:template>


<!-- When the first common p was moved in exercisegroup statements above, we need the second (new first) p to *not* be preceded by a \par -->
<xsl:template match="p[position()=2][ancestor::webwork-reps][parent::statement][count(ancestor::exercisegroup/exercise/webwork-reps/static/statement[not(p[1] = ancestor::exercise/preceding-sibling::exercise/webwork-reps/static/statement/p[1])]) = 1]">
    <xsl:apply-templates select="." mode="label" />
    <xsl:text>%&#xa;</xsl:text>
    <xsl:apply-templates />
    <xsl:text>%&#xa;</xsl:text>
</xsl:template>


<!-- When a p in a webwork-reps only contains m math, in certain conditions, use display math. -->
<!--<xsl:template match="webwork-reps//p[position()>1][not(count(ancestor::exercisegroup/exercise/webwork-reps/static/statement[not(p[1] = ancestor::exercise/preceding-sibling::exercise/webwork-reps/static/statement/p[1])]) = 1)][count(*)=1][not(text())][count(m)=1][contains(m,'\displaystyle') or contains(m,'\begin{aligned')]">
    <xsl:text>\[</xsl:text>
    <xsl:apply-templates select="m/text()" />
    <xsl:text>\]</xsl:text>
</xsl:template>

<xsl:template match="p[not(normalize-space(text()))][count(fillin)=1 and count(*)=1][not(parent::li)]|p[not(normalize-space(text()))][count(fillin)=1 and count(*)=1][parent::li][preceding-sibling::*]" />
-->

</xsl:stylesheet>
