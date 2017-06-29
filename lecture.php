<?php
if(isset($_GET["target_slide"]))
{
	$target_slide=$_GET["target_slide"];
}

if(isset($_GET["lecture"]))
{
	$lecture = $_GET["lecture"];
}
else
{
	$lecture = "testlecture";
}

//echo $lecture;

$content = new DOMDocument();
$content->load($lecture.".xml");
$transformation = new DOMDocument();
$transformation->load("slide-stylesheet.xsl");
$processor = new XSLTProcessor();
$processor->importStyleSheet($transformation);
$processor->setParameter("","lecture_name",$lecture);
$processor->setParameter("","headless","no");
if(isset($target_slide))
{
	$processor->setParameter("","target_slide",$target_slide);
}
$processor->setParameter("","toc","no");
$transformed = new DOMDocument();
$transformed =  $processor->transformToXML($content);
echo $transformed;
//$transformed->removeChild($transformed->doctype);
//$transformed->saveHTMLFile("outputfile.html");
?>