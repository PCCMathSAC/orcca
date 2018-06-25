<?xml version='1.0'?> <!-- As XML file -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Thin layer on MathBook XML -->
<xsl:import href="../../mathbook/xsl/mathbook-html.xsl" />




<!-- create iframe home for YouTube video -->
<!-- dimensions and autoplay as parameters -->
<xsl:template match="video[@youtubelist]" mode="video-embed">
    <xsl:param name="width" select="''" />
    <xsl:param name="height" select="''" />
    <xsl:param name="autoplay" select="'false'" />

    <xsl:variable name="int-id">
        <xsl:apply-templates select="." mode="internal-id" />
    </xsl:variable>
    <xsl:variable name="source-url">
        <xsl:apply-templates select="." mode="youtube-embed-url">
            <xsl:with-param name="autoplay" select="$autoplay" />
        </xsl:apply-templates>
    </xsl:variable>
    <!-- allowfullscreen is an iframe parameter, -->
    <!-- not a YouTube embed parameter, but it's -->
    <!-- use enables the "full screen" button    -->
    <!-- http://w3c.github.io/test-results/html51/implementation-report.html -->
    <iframe id="{$int-id}"
            type="text/html"
            width="{$width}"
            height="{$height}"
            style="border: 3px solid #EEE;"
            frameborder="0"
            allowfullscreen=""
            src="{$source-url}" />
</xsl:template>

<!-- Temporary hack until mathbook can handle sidebyside within webwork -->
<xsl:template match="image[ancestor::sidebyside][ancestor::webwork]" mode="get-width-percentage">
    <xsl:value-of select="parent::sidebyside/@widths" />
</xsl:template>

<!-- Creates a YouTube URL for embedding, typically in an iframe -->
<!-- autoplay for popout, otherwise not                          -->
<xsl:template match="video[@youtubelist]" mode="youtube-embed-url">
    <xsl:param name="autoplay" select="'false'" />
    <xsl:text>https://www.youtube.com/embed/videoseries</xsl:text>
    <!-- alphabetical, ? separator first -->
    <!-- enables keyboard controls       -->
    <xsl:text>?disablekd=1</xsl:text>
    <!-- use &amp; separator for remainder -->
	<xsl:text>&amp;list=</xsl:text>
    <xsl:value-of select="@youtubelist" />
    <!-- modest branding -->
    <xsl:text>&amp;modestbranding=1</xsl:text>
    <!-- kill related videos at end -->
    <xsl:text>&amp;rel=0</xsl:text>
    <xsl:if test="@start">
        <xsl:text>&amp;start=</xsl:text>
        <xsl:value-of select="@start" />
    </xsl:if>
    <xsl:if test="@end">
        <xsl:text>&amp;end=</xsl:text>
        <xsl:value-of select="@end" />
    </xsl:if>
    <!-- default autoplay is 0, don't -->
    <xsl:if test="$autoplay = 'true'">
        <xsl:text>&amp;autoplay=1</xsl:text>
    </xsl:if>
</xsl:template>






</xsl:stylesheet>
