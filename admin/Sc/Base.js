function clickIE() {
	if (document.all) 
	{
		return false;
	}
} 
	
function clickNS(e) {
	if (document.layers||(document.getElementById&&!document.all)) 
	{ 
		if (e.which==2||e.which==3) 
		{
			return false;
		}
	}
}
	 
if (document.layers) 
{
	document.captureEvents(Event.MOUSEDOWN);
	document.onmousedown=clickNS;
} 
else
{
	document.onmouseup=clickNS;
	document.oncontextmenu=clickIE;
} 

document.oncontextmenu=new Function("return false") 

function processKey()
{
	if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode >= 112 && event.keyCode <= 123))
	{
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
}

document.onkeydown = processKey;