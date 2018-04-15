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

//20141010 ��ٸ� �ڵ��������� ( createRequestObject ~ carProc �Լ����� )
function createRequestObject() //object ������ ������ ���������� Ȯ��.
{
    var req;
    // 
    if(window.XMLHttpRequest) // �������� XMLHttpRequest ��ü�� ������ �ִ��� �Ǵ�
    {
        // Firefox, Safari, Opera...
        req = new XMLHttpRequest();
    }
    else if(window.ActiveXObject) // ���찡 ActiveX �� �޾ƿ� �� �ִ��� �Ǵ�
    {
        // Internet Explorer 5+
        req = new ActiveXObject();  
    }
    else // HTTP ����� �Ҽ� ���� �������� ���
    {
        alert("�������� ������ ������ ������ �߻��մϴ�. �������� ���׷��̵� �ϼ���");
    }
    return req; // �������� �´� HTTP ��ü�� ������ ��ü ����
}

// XMLHttpRequest object���� [���� �Լ��� �������� �´� ��ü�� �޾ƿ�]
var http = createRequestObject();

function sendRequest(page) // ������ ������ �ҷ�����
{
    // get ������� �Ķ���ͷ� �Ѱܹ��� ��ü�� ���������� ����
    http.open('POST', page, false);
    http.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT"); //ĳ�̹�����
    // �������κ����� onreadystatechange �� �о���� �� �ִٴ� ���°��� ������ handleResponse �Լ��� �����ϵ��� ��
    http.onreadystatechange = handleResponse;
    // �������� ���������� ȣ��
    http.send(null);
}
function handleResponse() { // �ҷ��°� ó��

   if(http.readyState == 4 && http.status == 200){
     
      var response = http.responseText;		

      if(response) {
         // UPDATE ajaxTest content
         document.getElementById("sadariRefresh").innerHTML = response;
		
      }

   }

}

function repeatloop()  //���������� ó���ؼ� �����ֱ�
	{ 
		sendRequest('BettingSadariRefresh_view2.asp'); // ���� �޾ƿ� asp�� ��ġ

		setTimeout("repeatloop()", 10000); //refresh �� 1000 = 1��		
	}

	window.onload=function() {
	repeatloop();
	
}




// �������� ����ɶ� repeatloop �Լ��� ����
window.onload=function()
{
    // repeatloop �Լ� ȣ��
    repeatloop();
}

</script>

<html>
<head>
<title>���� ����Ʈ</title>
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
		alert("������ ������ ������ �ּ���."); 
		return;
	} 
	
	//alert(v_data);
	
	if (!confirm("���� �����Ͻðڽ��ϱ�?")) return;		
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
		if (!confirm("���� ����Ͻðڽ��ϱ�?\n\n��ҽ� �ش� ���ÿ� ���� ȯ��ó���� �̷�� ���ϴ�.")) return;		
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
        <b class="text07"> ���� ���� &nbsp;&nbsp; ��  ���� ����Ʈ  
	      </b>
    </td>
</tr>
</table>    
<div style="height:10px;"></div>

<div id="sadariRefresh"> </div>



