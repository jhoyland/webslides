# webslides
A framework for create powerpoint / beamer style slide shows as websides

Abstract: The objective of this project is to create powerpointesque slide shows using HTML. Slides will be created using a simple XML format which will then be transformed into HTML pages. Pages will be layed out using a CSS structure file which encodes common slide layouts. A further simple CSS will provide user-modifyable aesthetic styling. A set of Javascript functions using Mootools framework will then provide animation, slide transitions and image manipulation. MathJax will provide mathematical formula display.
The intended workflow is that an instructor can write a slide outline in a plain text editor with LaTeX style formulas. This can then be directly transformed into webpages with a common look and feel for hosting on any platform.
Ultimately a PHP script could serve the slides transforming on the fly.

TASKS:
1/ Basic slide layouts (Started)

The main layout engine is in lecture-to-html.xsl but specific layouts are kept in common-layouts.xsl.

2/ MathJax testing (Works)
3/ Image scaling (Javascript & CSS with backgrounds)
4/ Create XSLT for HTML creation (Working)
5/ Create simple markup conversion
6/ Navigation buttons (Via PHP)
7/ Slide transitions
8/ Animation

USAGE:
The core part of the framework is the lecture-to-html.xsl stylesheet. This currently takes 3 parameters:
$target-slide:  the id of the slide to be rendered into html. If this is set to 'all' the slides are all rendeded as a single html. This could possibly be used to load the lecture and allow entirely client-side slide transitions through javascript. Currently this has not been tested. If the target is not found the sheet will return an empty document. Otherwise it will return the selected slide in html format. If no target is supplied the default is to return the first slide.

$headless: when headless is set to 'yes' the returned html will not be a complete document but just a div element containing the slide html. This is to allow client-side requests to the incorporate the slide into another webpage. This will be developed further later as the JavaScript API is extended. The default is 'no' which returns a complete html page for the selected slide or table of contents.

$toc: this allows the production of a "table of contents" either as list (ul or ol) or as a div with a set of span elements. the defualt is no. Otherwise the allowed options are list, ordered-list or div. Eventually this will include the possibility to have navigation links in the table via php
