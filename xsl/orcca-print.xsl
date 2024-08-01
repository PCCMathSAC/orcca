<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:str="http://exslt.org/strings"
    xmlns:pi="http://pretextbook.org/2020/pretext/internal"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    extension-element-prefixes="exsl date str"
    exclude-result-prefixes="pi"
>

<!-- Thin layer on MathBook XML -->
<xsl:import href="../../pretext/xsl/pretext-latex.xsl" />

<!-- Intend output for rendering by xelatex -->
<xsl:output method="text" />

<!-- Omit objectives, CCOGs, worksheets -->
<xsl:template match="objectives" />
<xsl:template match="appendix[@xml:id='appendix-ccogs']" />
<xsl:template match="worksheet" />

<!-- Omit alternative video lessons; important to increment counter -->
<xsl:template match="figure[contains(child::caption,'Alternative Video Lesson')]">
    <xsl:text>&#xa;\noindent\hskip0pt\begin{minipage}{360pt}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\parmarginbox{\begin{qrptx}</xsl:text>
    <xsl:text>\begin{image}</xsl:text>
    <xsl:text>{0</xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:text>{1</xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:text>{0</xsl:text>
    <xsl:text>}{}%&#xa;</xsl:text>
    <xsl:apply-templates select=".//image[contains(@pi:generated,'qrcode')]" mode="image-inclusion" />
    <xsl:text>\end{image}\tcblower&#xa;</xsl:text>
    <xsl:text>\scshape Video Lessons\end{qrptx}%&#xa;</xsl:text>
    <xsl:text>}{0pt}&#xa;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\end{minipage}&#xa;&#xa;</xsl:text>
</xsl:template>

<!-- Omit solutions/answers -->
<xsl:template match="solutions"/>

<!-- This version for print -->
<xsl:param name="latex.preamble.early" select="concat(document('latex-preamble/latex.preamble.xml')//latex-preamble-early, document('latex-preamble/print.preamble.xml')//latex-preamble-early)" />
<xsl:param name="latex.preamble.late" select="concat(document('latex-preamble/latex.preamble.xml')//latex-preamble-late, document('latex-preamble/print.preamble.xml')//latex-preamble-late)" />

<!-- boxes for answer blanks -->
<xsl:param name="latex.fillin.style" select="'box'"/>

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
<!-- Exercise Group -->
<!-- We interrupt a run of exercises with short commentary, -->
<!-- typically instructions for a list of similar exercises -->
<!-- Commentary goes in an introduction and/or conclusion   -->
<!-- When we point to these, we use custom hypertarget, etc -->
<xsl:template match="exercisegroup[count(exercise)>1][not(exercise[not(webwork-reps)])][exercise/webwork-reps][count(exercise/webwork-reps/static/statement[not(p[1] = ancestor::exercise/preceding-sibling::exercise/webwork-reps/static/statement/p[1])]) = 1]">
    <xsl:text>\par\medskip\noindent%&#xa;</xsl:text>
    <xsl:if test="title">
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates select="." mode="title-full" />
        <xsl:text>}\space\space</xsl:text>
    </xsl:if>
    <xsl:if test="@xml:id">
        <xsl:apply-templates select="." mode="label"/>
    </xsl:if>
    <xsl:text>%&#xa;</xsl:text>
    <xsl:if test="not(title)">
        <xsl:text>\hrulefill\\%&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="introduction" />
    <xsl:apply-templates select="exercise[1]/webwork-reps/static/statement/p[1]" />
    <xsl:choose>
        <xsl:when test="not(@cols) or (@cols = 1)">
            <xsl:text>\begin{exercisegroup}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="@cols = 2 or @cols = 3 or @cols = 4 or @cols = 5 or @cols = 6">
            <xsl:text>\begin{exercisegroupcol}</xsl:text>
            <xsl:text>{</xsl:text>
            <xsl:value-of select="@cols"/>
            <xsl:text>}&#xa;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:message terminate="yes">MBX:ERROR: invalid value <xsl:value-of select="@cols" /> for cols attribute of exercisegroup</xsl:message>
        </xsl:otherwise>
    </xsl:choose>
    <!-- an exercisegroup can only appear in an "exercises" division,    -->
    <!-- the template for exercises//exercise will consult switches for  -->
    <!-- visibility of components when born (not doing "solutions" here) -->
    <xsl:apply-templates select="exercise"/>
    <xsl:choose>
        <xsl:when test="not(@cols) or (@cols = 1)">
            <xsl:text>\end{exercisegroup}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="@cols = 2 or @cols = 3 or @cols = 4 or @cols = 5 or @cols = 6">
            <xsl:text>\end{exercisegroupcol}&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>
    <xsl:if test="conclusion">
        <xsl:text>\par\noindent%&#xa;</xsl:text>
        <xsl:apply-templates select="conclusion" />
    </xsl:if>
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

<!-- Except when the above is only containing an answer blank and nothing else... -->
<xsl:template match="p[not(normalize-space(text()))][count(fillin)=1 and count(*)=1][not(parent::li)]|p[not(normalize-space(text()))][count(fillin)=1 and count(*)=1][parent::li][preceding-sibling::*]" />



<!-- When a p in a webwork-reps only contains m math, in certain conditions, use display math. -->
<!--<xsl:template match="webwork-reps//p[position()>1][not(count(ancestor::exercisegroup/exercise/webwork-reps/static/statement[not(p[1] = ancestor::exercise/preceding-sibling::exercise/webwork-reps/static/statement/p[1])]) = 1)][count(*)=1][not(text())][count(m)=1][contains(m,'\displaystyle') or contains(m,'\begin{aligned')]">
    <xsl:text>\[</xsl:text>
    <xsl:apply-templates select="m/text()" />
    <xsl:text>\]</xsl:text>
</xsl:template>

<xsl:template match="p[not(normalize-space(text()))][count(fillin)=1 and count(*)=1][not(parent::li)]|p[not(normalize-space(text()))][count(fillin)=1 and count(*)=1][parent::li][preceding-sibling::*]" />
-->


<!-- wide exercises -->
<!-- <xsl:template match="exercises//exercise"> -->
    <!-- heading, start enclosure/environment                    -->
    <!-- This environment is different within an "exercisegroup" -->
    <!-- Using only serial number since born here                -->
<!--     <xsl:choose>
        <xsl:when test="parent::exercisegroup">
            <xsl:text>\exercise</xsl:text>
            <xsl:if test="@width='wide'">
                <xsl:text>!</xsl:text>
            </xsl:if>
            <xsl:text>[</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>.] </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>\begin{divisionexercise}</xsl:text>
            <xsl:text>{</xsl:text>
            <xsl:apply-templates select="." mode="serial-number" />
            <xsl:text>}</xsl:text>
            <xsl:apply-templates select="title" mode="environment-option" />
        </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="." mode="label"/>
    <xsl:text>&#xa;</xsl:text> -->
    <!-- Allow a webwork or myopenmath exercise to introduce/connect    -->
    <!-- a problem (especially from server) to the text in various ways -->
<!--     <xsl:if test="webwork-reps|myopenmath">
        <xsl:apply-templates select="introduction"/>
    </xsl:if>
 -->    <!-- condition on how statement, hint, answer, solution are presented -->
    <!-- <xsl:choose> -->
        <!-- webwork, structured with "stage" matches first -->
<!--         <xsl:when test="webwork-reps/static/stage">
            <xsl:apply-templates select="webwork-reps/static/stage">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="true()" />
                <xsl:with-param name="b-has-hint"      select="$b-has-divisional-hint" />
                <xsl:with-param name="b-has-answer"    select="$b-has-divisional-answer" />
                <xsl:with-param name="b-has-solution"  select="$b-has-divisional-solution" />
            </xsl:apply-templates>
        </xsl:when>
 -->        <!-- webwork exercise, no "stage" -->
<!--         <xsl:when test="webwork-reps/static">
            <xsl:apply-templates select="webwork-reps/static" mode="exercise-components">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="true()" />
                <xsl:with-param name="b-has-hint"      select="$b-has-divisional-hint" />
                <xsl:with-param name="b-has-answer"    select="$b-has-divisional-answer" />
                <xsl:with-param name="b-has-solution"  select="$b-has-divisional-solution" />
            </xsl:apply-templates>
        </xsl:when>
 -->        <!-- myopenmath exercise -->
        <!-- We only try to open an external file when the source  -->
        <!-- has a MOM problem (with an id number).  The second    -->
        <!-- argument of the "document()" function is a node and   -->
        <!-- causes the relative file name to resolve according    -->
        <!-- to the location of the XML.   Experiments with the    -->
        <!-- empty node "/.." are interesting.                     -->
        <!-- https://ajwelch.blogspot.co.za/2008/04/relative-paths-and-document-function.html -->
        <!-- http://www.dpawson.co.uk/xsl/sect2/N2602.html#d3862e73 (Point 4) -->
<!--         <xsl:when test="myopenmath">
            <xsl:variable name="filename" select="concat(concat('problems/mom-', myopenmath/@problem), '.xml')" />
            <xsl:apply-templates select="document($filename, .)/myopenmath"  mode="exercise-components">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="true()" />
                <xsl:with-param name="b-has-hint"      select="false()" />
                <xsl:with-param name="b-has-answer"    select="false()" />
                <xsl:with-param name="b-has-solution"  select="$b-has-divisional-solution" />
            </xsl:apply-templates>
        </xsl:when>
 -->        <!-- "normal" exercise, unstructured -->
<!--         <xsl:when test="not(statement)">
 -->            <!-- eventually pass b-original? -->
<!--             <xsl:apply-templates select="*" />
        </xsl:when>
 -->        <!-- "normal" exercise, structured -->
<!--         <xsl:otherwise>
            <xsl:apply-templates select="." mode="exercise-components">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="true()" />
                <xsl:with-param name="b-has-hint"      select="$b-has-divisional-hint" />
                <xsl:with-param name="b-has-answer"    select="$b-has-divisional-answer" />
                <xsl:with-param name="b-has-solution"  select="$b-has-divisional-solution" />
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
 -->    <!-- Allow a webwork or myopenmath exercise to conclude/connect     -->
    <!-- a problem (especially from server) to the text in various ways -->
<!--     <xsl:if test="webwork-reps|myopenmath">
        <xsl:apply-templates select="conclusion"/>
    </xsl:if>
 -->    <!-- end enclosure/environment                               -->
    <!-- This environment is different within an "exercisegroup" -->
<!--     <xsl:choose>
        <xsl:when test="parent::exercisegroup" />
 -->        <!-- closing % necessary, as newline between adjacent environments -->
        <!-- will cause a slight indent on trailing exercise               -->
<!--         <xsl:otherwise>
            <xsl:text>\end{divisionexercise}%</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;</xsl:text>
</xsl:template>
 -->

<!-- For an ol that was in a webwork that was authored in PTX source, -->
<!-- if there was a @cols, it has not survived the extraction. So go  -->
<!-- looking for the @cols from the authored source.                  -->
<xsl:template match="ol[ancestor::webwork-reps/authored]">
    <xsl:choose>
        <xsl:when test="not(ancestor::ol or ancestor::ul or ancestor::dl or parent::objectives or parent::outcomes)">
            <xsl:call-template name="leave-vertical-mode" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>%&#xa;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <!-- what number ol is this in static output? -->
    <xsl:variable name="nth-ol">
        <xsl:number from="static" level="any"/>
    </xsl:variable>
    <!-- get all the ol's from the authored -->
    <xsl:variable name="authored-ols" select="ancestor::webwork-reps/authored//ol"/>
    <!-- find that same number ol in authored source and get its @cols, if that exists -->
    <xsl:variable name="cols">
        <xsl:choose>
            <xsl:when test="$authored-ols[position()=$nth-ol]/@cols">
                <xsl:value-of select="$authored-ols[position()=$nth-ol]/@cols"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>1</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:if test="$cols != '1'">
        <xsl:text>\begin{multicols}{</xsl:text>
        <xsl:value-of select="$cols" />
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>\begin{enumerate}</xsl:text>
    <!-- override LaTeX defaults as indicated -->
    <xsl:if test="@label or ancestor::exercises or ancestor::worksheet or ancestor::reading-questions or ancestor::references">
        <xsl:text>[label=</xsl:text>
        <xsl:apply-templates select="." mode="latex-list-label" />
        <xsl:text>]</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
     <xsl:apply-templates />
    <xsl:text>\end{enumerate}&#xa;</xsl:text>
    <xsl:if test="$cols != '1'">
        <xsl:text>\end{multicols}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="image[
        not(ancestor::sidebyside)
        and (descendant::latex-image or descendant::asymptote)
        and not(ancestor::exercises)
        and not(ancestor::remark)
        and not(ancestor::figure)
        and not(ancestor::assemblage)
    ]">
  <!-- <xsl:choose> -->
    <!-- <xsl:when test="ancestor::figure/@vshift"> -->
      <xsl:text>\begin{image}</xsl:text>
      <xsl:text>{0</xsl:text>
      <xsl:text>}</xsl:text>
      <xsl:text>{1</xsl:text>
      <xsl:text>}</xsl:text>
      <xsl:text>{0</xsl:text>
      <xsl:text>}{}%&#xa;</xsl:text>
      <xsl:apply-templates select="." mode="image-inclusion" />
      <xsl:text>\end{image}%&#xa;</xsl:text>
    <!-- </xsl:when> -->
    <!-- <xsl:otherwise>
      <xsl:variable name="rtf-layout">
        <xsl:apply-templates select="." mode="layout-parameters" />
      </xsl:variable>
      <xsl:variable name="layout" select="exsl:node-set($rtf-layout)" />
      <xsl:text>\begin{image}</xsl:text>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$layout/left-margin div 100"/>
      <xsl:text>}</xsl:text>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$layout/width div 100"/>
      <xsl:text>}</xsl:text>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$layout/right-margin div 100"/>
      <xsl:text>}</xsl:text>
      <xsl:text>{</xsl:text>
      <xsl:apply-templates select="." mode="vertical-adjustment"/>
      <xsl:text>}%&#xa;</xsl:text>
      <xsl:apply-templates select="." mode="image-inclusion" />
      <xsl:text>\end{image}%&#xa;</xsl:text>
    </xsl:otherwise> -->
  <!-- </xsl:choose>  -->
</xsl:template>

<!-- move vshift figures/images to the margin -->
<!-- <xsl:template match="figure">
  <xsl:if test="(@hskip) and ($b-latex-two-sides)">
      <xsl:text>&#xa;\noindent\hskip-</xsl:text>
      <xsl:value-of select="@hskip"/>
      <xsl:text>pt\begin{minipage}{</xsl:text>
      <xsl:value-of select="@minisize"/>
      <xsl:text>pt}</xsl:text>
    </xsl:if>
    <xsl:if test="@vshift">
      <xsl:text>&#xa;</xsl:text>
      <xsl:choose>
        <xsl:when test="ancestor::example and not(ancestor::ul or ancestor::ol)">
          <xsl:text>\tcbmarginbox{%&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="(ancestor::example or ancestor::theorem) and (ancestor::ul or ancestor::ol)">
          <xsl:text>\listmarginbox{%&#xa;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>\parmarginbox{%&#xa;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@hstretch">
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>{\tcbset{text width=</xsl:text>
        <xsl:value-of select="@hstretch"/>
      <xsl:text>pt}&#xa;</xsl:text>  
    </xsl:if>
    <xsl:apply-imports/>
    <xsl:if test="@vshift">
      <xsl:text>}{</xsl:text><xsl:value-of select="@vshift"/><xsl:text>cm}&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="@hstretch">
      <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="@hskip">
    <xsl:text>\end{minipage}&#xa;&#xa;</xsl:text>
  </xsl:if>
</xsl:template> -->
<xsl:template match="image[
        (ancestor::exercise)
        and (parent::statement or parent::introduction or parent::solution)
        and (@width != '100%')
        and (not(ancestor::exercises) or ancestor::introduction)
    ]
    |image[
        not(parent::figure)
        and ancestor::example
        and (@width != '100%')
        and not(ancestor::sidebyside)
    ]
    |image[
        (parent::introduction/parent::exercisegroup)
        and (@width != '100%')
    ]">
    <xsl:text>&#xa;&#xa;\noindent\hskip-30pt\begin{minipage}{400pt}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\parmarginbox{%&#xa;</xsl:text>
    <xsl:text>\begin{image}</xsl:text>
    <xsl:text>{0</xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:text>{1</xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:text>{0</xsl:text>
    <xsl:text>}{}%&#xa;</xsl:text>
    <xsl:apply-templates select="." mode="image-inclusion" />
    <xsl:text>\end{image}%&#xa;</xsl:text>
    <xsl:text>}{0pt}&#xa;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:text>\end{minipage}&#xa;&#xa;</xsl:text>
</xsl:template>

<!-- Kill tabulars that are from "is 5 a solution to ___" exericses -->
<xsl:template match="tabular[descendant::fillin and contains(.,'wonder')]"/>
<xsl:template match="tabular[ancestor::exercisegroup and (count(descendant::fillin) &gt; 4) and preceding-sibling::p]"/>

<!-- Shift certain tabulars up and kill centering -->
<xsl:template match="tabular[
        not(ancestor::sidebyside)
        and not(@margins)
        and not(@width)
        and not(parent::table)
        and not(preceding-sibling::*)
        and parent::statement
    ]">
    <xsl:apply-templates select="." mode="tabular-inclusion"/>
    <xsl:text>\par%&#xa;</xsl:text>
</xsl:template>

<!-- this only differs from pretext-latex version by match criterion and [t] on tabular-->
<xsl:template match="tabular[
        not(ancestor::sidebyside)
        and not(@margins)
        and not(@width)
        and not(parent::table)
        and not(preceding-sibling::*)
        and parent::statement
    ]" mode="tabular-inclusion">
    <!-- Abort if tabular's cols have widths summing to over 100% -->
    <xsl:call-template name="cap-width-at-one-hundred-percent">
        <xsl:with-param name="nodeset" select="col/@width" />
    </xsl:call-template>
    <!-- Determine global, table-wide properties -->
    <!-- set defaults here if values not given   -->
    <xsl:variable name="table-top">
        <xsl:choose>
            <xsl:when test="@top">
                <xsl:value-of select="@top" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="table-left">
        <xsl:choose>
            <xsl:when test="@left">
                <xsl:value-of select="@left" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="table-bottom">
        <xsl:choose>
            <xsl:when test="@bottom">
                <xsl:value-of select="@bottom" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="table-right">
        <xsl:choose>
            <xsl:when test="@right">
                <xsl:value-of select="@right" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="table-halign">
        <xsl:choose>
            <xsl:when test="@halign">
                <xsl:value-of select="@halign" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>left</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="table-valign">
        <xsl:choose>
            <xsl:when test="@valign">
                <xsl:value-of select="@valign" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>middle</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- set environment based on breakability -->
    <xsl:variable name="tabular-environment">
        <xsl:choose>
            <xsl:when test="@break = 'yes'">
                <xsl:text>longtable</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>tabular</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- get a newline if inside a "stack" -->
    <xsl:if test="parent::stack and preceding-sibling::*">
        <xsl:text>\par&#xa;</xsl:text>
    </xsl:if>
    <!-- center within a sidebyside if by itself       -->
    <!-- \centering needs a closing \par within a      -->
    <!-- defensive group if it is to be effective      -->
    <!-- https://tex.stackexchange.com/questions/23650 -->
    <!-- Necessary for both sidebyside/tabular AND sidebyside/table/tabular -->
    <!-- Does latter get a double-nested centering?                         -->
    <!-- Maybe this goes away with tcolorbox?                               -->
    <!-- NB: paired conditional way below!                                  -->
    <xsl:if test="ancestor::sidebyside">
        <xsl:text>{\centering%&#xa;</xsl:text>
    </xsl:if>
    <!-- Build latex column specification                         -->
    <!--   vertical borders (left side, right side, three widths) -->
    <!--   horizontal alignment (left, center, right)             -->
    <xsl:text>{\tabularfont%&#xa;</xsl:text>
    <xsl:text>\begin{</xsl:text>
    <xsl:value-of select="$tabular-environment"/>
    <xsl:text>}[t]{</xsl:text>
    <!-- start with left vertical border -->
    <xsl:call-template name="vrule-specification">
        <xsl:with-param name="width" select="$table-left" />
    </xsl:call-template>
    <xsl:choose>
        <!-- Potential for individual column overrides    -->
        <!--   Deduce number of columns from col elements -->
        <!--   Employ individual column overrides,        -->
        <!--   or use global table-wide values            -->
        <!--   write alignment (mandatory)                -->
        <!--   follow with right border (optional)        -->
        <xsl:when test="col">
            <xsl:for-each select="col">
                <xsl:call-template name="halign-specification">
                    <xsl:with-param name="align">
                        <xsl:choose>
                            <xsl:when test="@halign">
                                <xsl:value-of select="@halign" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$table-halign" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="vrule-specification">
                    <xsl:with-param name="width">
                        <xsl:choose>
                            <xsl:when test="@right">
                                <xsl:value-of select="@right" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$table-right" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:when>
        <!-- No col specifiaction                                  -->
        <!--   so default identically to global, table-wide values -->
        <!--   first row determines the  number of columns         -->
        <!--   write the alignment (mandatory)                     -->
        <!--   follow with right border (optional)                 -->
        <!-- TODO: error check each row for correct number of columns -->
        <xsl:otherwise>
            <xsl:variable name="ncols" select="count(row[1]/cell) + sum(row[1]/cell[@colspan]/@colspan) - count(row[1]/cell[@colspan])" />
            <xsl:call-template name="duplicate-string">
                <xsl:with-param name="count" select="$ncols" />
                <xsl:with-param name="text">
                    <xsl:call-template name="halign-specification">
                        <xsl:with-param name="align" select="$table-halign" />
                    </xsl:call-template>
                    <xsl:call-template name="vrule-specification">
                        <xsl:with-param name="width" select="$table-right" />
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <!-- column specification done -->
    <!-- top horizontal rule is specified after column specification -->
    <xsl:choose>
        <!-- A col element might indicate top border customizations   -->
        <!-- so we walk the cols to build a cline-style specification -->
        <!-- $clines accumulates the specification when complicated   -->
        <!-- For convenience, recursion passes along the $table-top   -->
        <xsl:when test="col/@top">
            <xsl:apply-templates select="col[1]" mode="column-cols">
                <xsl:with-param name="col-number" select="1" />
                <xsl:with-param name="clines" select="''" />
                <xsl:with-param name="table-top" select="$table-top"/>
                <xsl:with-param name="start-run" select="1" />
            </xsl:apply-templates>
        </xsl:when>
        <!-- with no customization, we have one continuous rule (if at all) -->
        <!-- use global, table-wide value of top specification              -->
        <xsl:otherwise>
            <xsl:call-template name="hrule-specification">
                <xsl:with-param name="width" select="$table-top" />
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
    <!-- now ready to build rows -->
    <xsl:text>&#xa;</xsl:text>
    <!-- table-wide values are needed to reconstruct/determine overrides -->
    <!-- We *actively* enforce header rows being (a) initial, and        -->
    <!-- (b) contiguous.  So following two-part match will do no harm    -->
    <!-- to correct source, but will definitely harm incorrect source.   -->
    <xsl:apply-templates select="row[@header]">
        <xsl:with-param name="table-left" select="$table-left" />
        <xsl:with-param name="table-bottom" select="$table-bottom" />
        <xsl:with-param name="table-right" select="$table-right" />
        <xsl:with-param name="table-halign" select="$table-halign" />
        <xsl:with-param name="table-valign" select="$table-valign" />
    </xsl:apply-templates>
    <xsl:apply-templates select="row[not(@header)]">
        <xsl:with-param name="table-left" select="$table-left" />
        <xsl:with-param name="table-bottom" select="$table-bottom" />
        <xsl:with-param name="table-right" select="$table-right" />
        <xsl:with-param name="table-halign" select="$table-halign" />
        <xsl:with-param name="table-valign" select="$table-valign" />
    </xsl:apply-templates>
    <!-- mandatory finish, exclusive of any final row specifications -->
    <xsl:text>\end{</xsl:text>
    <xsl:value-of select="$tabular-environment"/>
    <xsl:text>}&#xa;</xsl:text>
    <!-- finish grouping for tabular font -->
    <xsl:text>}%&#xa;</xsl:text>
    <xsl:apply-templates select="." mode="pop-footnote-text"/>
    <xsl:if test="ancestor::sidebyside">
        <xsl:text>\par}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>



<!-- Shift certain images up -->
<xsl:template match="image[
        parent::statement
        and ancestor::exercisegroup
        and not(preceding-sibling::*)
        and contains(@pi:generated, 'webwork')
    ]">
      <xsl:text>\begin{image}</xsl:text>
      <xsl:text>{0</xsl:text>
      <xsl:text>}</xsl:text>
      <xsl:text>{1</xsl:text>
      <xsl:text>}</xsl:text>
      <xsl:text>{0</xsl:text>
      <xsl:text>}{}%&#xa;</xsl:text>
      <xsl:apply-templates select="." mode="image-inclusion" />
      <xsl:text>\end{image}%&#xa;</xsl:text>
</xsl:template>

<xsl:template match="fillin[choice]">
    <xsl:apply-templates select="choice"/>
</xsl:template>

<xsl:template match="choice">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::choice">
        <xsl:text>/</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="aside">
    <xsl:text>\marginpar{</xsl:text>
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates select="." mode="title-full"/>
        <xsl:text>} </xsl:text>
        <xsl:apply-templates select="*[not(self::title)]"/>
    <xsl:text>}</xsl:text>
</xsl:template>


<!-- Copied from pretext-latex; ONLY the edge indexing is added -->
<xsl:template match="part|chapter|appendix|section|subsection|subsubsection|acknowledgement|foreword|preface|exercises|solutions|reading-questions|glossary|references|worksheet" mode="latex-division-heading">
    <!-- NB: could be obsoleted, see single use -->
    <xsl:variable name="b-is-specialized" select="boolean(self::exercises|self::solutions[not(parent::backmatter)]|self::reading-questions|self::glossary|self::references|self::worksheet)"/>

    <!-- change geometry if worksheet should be formatted -->
    <xsl:if test="self::worksheet and $b-latex-worksheet-formatted">
        <!-- \newgeometry includes a \clearpage -->
        <xsl:apply-templates select="." mode="new-geometry"/>
    </xsl:if>
    <xsl:if test="self::part">
        <!-- Edge indexing -->
        <!-- <xsl:text>\xpatchcmd{\part}{\thispagestyle{plain}}{</xsl:text>
        <xsl:text>\begin{tikzpicture}[remember picture,overlay]%&#xa;</xsl:text>
        <xsl:text>\draw [color=emerald, fill=emerald] ([xshift=-0.625in]current page.north east) rectangle (current page.south east);%&#xa;</xsl:text>
        <xsl:text>\end{tikzpicture}\break\pagenumbering{arabic}\thispagestyle{plain}}{}{}%&#xa;</xsl:text>
        <xsl:text>\xpatchcmd{\@endpart}{\vfil\newpage}{\vfil\newpage}{}{}%&#xa;</xsl:text> -->
    </xsl:if>
    <xsl:text>\begin{</xsl:text>
    <xsl:apply-templates select="." mode="division-environment-name" />
    <!-- possibly numberless -->
    <xsl:apply-templates select="." mode="division-environment-name-suffix" />
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="type-name"/>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="title-full"/>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <!-- subtitle here -->
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="title-short"/>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <!-- author here -->
    <!-- historical, could be relaxed -->
    <xsl:if test="not($b-is-specialized)">
        <xsl:apply-templates select="author" mode="name-list"/>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <!-- epigraph here -->
    <!-- <xsl:text>An epigraph here\\with two lines\\-Rob</xsl:text> -->
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="unique-id" />
    <xsl:text>}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <!-- Various LaTeX classes and packages define various names, see   -->
    <!-- two links below.  The ones redefined here seem critical for    -->
    <!-- how the "titleps" package makes heads and foots, in concert    -->
    <!-- with the "titlesec" package.  We want these to change to the   -->
    <!-- right language when a division indicates a different language. -->
    <!-- NB: not clear if this should be after, or before, the \begin{} -->
    <!-- of the environment.  In other words, when is the head/foot     -->
    <!-- manufactured?                                                  -->
    <!-- https://texfaq.org/FAQ-fixnam -->
    <!-- http://tex.stackexchange.com/questions/62020/how-to-change-the-word-proof-in-the-proof-environment -->
    <!-- https://tex.stackexchange.com/questions/82993/how-to-change-the-name-of-document-elements-like-figure-contents-bibliogr -->
    <xsl:if test="self::part">
        <xsl:text>\renewcommand*{\partname}{</xsl:text>
        <xsl:apply-templates select="." mode="type-name"/>
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="self::chapter">
        <!-- Edge indexing -->
        <xsl:variable name="chapter-number">
            <xsl:apply-templates select="." mode="serial-number"/>
        </xsl:variable>
        <xsl:text>\begin{tikzpicture}[remember picture,overlay]&#xa;</xsl:text>
        <xsl:text>\node (A) at ( $ (current page.north east) - (0,0.125) $ ) {};&#xa;</xsl:text>
        <xsl:text>\node (B) at ( $ (current page.south east) + (0,0.125) $ ) {};&#xa;</xsl:text>
        <xsl:text>\draw [color=emerald, fill=emerald] ([xshift=-0.625in] $ (A)!</xsl:text>
        <xsl:value-of select="$chapter-number"/>
        <xsl:text>/13-1/13!(B) $ ) rectangle ( $ (A)!</xsl:text>
        <xsl:value-of select="$chapter-number"/>
        <xsl:text>/13!(B) $ );&#xa;</xsl:text>
        <xsl:text>\end{tikzpicture}&#xa;</xsl:text>
        <xsl:text>\renewcommand*{\chaptername}{</xsl:text>
        <xsl:apply-templates select="." mode="type-name"/>
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="self::appendix">
        <xsl:text>\begin{tikzpicture}[remember picture,overlay]&#xa;</xsl:text>
        <xsl:text>\draw [color=ruby, fill=ruby] ([xshift=-0.625in]current page.north east) rectangle (current page.south east);&#xa;</xsl:text>
        <xsl:text>\end{tikzpicture}&#xa;</xsl:text>
        <xsl:text>\renewcommand*{\appendixname}{</xsl:text>
        <xsl:apply-templates select="." mode="type-name"/>
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>


</xsl:stylesheet>
