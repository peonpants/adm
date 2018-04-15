<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->

<script language="javascript">

//20141010 사다리 자동리프레쉬 ( createRequestObject ~ carProc 함수까지 )
function createRequestObject() //object 생성이 가능한 브라우저인지 확인.
{
    var req;
    // 
    if(window.XMLHttpRequest) // 브라우져가 XMLHttpRequest 객체를 가지고 있는지 판단
    {
        // Firefox, Safari, Opera...
        req = new XMLHttpRequest();
    }
    else if(window.ActiveXObject) // 브라우가 ActiveX 를 받아올 수 있는지 판단
    {
        // Internet Explorer 5+
        req = new ActiveXObject();  
    }
    else // HTTP 통신을 할수 없는 브라우져인 경우
    {
        alert("브라우저의 버전이 낮으면 오류가 발생합니다. 브라우저를 업그레이드 하세요");
    }
    return req; // 브라우져에 맞는 HTTP 객체를 가져와 객체 리턴
}

// XMLHttpRequest object생성 [위의 함수로 브라우저에 맞는 객체를 받아옴]
var http = createRequestObject();

function sendRequest(page) // 데이터 페이지 불러오기
{
    // get 방식으로 파라미터로 넘겨받은 객체를 가져오도록 셋팅
    http.open('POST', page, false);
    http.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT"); //캐싱방지ㅋ
    // 페이지로부터의 onreadystatechange 즉 읽어들일 수 있다는 상태값을 받으면 handleResponse 함수를 실행하도록 함
    http.onreadystatechange = handleResponse;
    // 페이지를 가져오도록 호출
    http.send(null);
}
function handleResponse() { // 불러온값 처리

   if(http.readyState == 4 && http.status == 200){
     
      var response = http.responseText;		

      if(response) {
         // UPDATE ajaxTest content
         document.getElementById("sadariRefresh").innerHTML = response;
		
      }

   }

}

function repeatloop()  //최종적으로 처리해서 보여주기
	{ 
		sendRequest('BettingSadariRefresh_view2.asp'); // 값을 받아올 asp의 위치

		setTimeout("repeatloop()", 10000); //refresh 빈도 1000 = 1초		
	}

	window.onload=function() {
	repeatloop();
	
}




// 브라우져가 실행될때 repeatloop 함수를 실행
window.onload=function()
{
    // repeatloop 함수 호출
    repeatloop();
}

</script>

<html>
<head>
<title>배팅 리스트</title>
<!-- #include virtual="/Inc_Month.asp"-->
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
function go_delete(form)
{
	var v_cnt = 0;
	var v_data = "";
	
	for( var i=0; i<form.elements.length; i++) 
	{
		var ele = form.elements[i];
		if( (ele.name=="SelUser") && (ele.checked) )
		{ 
			//if (v_cnt == 0)
			if (v_data.length==0)
				v_data = ele.value;
			else
				v_data = v_data + "," + ele.value; 
			v_cnt = v_cnt + 1; 
		} 
	}
		
	if (v_cnt == 0) 
	{ 
		alert("삭제할 정보를 선택해 주세요."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("정말 삭제하시겠습니까?")) return;		
	form.action = "Delete.asp?page=<%=page%>";
	form.submit();
}
	
	function SearchSports(ss) {
		document.frm1.action = "List.asp?RS_Sports="+ss;	
		document.frm1.submit();
	}
	
	function SearchLeague(ss,sl) {
		// document.frm1.action = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
		// document.frm1.submit();
		location.href = "List.asp?RS_Sports="+ss+"&RL_League="+sl;
	}

	function goMyBetDetail(idx,pg,tt) {
		goUrl = "Betting_Detail.asp?IB_Idx="+idx+"&page="+pg+"&total="+tt;
		location.href=goUrl;
	}
	function goBatdel(gidx) {
		if (!confirm("정말 취소하시겠습니까?\n\n취소시 해당 배팅에 대한 환불처리가 이루어 집니다.")) return;		
		exeFrame.location.href="Bet_Cancel_Proc.asp?IB_Idx="+gidx;
	}
	
	function goDetail(IB_Idx, gameCnt)
	{
	    var url = "Betting_Detail.asp?IB_Idx="+IB_Idx;
	    dis = document.getElementById("tr"+IB_Idx).style.display == "none" ? "block" : "none" ;
	    document.getElementById("tr"+IB_Idx).style.display = dis ;
	    if(dis == "block")
	    {
	        
	        document.getElementById("iframe"+IB_Idx).style.width = "100%" ;
	        document.getElementById("iframe"+IB_Idx).style.height = (gameCnt*20) + 120 ;
	        document.getElementById("iframe"+IB_Idx).src = url ;
	    }
	}

    function ajaxRequestBet(ib_idx, e)
	{

        var E=window.event;
        var x =  E.clientX + document.body.scrollLeft ;
	    var y =  E.clientY + document.body.scrollTop;
    	
		document.getElementById("aaa").style.left = x ;
		document.getElementById("aaa").style.top = y ;	
		        
		var url = "ajaxBetting_Detail.asp";
		var pars = 'ib_idx=' + ib_idx
		
		var myAjax = new Ajax.Request(
			url, 
			{
				method: 'get', 
				parameters: pars, 
				onComplete: showResponse
			});

	
				
	}

	function showResponse(originalRequest)
	{
	
		document.getElementById("aaa").innerHTML = originalRequest.responseText;
        
	}


</SCRIPT>


</head>

<body topmargin="0" marginheight="0">
<iframe name="exeFrame" id="exeFrame" width="0" height="0"></iframe>
<div id="aaa" style="position:absolute;left:1;top:1;width:500px;"></div>
<table  border="0" cellspacing="2" cellpadding="5" bgcolor="#000000" width="100%">
<tr>
    <td>
        <b class="text07"> 게임 관리 &nbsp;&nbsp; ▶  배팅 리스트  
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>

<div id="sadariRefresh"> </div>



