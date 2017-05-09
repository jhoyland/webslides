function drawScaleImage(context,image)
{
	var canvas = context.canvas;
	var hAspect = canvas.width / image.width;
	var vAspect = canvas.height / image.height;
	var scaleFactor = Math.min(hAspect,vAspect);

	var centerShift_x = ( canvas.width - image.width*scaleFactor ) / 2;
		var centerShift_y = ( canvas.height - image.height*scaleFactor ) / 2;  

		context.clearRect(0,0,canvas.width, canvas.height);
		context.drawImage(image, 0,0, image.width, image.height,centerShift_x,centerShift_y, image.width*scaleFactor, image.height*scaleFactor);  
}

function fitCanvas(canvas)
{
	var rect = canvas.parentNode.getBoundingClientRect();
	canvas.width = rect.width;
	canvas.height = rect.height;
}

window.addEvent("load",function(){
	var canv = $('canv1');
	fitCanvas(canv);
	var context = canv.getContext("2d");
	drawScaleImage(context,$('image1'));
});