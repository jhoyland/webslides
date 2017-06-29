<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- Stylesheet parameters -->
<xsl:param name="target_slide"><xsl:value-of select="/slides/slide[1]/@id"/></xsl:param>
<xsl:param name="headless">no</xsl:param>
<xsl:param name="toc">no</xsl:param>
<xsl:param name="php_nav_footer">no</xsl:param>
<xsl:param name="lecture_name" />
<xsl:output method="html"
              doctype-system="about:legacy-compat"
              encoding="UTF-8"
              indent="yes" 
              omit-xml-declaration="yes"/>
<!-- A selection of shortcut templates for common slide layouts -->
<xsl:include href="common-layouts.xsl" />
<!-- The default template -->
<xsl:template match="@*|node()">
  		<xsl:copy>
    		<xsl:apply-templates select="@*|node()"/>
  		</xsl:copy>
</xsl:template>
<!-- Determines overall processing of lecture based on stylesheet parametere.  -->
<xsl:template match="slides">
	<xsl:choose>
		<!-- Will generate a table of contents as a bullet list -->
		<xsl:when test="$toc = 'list'">
			<ul class="toc_list">
				<xsl:apply-templates select="@*|node()"/>
			</ul>
		</xsl:when>
		<!-- Will generate a table of contents as a numbered list -->
		<xsl:when test="$toc = 'ordered-list'">
			<ol class="toc_list">
				<xsl:apply-templates select="@*|node()"/>
			</ol>
		</xsl:when>
		<!-- Will generate a table of contents as a series of divs -->
		<xsl:when test="not($toc = 'list') and not($toc = 'no')">
			<div class="toc_list_div">
				<xsl:apply-templates select="@*|node()"/>
			</div>
		</xsl:when>
		<!-- Will return all slides with no HTML header. This is so, for example, the slides can be prepared for printing or for display on the client side -->
		<xsl:when test="$headless = 'yes' and $target_slide='all' and $toc='no'">
			<div class="slide_set">
				<xsl:apply-templates select="@*|node()"/>
			</div>
		</xsl:when>
		<!-- Selects the first slide. I don't think I need this any more -->
		<xsl:when test="$target_slide=':first'">
			<p><xsl:value-of select="/slides/slide[1]"/></p>
			<xsl:apply-templates select="/slides/slide[1]"/>
		</xsl:when>
		<!-- Default = return the selected (or first) slide. Optionally this will be either with or without an HTML header depending on the value of $headless  -->
		<xsl:otherwise>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="inner-slide">
	<div class="slide" id="{@id}">
    	<xsl:apply-templates select="@*|node()"/>
    </div>
	<div class="preload-area">
		<xsl:for-each select=".//img">
			<xsl:element name="img">
				<xsl:attribute name="src">
					<xsl:value-of select="@src"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:value-of select="@src"/>
				</xsl:attribute>
			</xsl:element>
		</xsl:for-each>	
	</div>
</xsl:template>

<xsl:template match="slide">

	<xsl:param name="istarget"></xsl:param>

	<xsl:choose>

		<xsl:when test="$target_slide = @id and $headless = 'yes' and $toc = 'no' ">
			<xsl:call-template name="inner-slide" />
		</xsl:when>

		<xsl:when test="$target_slide = @id and $headless = 'no' and $toc = 'no' ">
			<html>

				<head>
					<title><xsl:value-of select="header/title"/></title>
					<meta charset="utf-8"></meta>
					<link rel="stylesheet" type="text/css" href="layout-struct.css"></link>
					<link rel="stylesheet" type="text/css" href="slide-style.css"></link>
					<script src="https://cdnjs.cloudflare.com/ajax/libs/mootools/1.6.0/mootools-core.js"></script>
					<script type="text/javascript" src="slidehelpers.js"></script>
					<script type="text/x-mathjax-config">
						  MathJax.Hub.Config({
						    tex2jax: {
						      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
						      processEscapes: true
						    }
						  });
					</script>
					<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-MML-AM_CHTML'></script>
				</head>
				<body>
				    <xsl:call-template name="inner-slide" />
				</body>
			</html>
		</xsl:when>

		<xsl:when test="not($toc = 'no')">
			<xsl:choose>
				<xsl:when test="$toc = 'list' or $toc = 'ordered-list'">
					<li class="toc_li">
						<xsl:value-of select="header/title"/>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<span class="toc_li_span">
						<xsl:value-of select="header/title"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>

		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="header">
	<div class="slide-header">
		<xsl:apply-templates select="@*|node()"/>
	</div>
</xsl:template>

<xsl:template match="title">
	<h1><xsl:apply-templates select="@*|node()"/></h1>
</xsl:template>

<xsl:template match="subtitle">
	<h2><xsl:apply-templates select="@*|node()"/></h2>
</xsl:template>

<xsl:template name="make-left-php-nav">
	<xsl:element name="a">
		<xsl:attribute name="class">
			<xsl:text>php-footer-nav php-footer-nav-left</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="href">
			<xsl:text>lecture.php?target_slide=</xsl:text>
			<xsl:choose>
				<xsl:when test = "../preceding-sibling::slide">
					<xsl:value-of select="../preceding-sibling::*[1]/@id" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../@id" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>&amp;lecture=</xsl:text>
			<xsl:value-of select="$lecture_name" />
		</xsl:attribute>
		<xsl:text> &lt; </xsl:text>
	</xsl:element>
</xsl:template>


<xsl:template name="make-right-php-nav">
	<xsl:element name="a">
		<xsl:attribute name="class">
			<xsl:text>php-footer-nav php-footer-nav-right</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="href">
			<xsl:text>lecture.php?target_slide=</xsl:text>
			<xsl:choose>
				<xsl:when test = "../following-sibling::slide">
					<xsl:value-of select="../following-sibling::*[1]/@id" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../@id" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>&amp;lecture=</xsl:text>
			<xsl:value-of select="$lecture_name" />
		</xsl:attribute>
		<xsl:text> &gt; </xsl:text>
	</xsl:element>
</xsl:template>

<xsl:template match="footer">
	<div class="slide-footer">
				<div class="footer-left">
					<p>P1120</p>
				</div>
				<div class="footer-center">
					<p><xsl:call-template name="make-left-php-nav"/> Page <xsl:value-of select="count(../preceding-sibling::slide)+1"/> of <xsl:value-of select="count(/slides/slide)"/> <xsl:call-template name="make-right-php-nav"/></p>
				</div>
				<div class="footer-right">
					<p>Fall 2017</p>
				</div>
	</div>
</xsl:template>

<xsl:template match="body">
	<div class="slide-body">
		<xsl:apply-templates select="@*|node()"/>
	</div>
</xsl:template>

<xsl:template match="row">
	<xsl:element name="div">
		<xsl:attribute name="class">
			<xsl:text>row flex</xsl:text>
			<xsl:if test="@height">
				<xsl:value-of select="@height" />
			</xsl:if>
			<xsl:if test="not(@height)">
				<xsl:text>1</xsl:text>
			</xsl:if>
		</xsl:attribute>
    		<xsl:apply-templates select="@*|node()"/>
	</xsl:element>
</xsl:template>

<xsl:template match='col'>
	<xsl:element name="div">
		<xsl:attribute name="class">
			<xsl:text>col flex</xsl:text>
			<xsl:if test="@width">
				<xsl:value-of select="@width" />
			</xsl:if>
			<xsl:if test="not(@width)">
				<xsl:text>1</xsl:text>
			</xsl:if>
		</xsl:attribute>
    		<xsl:apply-templates select="@*|node()"/>
	</xsl:element>
</xsl:template>

<xsl:template  match="content">
	<div class="content">
    		<xsl:apply-templates select="@*|node()"/>
	</div>
</xsl:template>

<xsl:template match='content/text'>
	<div class="text-content">
    		<xsl:apply-templates select="@*|node()"/>
	</div>
</xsl:template>

<xsl:template match='content/media'>
	<div class="media-content">
    		<xsl:apply-templates select="@*|node()"/>
	</div>
</xsl:template>

<xsl:template match="video[@provider = 'youtube']">
	<xsl:element name = "iframe">
		<xsl:attribute name="class">youtube</xsl:attribute>
		<xsl:attribute name="src">
			<xsl:text>https://www.youtube.com/embed/</xsl:text><xsl:value-of select="@src"/>
		</xsl:attribute>
	</xsl:element>
</xsl:template>	

<xsl:template match="app[@provider = 'phet']">
	<xsl:element name = "iframe">
		<xsl:attribute name="class">phet</xsl:attribute>
		<xsl:attribute name="src">
			<xsl:text>https://phet.colorado.edu/sims/html/</xsl:text><xsl:value-of select="@src"/>
		</xsl:attribute>
	</xsl:element>
</xsl:template>	

<xsl:template match='content/img'>
	<xsl:apply-templates />
	<xsl:if test="@embed = 'canvas'">
		<xsl:element name ="canvas">
			<xsl:attribute name="class">
				<xsl:text>imgcanv</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="data-figno">
				<xsl:value-of select="@src"/>
			</xsl:attribute>
		</xsl:element>
	</xsl:if>
	<xsl:if test="@embed = 'div'">
		<xsl:element name ="div">
			<xsl:attribute name="class">
				<xsl:text>imgdiv</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="style">
				<xsl:text>background-image:url(</xsl:text>
				<xsl:value-of select="@src"/>
				<xsl:text>)</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>