<?xml version="1.0" encoding="UTF-8"?>
<!-- Common layouts for the webslides -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="body[@layout = 'col13']">
	<div class="slide-body">
	<div class="row flex1">
		<div class="col flex1">
			<xsl:apply-templates select="./content[1]" />
		</div>
		<div class="col flex3">
			<xsl:apply-templates select="./content[2]" />
		</div>
	</div>
</div>
</xsl:template>

<xsl:template match="body[@layout = '2cols']">
	<div class="slide-body">
		<div class="row flex1">
			<div class="col flex1">
				<xsl:apply-templates select="./content[1]" />
			</div>
			<div class="col flex1">
				<xsl:apply-templates select="./content[2]" />
			</div>
		</div>
	</div>
</xsl:template>


<xsl:template match="body[@layout = '2figs-with-captions']">
	<div class="slide-body">
		<div class="row flex1">
			<div class="col flex1">
				<div class="row flex5">
					<xsl:apply-templates select="./content[1]" />
				</div>
				<div class="row flex1">
					<xsl:apply-templates select="./content[2]" />
				</div>
			</div>	
			<div class="col flex1">
				<div class="row flex5">
					<xsl:apply-templates select="./content[3]" />
				</div>
				<div class="row flex1">
					<xsl:apply-templates select="./content[4]" />
				</div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="content[@layout = 'img-with-caption']">
	<div class = "col flex1">
			<div class="row flex5">
				<div class="content">
					<xsl:apply-templates select="./img[1]" />
				</div>
			</div>
			<div class="row flex1">
				<div class="content">
					<xsl:apply-templates select="./text[1]" />
				</div>
			</div>
	</div>
</xsl:template>


</xsl:stylesheet>