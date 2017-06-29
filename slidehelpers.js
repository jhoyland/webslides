function drawScaleImage(context,image,imgscale)
{
	var canvas = context.canvas;
	var hAspect = canvas.width / image.width;
	var vAspect = canvas.height / image.height;
	var scaleFactor = imgscale * Math.min(hAspect,vAspect);

	var centerShift_x = ( canvas.width - image.width*scaleFactor ) / 2;
		var centerShift_y = ( canvas.height - image.height*scaleFactor ) / 2;  

		context.clearRect(0,0,canvas.width, canvas.height);
		context.drawImage(image, 0,0, image.width, image.height,centerShift_x,centerShift_y, image.width*scaleFactor, image.height*scaleFactor);  
}

function fitToParentClientRect(child)
{
	var rect = child.parentNode.getBoundingClientRect();
	child.width = rect.width;
	child.height = rect.height;
}

function rescaleImages()
{
	var canvs = $$('.imgcanv');

	console.log(canvs);

	canvs.each(function(canv) {
		console.log("working on...");
		console.log(canv.getProperty("data-figno"));
		fitToParentClientRect(canv);
		var context = canv.getContext("2d");
		var image = $(canv.getProperty("data-figno"));
		var imgscale = canv.getProperty("data-imgscale");
		if(!imgscale) imgscale = 1;
		if(imgscale > 1) imgscale = 1;
		if(imgscale < 0.01) imgscale = 0.01;
		if(image) {
			drawScaleImage(context,image,imgscale);
		}
	});
}

/*
Not currently working!

function rescaleIframes()
{
	var iframes = $$('.youtube');

	iframes.each(function(ifrm) {
		var rect = ifrm.parentNode.getBoundingClientRect();
		console.log(rect);
		if(rect.height > rect.width) {
			ifrm.width = rect.width;
			ifrm.height = (rect.width / 16.0) * 9.0;
		}
		else
		{
			ifrm.height = rect.height;
			ifrm.width = (rect.height / 9.0) * 16.0;
		}
	});
}*/

window.addEvent("load",function(){
	console.log("We got here!");
	rescaleImages();
	//rescaleIframes();
});

window.addEvent("resize",function(){
	rescaleImages();
	//rescaleIframes();
});