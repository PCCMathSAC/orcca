<?xml version='1.0'?> <!-- As XML file -->

<!--********************************************************************
Copyright 2018 Robert A. Beezer

This file is part of PreTeXt.

MathBook XML is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 or version 3 of the
License (at your option).

MathBook XML is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with MathBook XML.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************-->

<!-- http://pimpmyxslt.com/articles/entity-tricks-part2/ -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "../../mathbook/xsl/entities.ent">
    %entities;
]>

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="exsl date str"
>

<xsl:import href="./orcca-latex.xsl" />

<!-- Intend output for rendering by pdflatex -->
<xsl:output method="text" />

<!-- hints, answers, solutions -->
<xsl:param name="exercise.inline.statement" select="'no'" />
<xsl:param name="exercise.inline.hint" select="'no'" />
<xsl:param name="exercise.inline.answer" select="'no'" />
<xsl:param name="exercise.inline.solution" select="'no'" />
<xsl:param name="exercise.divisional.statement" select="'no'" />
<xsl:param name="exercise.divisional.hint" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'yes'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />
<xsl:param name="exercise.worksheet.statement" select="'no'" />
<xsl:param name="exercise.worksheet.hint" select="'no'" />
<xsl:param name="exercise.worksheet.answer" select="'no'" />
<xsl:param name="exercise.worksheet.solution" select="'no'" />
<xsl:param name="exercise.reading.statement" select="'no'" />
<xsl:param name="exercise.reading.hint" select="'no'" />
<xsl:param name="exercise.reading.answer" select="'no'" />
<xsl:param name="exercise.reading.solution" select="'no'" />
<xsl:param name="project.statement" select="'no'" />
<xsl:param name="project.hint" select="'no'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'no'" />

<xsl:param name="latex.geometry" select="'papersize={8.5in,11in},total={6.5in,9in}'"/>

<xsl:param name="latex.preamble.early" select="document('latex-preamble/latex.preamble.xml')//latex-preamble-early" />
<xsl:param name="latex.preamble.late" select="document('latex-preamble/latex.preamble.xml')//latex-preamble-late" />


<!-- These variables are interpreted in mathbook-common.xsl and  -->
<!-- so may be used/set in a custom XSL stylesheet for a         -->
<!-- project's solution manual.                                  -->
<!--                                                             -->
<!-- exercise.inline.statement                                   -->
<!-- exercise.inline.hint                                        -->
<!-- exercise.inline.answer                                      -->
<!-- exercise.inline.solution                                    -->
<!-- exercise.divisional.statement                               -->
<!-- exercise.divisional.hint                                    -->
<!-- exercise.divisional.answer                                  -->
<!-- exercise.divisional.solution                                -->
<!-- exercise.worksheet.statement                                -->
<!-- exercise.worksheet.hint                                     -->
<!-- exercise.worksheet.answer                                   -->
<!-- exercise.worksheet.solution                                 -->
<!-- exercise.reading.statement                                  -->
<!-- exercise.reading.hint                                       -->
<!-- exercise.reading.answer                                     -->
<!-- exercise.reading.solution                                   -->
<!-- project.statement                                           -->
<!-- project.hint                                                -->
<!-- project.answer                                              -->
<!-- project.solution                                            -->
<!--                                                             -->
<!-- The second set of variables are internal, and are derived   -->
<!-- from the above via careful routines in mathbook-common.xsl. -->
<!--                                                             -->
<!-- b-has-inline-statement                                      -->
<!-- b-has-inline-hint                                           -->
<!-- b-has-inline-answer                                         -->
<!-- b-has-inline-solution                                       -->
<!-- b-has-divisional-statement                                  -->
<!-- b-has-divisional-hint                                       -->
<!-- b-has-divisional-answer                                     -->
<!-- b-has-divisional-solution                                   -->
<!-- b-has-worksheet-statement                                   -->
<!-- b-has-worksheet-hint                                        -->
<!-- b-has-worksheet-answer                                      -->
<!-- b-has-worksheet-solution                                    -->
<!-- b-has-reading-statement                                     -->
<!-- b-has-reading-hint                                          -->
<!-- b-has-reading-answer                                        -->
<!-- b-has-reading-solution                                      -->
<!-- b-has-project-statement                                     -->
<!-- b-has-project-hint                                          -->
<!-- b-has-project-answer                                        -->
<!-- b-has-project-solution                                      -->

<!-- Conceived as a "print only" PDF, this is also necessary    -->
<!-- to keep links (such as a solution number linking back to   -->
<!-- the original) from being seen/interpreted as actual links. -->
<xsl:param name="latex.print" select="'yes'"/>
<xsl:param name="latex.pagref" select="'no'"/>
<xsl:param name="latex.sides" select="'one'"/>
<xsl:param name="toc.level" select="'3'"/>

<!-- We have a switch for just this situation, to force -->
<!-- (overrule) the auto-detetion of the necessity for  -->
<!-- LaTeX styles for the solutions to exercises.       -->
<!-- See  mathbook-latex.xsl  for more explanation.     -->
<xsl:variable name="b-needs-solution-styles" select="true()"/>

<!-- For a "book" we replace the first chapter by a call to the        -->
<!-- solutions generator.  So we burrow into parts to get at chapters. -->

<xsl:template match="part|chapter|section|backmatter/solutions|backmatter/appendix|frontmatter" />

<xsl:template match="part[1]">
    <xsl:apply-templates select="chapter[1]" />
</xsl:template>

<!-- provoke the "solutions-generator" at the first sign of main matter content -->
<xsl:template match="chapter[1]|article/section[1]">
    <xsl:apply-templates select="$document-root" mode="solutions-generator">
        <xsl:with-param name="purpose" select="'solutionmanual'" />
        <xsl:with-param name="b-inline-statement"     select="$b-has-inline-statement" />
        <xsl:with-param name="b-inline-hint"          select="$b-has-inline-hint"  />
        <xsl:with-param name="b-inline-answer"        select="$b-has-inline-answer"  />
        <xsl:with-param name="b-inline-solution"      select="$b-has-inline-solution"  />
        <xsl:with-param name="b-divisional-statement" select="$b-has-divisional-statement" />
        <xsl:with-param name="b-divisional-hint"      select="$b-has-divisional-hint"  />
        <xsl:with-param name="b-divisional-answer"    select="$b-has-divisional-answer"  />
        <xsl:with-param name="b-divisional-solution"  select="$b-has-divisional-solution"  />
        <xsl:with-param name="b-worksheet-statement"  select="$b-has-worksheet-statement" />
        <xsl:with-param name="b-worksheet-hint"       select="$b-has-worksheet-hint"  />
        <xsl:with-param name="b-worksheet-answer"     select="$b-has-worksheet-answer"  />
        <xsl:with-param name="b-worksheet-solution"   select="$b-has-worksheet-solution"  />
        <xsl:with-param name="b-reading-statement"    select="$b-has-reading-statement" />
        <xsl:with-param name="b-reading-hint"         select="$b-has-reading-hint"  />
        <xsl:with-param name="b-reading-answer"       select="$b-has-reading-answer"  />
        <xsl:with-param name="b-reading-solution"     select="$b-has-reading-solution"  />
        <xsl:with-param name="b-project-statement"    select="$b-has-project-statement" />
        <xsl:with-param name="b-project-hint"         select="$b-has-project-hint"  />
        <xsl:with-param name="b-project-answer"       select="$b-has-project-answer"  />
        <xsl:with-param name="b-project-solution"     select="$b-has-project-solution"  />
    </xsl:apply-templates>
</xsl:template>

<!-- Hard-code numbers into titles -->
<xsl:template match="part|chapter|section|subsection|subsubsection|exercises" mode="division-in-solutions">
    <xsl:param name="scope" />
    <xsl:param name="content" />

    <xsl:variable name="the-number">
        <xsl:apply-templates select="." mode="number" />
    </xsl:variable>
    <xsl:variable name="original-title">
        <!-- no trailing space if no number -->
        <xsl:if test="not($the-number = '')">
            <xsl:value-of select="$the-number" />
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="." mode="title-full" />
    </xsl:variable>
    <xsl:variable name="moving-title">
        <!-- no trailing space if no number -->
        <xsl:if test="not($the-number = '')">
            <xsl:value-of select="$the-number" />
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="." mode="title-simple" />
    </xsl:variable>

    <!-- LaTeX heading with hard-coded number -->
    <xsl:text>\</xsl:text>
    <xsl:apply-templates select="." mode="division-name" />
    <xsl:text>*{</xsl:text>
    <xsl:value-of select="$original-title"/>
    <xsl:text>}&#xa;</xsl:text>
    <!-- An entry for the ToC, since we hard-code numbers -->
    <!-- These mainmatter divisions should always have a number -->
    <xsl:text>\addcontentsline{toc}{</xsl:text>
    <xsl:apply-templates select="." mode="division-name" />
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="$moving-title"/>
    <xsl:text>}&#xa;</xsl:text>
    <!-- Explicit marks, since divisions are the starred form -->
    <xsl:choose>
        <xsl:when test="self::chapter">
            <xsl:text>\chaptermark{</xsl:text>
            <xsl:value-of select="$moving-title"/>
            <xsl:text>}&#xa;</xsl:text>
        </xsl:when>
        <!-- "section", "exercises", "worksheet", at section-level, etc. -->
        <xsl:when test="parent::chapter">
            <xsl:text>\sectionmark{</xsl:text>
            <xsl:value-of select="$moving-title"/>
            <xsl:text>}&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>

    <xsl:copy-of select="$content" />
</xsl:template>

<!-- Page headers + Chapter/Section XYZ Title      -->
<!-- \sethead[even-left][even-center][even-right]  -->
<!--         {odd-left}{odd-center}{odd-right}     -->
<xsl:template match="book" mode="titleps-headings">
    <xsl:text>{&#xa;</xsl:text>
    <xsl:text>\sethead[\thepage][][\textsl{\chaptertitle}]&#xa;</xsl:text>
    <xsl:text>{\textsl{\sectiontitle}}{}{\thepage}&#xa;</xsl:text>
    <xsl:text>}&#xa;</xsl:text>
</xsl:template>

<!-- Hard-Coded Numbers -->
<!-- As a subset of full content, we can't          -->
<!-- point to much of the content with hyperlinks   -->
<!-- But we do have the full context as we process, -->
<!-- so we can get numbers for cross-references     -->
<!-- and *hard-code* them into the LaTeX            -->

<!-- We don't dither about possibly using a \ref{} and  -->
<!-- just produce numbers.  These might lack the "part" -->
<xsl:template match="*" mode="xref-number">
  <xsl:apply-templates select="." mode="number" />
</xsl:template>

<!-- The actual link is not a \hyperlink nor a    -->
<!-- hyperref, but instead is just plain 'ol text -->
<xsl:template match="*" mode="xref-link">
    <xsl:param name="content" select="'MISSING LINK CONTENT'"/>
    <xsl:value-of select="$content" />
</xsl:template>

<!-- Exercise numbers are always hard-coded at birth, given -->
<!-- complications of numbering, placement, duplication     -->

<!-- Captioned items are permitted in exercises.  We need   -->
<!-- to hard-code their numbers.  Following is an edited    -->
<!-- duplication of the code in the LaTeX conversion, which -->
<!-- needs to be kept in-sync.  Ideally a LaTeX (internal)  -->
<!-- switch would make these changes.                       -->
<!-- The "caption" macros are the starred variants, so that -->
<!-- numbers are not automatically generated, and then the  -->
<!-- actual text of the caption is manufactured entirely at -->
<!-- the end of the template.                               -->

<!-- Captions for Figures, Tables, Listings, Lists -->
<!-- xml:id is on parent, but LaTeX generates number with caption -->
<xsl:template match="figure|listing|table|list" mode="title-caption">
    <!-- construct appropriate command -->
    <xsl:choose>
        <xsl:when test="parent::sidebyside/parent::figure or parent::sidebyside/parent::sbsgroup/parent::figure">
            <xsl:text>\subcaption*{</xsl:text>
        </xsl:when>
        <xsl:when test="self::figure/parent::sidebyside">
            <xsl:text>\captionof*{figure}{</xsl:text>
        </xsl:when>
        <xsl:when test="self::table/parent::sidebyside">
            <xsl:text>\captionof*{table}{</xsl:text>
        </xsl:when>
        <xsl:when test="self::listing">
            <xsl:text>\captionof*{listingcap}{</xsl:text>
        </xsl:when>
        <xsl:when test="self::list">
            <xsl:text>\captionof*{namedlistcap}{</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>\caption*{</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <!-- produce the actual content -->
    <xsl:text>\textbf{</xsl:text>
    <xsl:apply-templates select="." mode="type-name"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="." mode="number"/>
    <xsl:text>:} </xsl:text>
    <xsl:choose>
        <xsl:when test="self::figure or self::listing">
            <xsl:apply-templates select="." mode="caption-full"/>
        </xsl:when>
        <xsl:when test="self::table or self::list">
            <xsl:apply-templates select="." mode="title-full"/>
        </xsl:when>
        <!-- never used? -->
        <xsl:otherwise>
            <xsl:apply-templates select="caption"/>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}&#xa;</xsl:text>
</xsl:template>

<!-- Customized from mathbook-latex.xsl to only process odds -->

<xsl:template match="exercises//exercise|worksheet//exercise|reading-questions//exercise" mode="solutions">
    <xsl:param name="purpose"/>
    <xsl:param name="b-has-statement" />
    <xsl:param name="b-has-hint" />
    <xsl:param name="b-has-answer" />
    <xsl:param name="b-has-solution" />

    <xsl:variable name="serial-number">
        <xsl:apply-templates select="." mode="serial-number" />
    </xsl:variable>

    <!-- Subsetting, especially in the back matter can yield no content at all    -->
    <!-- Schema says there is always some sort of statement, explicit or implicit -->
    <!-- We frequently build collections of "dry-run" output to determine if a    -->
    <!-- collection of exercises (e.g. in an "exercisegroup") is empty or not.    -->
    <!-- So it is *critical* that we get zero output for an exercise that has     -->
    <!-- no content due to settings of switches.                                  -->
    <!-- When we subset exercises for solutions, an entire      -->
    <!-- "exercisegroup" can become empty.  So we do a dry-run  -->
    <!-- and if there is no content at all we bail out.         -->

     <xsl:variable name="dry-run">
        <xsl:apply-templates select="." mode="dry-run">
            <xsl:with-param name="b-has-statement" select="$b-has-statement" />
            <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
            <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
            <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
        </xsl:apply-templates>
    </xsl:variable>
    <!-- <xsl:variable name="nonempty" select="$b-has-statement or ($b-has-hint and hint) or ($b-has-answer and answer) or ($b-has-solution and solution)" /> -->

    <xsl:if test="not($dry-run = '')">
        <!-- Using fully-qualified number in solution lists -->
        <xsl:variable name="env-name">
            <xsl:text>divisionsolution</xsl:text>
            <xsl:if test="ancestor::exercisegroup">
                <xsl:text>eg</xsl:text>
            </xsl:if>
            <xsl:if test="ancestor::exercisegroup/@cols">
                <xsl:text>col</xsl:text>
            </xsl:if>
        </xsl:variable>
        <xsl:text>\begin{</xsl:text>
        <xsl:value-of select="$env-name"/>
        <xsl:text>}</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="$serial-number"/>
        <xsl:text>}</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="title-full"/>
        <xsl:text>}</xsl:text>
        <!-- label of the exercise, to link back to it -->
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="latex-id"/>
        <xsl:text>}</xsl:text>
        <!-- no workspace fraction in a solution -->
        <xsl:text>%&#xa;</xsl:text>
        <!-- Allow a webwork or myopenmath exercise to introduce/connect    -->
        <!-- a problem (especially from server) to the text in various ways -->
        <xsl:if test="webwork-reps|myopenmath">
            <xsl:apply-templates select="introduction"/>
        </xsl:if>
        <!-- condition on how statement, hint, answer, solution are presented -->
        <xsl:choose>
            <xsl:when test="$serial-number mod 2 = 0"/>
            <!-- webwork, structured with "stage" matches first -->
            <!-- Above provides infrastructure for the exercise, -->
            <!-- we pass the stage on to a WW-specific template  -->
            <!-- since each stage may have hints, answers, and   -->
            <!-- solutions.                                      -->
            <xsl:when test="webwork-reps/static/stage">
                <xsl:apply-templates select="webwork-reps/static/stage" mode="solutions">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                    <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:when>
            <!-- webwork exercise, no "stage" -->
            <xsl:when test="webwork-reps/static">
                <xsl:apply-templates select="webwork-reps/static" mode="exercise-components">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                    <!-- 2018-09-21: WW answers may become available -->
                    <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:when>
            <!-- myopenmath exercise -->
            <!-- We only try to open an external file when the source  -->
            <!-- has a MOM problem (with an id number).  The second    -->
            <!-- argument of the "document()" function is a node and   -->
            <!-- causes the relative file name to resolve according    -->
            <!-- to the location of the XML.   Experiments with the    -->
            <!-- empty node "/.." are interesting.                     -->
            <!-- https://ajwelch.blogspot.co.za/2008/04/relative-paths-and-document-function.html -->
            <!-- http://www.dpawson.co.uk/xsl/sect2/N2602.html#d3862e73 (Point 4) -->
            <xsl:when test="myopenmath">
                <xsl:variable name="filename" select="concat(concat('problems/mom-', myopenmath/@problem), '.xml')" />
                <xsl:apply-templates select="document($filename, .)/myopenmath"  mode="exercise-components">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="false()" />
                    <xsl:with-param name="b-has-answer"    select="false()" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:when>
            <!-- "normal" exercise -->
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="exercise-components">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                    <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
        <!-- Allow a webwork or myopenmath exercise to conclude/connect     -->
        <!-- a problem (especially from server) to the text in various ways -->
        <xsl:if test="webwork-reps|myopenmath">
            <xsl:apply-templates select="conclusion"/>
        </xsl:if>
        <!-- closing % necessary, as newline between adjacent environments -->
        <!-- will cause a slight indent on trailing exercise               -->
        <xsl:text>\end{</xsl:text>
        <xsl:value-of select="$env-name"/>
        <xsl:text>}%&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<!-- Exercise Group (in solutions division) -->
<!-- Nothing produced if there is no content         -->
<!-- Otherwise, no label, since duplicate            -->
<!-- Introduction and conclusion iff with statements -->
<xsl:template match="exercisegroup" mode="solutions">
    <xsl:param name="purpose"/>
    <xsl:param name="b-has-statement" />
    <xsl:param name="b-has-hint" />
    <xsl:param name="b-has-answer" />
    <xsl:param name="b-has-solution" />

    <!-- When we subset exercises for solutions, an entire      -->
    <!-- "exercisegroup" can become empty.  So we do a dry-run  -->
    <!-- and if there is no content at all we bail out.         -->
     <xsl:variable name="dry-run">
        <xsl:apply-templates select="." mode="dry-run">
            <xsl:with-param name="b-has-statement" select="$b-has-statement" />
            <xsl:with-param name="b-has-hint" select="$b-has-hint" />
            <xsl:with-param name="b-has-answer" select="$b-has-answer" />
            <xsl:with-param name="b-has-solution" select="$b-has-solution" />
        </xsl:apply-templates>
    </xsl:variable>

    <xsl:if test="not($dry-run = '')">
        <xsl:if test="title">
            <xsl:text>\par\medskip\noindent%&#xa;\textbf{</xsl:text>
            <xsl:apply-templates select="." mode="title-full" />
            <xsl:text>}\space\space%&#xa;</xsl:text>
        </xsl:if>
        <xsl:if test="$b-has-statement">
            <xsl:apply-templates select="introduction" />
        </xsl:if>
        <!-- the container for the exercisegroup does not need to change -->
        <!-- when in a solutions list.  The indentation might look odd   -->
        <!-- without an introduction (when there are no statements), or  -->
        <!-- it might remind the reader of the grouping                  -->
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
        </xsl:choose>
        <xsl:apply-templates select="exercise" mode="solutions">
            <xsl:with-param name="purpose" select="$purpose" />
            <xsl:with-param name="b-has-statement" select="$b-has-statement" />
            <xsl:with-param name="b-has-hint" select="$b-has-hint" />
            <xsl:with-param name="b-has-answer" select="$b-has-answer" />
            <xsl:with-param name="b-has-solution" select="$b-has-solution" />
        </xsl:apply-templates>
        <xsl:choose>
            <xsl:when test="not(@cols) or (@cols = 1)">
                <xsl:text>\end{exercisegroup}&#xa;</xsl:text>
            </xsl:when>
            <xsl:when test="@cols = 2 or @cols = 3 or @cols = 4 or @cols = 5 or @cols = 6">
                <xsl:text>\end{exercisegroupcol}&#xa;</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="$b-has-statement">
            <xsl:apply-templates select="conclusion" />
        </xsl:if>
        <xsl:text>\par\medskip\noindent&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="answer">
    <xsl:param name="b-original" />
    <xsl:param name="purpose" />
    <xsl:param name="b-has-solution" />

    <xsl:if test="count(parent::*/answer) &gt; 1">
        <xsl:apply-templates select="." mode="solution-heading">
            <xsl:with-param name="b-original" select="$b-original" />
            <xsl:with-param name="purpose" select="$purpose" />
        </xsl:apply-templates>
    </xsl:if>
    <xsl:apply-templates>
        <xsl:with-param name="b-original" select="$b-original" />
    </xsl:apply-templates>
    <xsl:choose>
        <xsl:when test="following-sibling::answer">
            <xsl:call-template name="exercise-component-separator" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:if test="following-sibling::solution and $b-has-solution">
                <xsl:call-template name="exercise-component-separator" />
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
