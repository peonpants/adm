// JavaScript Document

//플래쉬패치
function ShowFlash(url, width, height){
        document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="' + width + '" height="' + height + '" VIEWASTEXT>');
        document.write('<param name="movie" value="' + url + '">');
        document.write('<param name="quality" value="high">');
        document.write('<param name="wmode" value="transparent">');
        document.write('<embed src="' + url + '" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="' + width + '" height="' + height + '"></embed>');
        document.write('</object>');
}


//롤오버

<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->


// 플래쉬 메뉴
function myfunc(menu) {
	switch (menu) {
		case "A1" : // 승무패
			// location.href='/Sports.asp?Game_Type=SMP' ; break;
			goSMP() ; break;
		case "A2" : // 핸디캡
			// location.href='/Sports.asp?Game_Type=Handicap' ; break; 
			goHandicap() ; break;
		case "A3" : // 경기결과
			// location.href='/sub3.asp' ; break; 
			goGameResult(); break;
		case "A4" : // 배팅규정
			// location.href='/sub4.asp' ; break; 
			goBetRule(); break;
		case "A5" : // 핸디캡이해
			// location.href='/sub5.asp' ; break; 
			goDescHandicap(); break;
		case "A6" : // 게시판
			// location.href='/board_list.asp' ; break; 
			goBoard('board'); break;
		case "A7" : // 고객센터
			// location.href='/customer.asp' ; break; 
			goCustomer(); break;
		case "B1" : // 축구
			location.href='/business/main.asp' ; break; 
		case "B2" : // 농구
			location.href='/business/main2.asp' ; break; 
		case "B3" : // 야구
			location.href='/business/main3.asp' ; break; 
		case "B4" : // 기타
			location.href='/business/main4.asp' ; break;
			
		case "M1" : // 메인메뉴
			location.href='/' ; break; 
		case "M2" : // 메인메뉴
			// location.href='/' ; break; 
			goSports('','') ; break;
		case "M3" : // 메인메뉴
			location.href='/' ; break; 
			
		case "M4" : // 메인메뉴
			// location.href='/' ; break; 
			goBoard('event') ; break;
		
	} 
}


// BUTTON STYLE BETBROWSER
function highlight(obj, isHover)
{
	var cssClass = obj.className;
	if(cssClass == "" || cssClass == "MouseOver")
	{	// RotatingTeaser
		obj.className = isHover ? "MouseOver" : "";
		return;
	}
	
	var color;
	if(isHover)
	{
		color = "#000000";
		obj.style.backgroundColor = "#FFFF00";
		obj.style.borderColor = "#ffe066 #907608 #907608 #ffe066";
	}
	else
	{
		if(obj.getAttribute("divName")=="cartIn") color = "#000001";
		else color = "#FFFFFF";
		obj.style.backgroundColor = "";
		obj.style.borderColor = "";
	}

	obj.style.color = color;					// set color of this element
	var tds = obj.getElementsByTagName("TD");	// and all child TDs

	for(var i=0; i<tds.length; i++){
		tds[i].style.color = color;
	}
}



// 하위메뉴나오게하는(레프트)

function startmenu() 
{ 
menu0.style.display = "block"; 
} 

function menu0func() 
{ 
if(menu0.style.display == "block") 
{ 
startmenu(); 
menu0.style.display = "none"; 
} 
else 
{ 
startmenu(); 
} 
}
// End --> 


//iframe 유동적인 세로길이
function reSize() {
        try{
        var objBody = ifrm_Cart.document.body;
        var objFrame = document.all["ifrm_Cart"];
        ifrmHeight = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight);
        
        if (ifrmHeight > 300) {
                objFrame.style.height = ifrmHeight
        }else{
                objFrame.style.height = 220;
        }
        objFrame.style.width = '100%'
        }catch(e){}
}
function init_iframe() {
        reSize();
        setTimeout('init_iframe()',200)
}
init_iframe();


