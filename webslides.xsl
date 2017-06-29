<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"
              doctype-system="about:legacy-compat"
              encoding="UTF-8"
              indent="yes" 
              omit-xml-declaration="yes"/>

<xsl:template match="@*|node()">
  		<xsl:copy>
    		<xsl:apply-templates select="@*|node()"/>
  		</xsl:copy>
</xsl:template>

<xsl:template match="slides">
	<xsl:apply-templates select="@*|node()"/>
</xsl:template>

<xsl:template match="slide">
<html>
<head>
<title><xsl:value-of select="title"/></title>
		<meta charset="utf-8"></meta>
		<link rel="stylesheet" type="text/css" href="layout-struct.css"></link>
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
	<div class="slide">
    		<xsl:apply-templates select="@*|node()"/>
    </div>
	<div class="preload-area">
		<xsl:for-each select="//img">
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
</body>
</html>
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


<xsl:template match="footer">
	<div class="slide-footer">
				<div class="footer-left">
					<p>P1120</p>
				</div>
				<div class="footer-center">
					<p><a href="page1.html">&lt;</a> Page 2 of 10 <a href="page3.html">&gt;</a></p>
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

<xsl:template match='row'>
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
		<xsl:apply-templates />
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
		<xsl:apply-templates />
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