<META HTTP-EQUIV="Refresh" CONTENT="7;url=http://mainadm.plsfwad.com:26115/EPCenter/bridge/bridge_sadari.asp">
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%	
	SQLR = "SELECT top 1 IG_STARTTIME,II_IDX,IG_TEAM1BETTING,IG_TEAM2BETTING from info_game where ig_memo is null and ig_type=0 and ig_anal is null and ig_event='Y' and (dateadd(ss,105,ig_starttime) between getdate() and dateadd(ss,90,getdate()))"
	SET RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SQLR, DbCon, 1

	if not RS.EOF then
		value0 = rs(0)
		value1 = rs(1)
		value2 = Trim(rs("IG_TEAM1BETTING")) * 0.965
		value4 = Trim(rs("IG_TEAM2BETTING")) * 0.965
		idx1 =rs("II_IDX")
		response.write value2
	end If
	RS.Close
	Set RS=Nothing

%>


<%
	SQLR = "SELECT top 1 IG_STARTTIME,II_IDX,IG_TEAM1BETTING,IG_TEAM2BETTING from info_game where ig_memo is null and ig_type=1 and ig_anal is null and ig_event='Y' and (dateadd(ss,105,ig_starttime) between getdate() and dateadd(ss,90,getdate()))"
	SET RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SQLR, DbCon, 1

	if not RS.EOF then
		value5 = rs(0)
		value6 = rs(1)
		value7 = Trim(rs("IG_TEAM1BETTING")) * 0.965
		value8 = Trim(rs("IG_TEAM2BETTING")) * 0.965
		idx2 = rs("II_IDX")
		response.write value7
	end If
	RS.Close
	Set RS=Nothing	
%>



<%
	SQLR = "SELECT top 1 IG_STARTTIME,II_IDX,IG_TEAM1BETTING,IG_TEAM2BETTING from info_game where ig_memo is null and ig_type=2 and ig_anal is null and ig_event='Y' and (dateadd(ss,105,ig_starttime) between getdate() and dateadd(ss,90,getdate()))"
	SET RS = Server.CreateObject("ADODB.Recordset")
	RS.Open SQLR, DbCon, 1

	if not RS.EOF then
		value9 = rs(0)
		value10 = rs(1)
		value11 = Trim(rs("IG_TEAM2BETTING")) * 0.965
		value12 = Trim(rs("IG_TEAM1BETTING")) * 0.965
        idx3 = rs("II_IDX")
		response.write value12
	end If
	RS.Close
	Set RS=Nothing	
%>




<script src="jquery-1.4.1.min.js" type="text/javascript"></script>
<html>
<body onload="getSendStart()">
<input type="hidden" name = "id" id ="id" value="cjstkd2"/><br />
<input type="hidden" name = "pin" id = "pin" value="asas1133"/><br />
<input type="hidden" name = "token" id = "token" value=""/>


<input type="hidden" name = "value1" id = "value1" value="<%=value2%>"/>
<input type="hidden" name = "value2" id = "value2" value="<%=value4%>"/>
<input type="hidden" name = "idx1" id = "idx1" value="<%=idx1%>"/>

<input type="hidden" name = "value3" id = "value3" value="<%=value7%>"/>
<input type="hidden" name = "value4" id = "value4" value="<%=value8%>"/>
<input type="hidden" name = "idx2" id = "idx2" value="<%=idx2%>"/>


<input type="hidden" name = "value5" id = "value5" value="<%=value11%>"/>
<input type="hidden" name = "value6" id = "value6" value="<%=value12%>"/>
<input type="hidden" name = "idx3" id = "idx3" value="<%=idx3%>"/>

</body>
</html>
<script>
var token = "";

		function getSessionId(){
			
			var cid =  document.getElementById("id").value
			var cpin =  document.getElementById("pin").value

			$(document).ready(function(){
				$.ajax({
				  type: "POST",
				  url: "bridge_back_sadari.asp",
				  data: {id: cid, pwd: cpin},
				  success:function(data ) {
data2 = $.parseJSON(data);
					$( "#token").val(data2.Message);
token = data2.Message;
				  }
				});
			});


		}



function getSendStart(){
			
			

getSessionId();
setTimeout("getSend()",1000);

}


function getSend(){
			
			var value1 =  document.getElementById("value1").value;
			var value2=  document.getElementById("value2").value;
var idx1 = document.getElementById("idx1").value;
var bt_kind="";
var totalValue = 0;



if(Number(value1)> Number(value2)){
	bt_kind = "W01";
	totalValue = Number(value1) - Number(value2);
} else if(Number(value1) <  Number(value2)){
	totalValue = Number(value2) - Number(value1);
	bt_kind = "L01";
} else if(Number(value1) ==  Number(value2)){
        bt_kind ="D01"
}

if(bt_kind != "D01"){


			$(document).ready(function(){
				$.ajax({
				  type: "POST",
				  url: "bridge1_sadari.asp",
				  data: {token: token, bt_kind: bt_kind, bt_price: totalValue, idx:idx1},
				  success:function(data ) {

data2 = $.parseJSON(data);

getSend2();


				  }
				});
			});



}else if(bt_kind == "D01") {

getSend2();
}
}





function getSend2(){
			
			var value3 =  document.getElementById("value3").value;
			var value4=  document.getElementById("value4").value;
var idx2 = document.getElementById("idx2").value;
var bt_kind2="";
var totalValue2 = 0;



if(Number(value3)> Number(value4)){
	bt_kind2 = "W02";
	totalValue2 = Number(value3) - Number(value4);
} else if(Number(value3) <  Number(value4)){
	totalValue2 = Number(value4) - Number(value3);
	bt_kind2 = "L02";
} else if(Number(value3) ==  Number(value4)){
        bt_kind2 ="D02"
}

if(bt_kind2 != "D02"){
			$(document).ready(function(){
				$.ajax({
				  type: "POST",
				  url: "bridge2_sadari.asp",
				  data: {token: token, bt_kind: bt_kind2, bt_price: totalValue2},
				  success:function(data ) {

data3 = $.parseJSON(data);

getSend3();

				  }
				});
			});
}else if(bt_kind2 == "D02") {

getSend3();
}

}





function getSend3(){
			
			var value5 =  document.getElementById("value5").value;
			var value6=  document.getElementById("value6").value;
var idx3 = document.getElementById("idx3").value;
var bt_kind3="";
var totalValue3 = 0;



if(Number(value5)> Number(value6)){
	bt_kind3 = "W03";
	totalValue3 = Number(value5) - Number(value6);
} else if(Number(value5) <  Number(value6)){
	totalValue3 = Number(value6) - Number(value5);
	bt_kind3 = "L03";
} else if(Number(value5) ==  Number(value6)){
        bt_kind3 ="D03"
}

if(bt_kind3 != "D03"){
			$(document).ready(function(){
				$.ajax({
				  type: "POST",
				  url: "bridge3_sadari.asp",
				  data: {token: token, bt_kind: bt_kind3, bt_price: totalValue3},
				  success:function(data ) {

data3 = $.parseJSON(data);

				  }
				});
			});

}else if(bt_kind3 == "D03") {


}

}
</script>







