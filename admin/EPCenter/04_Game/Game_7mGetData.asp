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
<html>
<head>
</head> 

<body> 

<Blink id="loading">데이터를 불러오고 있습니다.</Blink>
<br />
<script language="javascript"> 
function doBlink() { 

var Blink = document.all.tags("Blink"); 

for (var i=0; i < Blink.length; i++) 

Blink[i].style.visibility = Blink[i].style.visibility == "" ? "hidden" : ""; 

} 

function startBlink() 
{
    if (document.all) { 
        setInterval("doBlink()",300); 
    } 
} 

startBlink(); 
</script> 
</body> 

</html>


<%

    response.Flush
    Dim url
    Dim data
    
    '######### 기존 데이터 삭제    
	DELSQL = "DELETE FROM INFO_7M"
	DbCon.execute(DELSQL)
    
    
    '######### XMLHTTP
    url = "http://1x2.7m.cn/data/index_kr.js"
    'url = "http://1x2.7m.cn/data/index_en.js"
    Set xmlHttp =  Server.CreateObject("msxml2.Xmlhttp") 
        xmlHttp.Open "get", url, false
        
        xmlHttp.Send      
   
        data =  replace(xmlHttp.ResponseText, "var dt = ","")
        'response.Write data
        'response.End
        putJsArray(data)
    Set xmlHttp = Nothing
    
    insertData = getJSArray()
    'response.Write replace(insertData, ";","<Br>")
    'response.End
    'On Error resume Next
    
    IF insertData <> "" Then
        DbCon.execute(insertData)
%>
    <script type="text/javascript">location.href = "Game_7mList.asp"; </script>
<%
        'response.Write "<a href='Game_7mList.asp'>[리스트 페이지 이동]</a>"
    Else
        response.Write "데이터를 불러오는 도중 오류가 발생하였습니다. 개발자에게 문의바랍니다."    
    End IF
           
%>
    <script type="text/javascript">document.getElementById("loading").innerHTML = "" </script>

<script language=javascript runat=server>
var dt = new Array() ;
var NEUTRAL_STR = "(N)";
var COMPARE = "비교";
function putJsArray(val)
{
    dt = eval(val);
}
function format(num, len)
{
	return Math.round(num*Math.pow(10,len))/Math.pow(10,len);
}
function getJSArray()
{
    var htmlcode = '<gameLists>';
    var strSql = "";
    
    for (var i = 0; i < dt.length; ++i)
	{
		var dt2 = dt[i].split('|');
		var stm = dt2[1].split(',');
		
		var	start_date = stm[0] + '-' + stm[1] + '-' + stm[2] ;
		var start_time = stm[3] + ':' + stm[4];
		var IG_STARTTIME = start_date + ' ' + start_time ;
		htmlcode += 	'<gameList>' ;
		htmlcode += 	'<IG_IDX>' + dt2[0] + '</IG_IDX>' ; //고유번호
		htmlcode += 	'<RL_LEAGUE>' + dt2[3] + '</RL_LEAGUE>' ; //리그
		htmlcode +=						'<IG_STARTTIME>' + IG_STARTTIME + '</IG_STARTTIME>' ; // 경기일시
		htmlcode +=						'<IG_TEAM1>' + dt2[6] + (dt2.length > 13 && dt2[14] == "1" ? NEUTRAL_STR : "") + '</IG_TEAM1>' ; //홈팀
		htmlcode +=						'<IG_TEAM1BENEFIT>' + (dt2[8] != "" ? format(dt2[8], 2) : "") + '</IG_TEAM1BENEFIT>' ; //홈배당
		htmlcode +=						'<IG_DRAWBENEFIT>' + (dt2[9] != "" ? format(dt2[9], 2) : "") + '</IG_DRAWBENEFIT>' ; //무승부 배당
		htmlcode +=						'<IG_TEAM2BENEFIT>' + (dt2[10] != "" ? format(dt2[10], 2) : "") + '</IG_TEAM2BENEFIT>' ; //원정배당
		htmlcode +=						'<IG_C_TEAM1BENEFIT>' + (dt2[11] != "" ? format(dt2[11], 2) : "")+ '</IG_C_TEAM1BENEFIT>' ; //현재홈배당
		htmlcode +=						'<IG_C_DRAWBENEFIT>' + (dt2[12] != "" ? format(dt2[12], 2) : "") + '</IG_C_DRAWBENEFIT>' ; //현재 무승부 배당
		htmlcode +=						'<IG_C_TEAM2BENEFIT>' + (dt2[13] != "" ? format(dt2[13], 2) : "") + '</IG_C_TEAM2BENEFIT>' ; //현재 원정배당		
		htmlcode +=						'<IG_TEAM2>' + dt2[7] + '</IG_TEAM2>' ; //원정팀
		htmlcode +=		'</gameList>' ;
        
        
        strSql += "INSERT INTO [dbo].[INFO_7M]"
           strSql += "([I7_IDX]"
           strSql += ",[I7_LEAGUE]"
           strSql += ",[I7_STARTTIME]"
           strSql += ",[I7_TEAM1]"
           strSql += ",[I7_TEAM2]"
           strSql += ",[I7_TEAM1BENEFIT]"
           strSql += ",[I7_DRAWBENEFIT]"
           strSql += ",[I7_TEAM2BENEFIT]"
           strSql += ",[I7_C_TEAM1BENEFIT]"
           strSql += ",[I7_C_DRAWBENEFIT]"
           strSql += ",[I7_C_TEAM2BENEFIT])"
           strSql += "VALUES"
           strSql += "(" + dt2[0] ;
           strSql += ",'" + dt2[3] + "'"
           strSql += ",dateadd(hour, 1,'" + IG_STARTTIME + "')"
           strSql += ",'" + CheckWord(dt2[6]) + (dt2.length > 13 && dt2[14] == "1" ? NEUTRAL_STR : "")  + "'"
           strSql += ",'" + CheckWord(dt2[7]) + "'"
           strSql += ",'" + (dt2[8] != "" ? format(dt2[8], 2) : "")  + "'"
           strSql += ",'" + (dt2[9] != "" ? format(dt2[9], 2) : "") + "'"
           strSql += ",'" + (dt2[10] != "" ? format(dt2[10], 2) : "") + "'"
           strSql += ",'" + (dt2[11] != "" ? format(dt2[11], 2) : "") + "'"
           strSql += ",'" + (dt2[12] != "" ? format(dt2[12], 2) : "") + "'"
           strSql += ",'" + (dt2[13] != "" ? format(dt2[13], 2) : "") + "'"
           strSql += ");"
         

	}
	htmlcode += '</gameLists>';
    return strSql;
}

function CheckWord(CheckValue)
{
  var s = new String(CheckValue)
  s = s.replace(/'/g, "")
  return s ;
}

</script>