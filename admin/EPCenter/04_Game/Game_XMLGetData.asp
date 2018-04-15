<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/Lib/Pager.Class.asp"-->
<!-- #include virtual="/_Common/Lib/StringUtil.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/EPCenter/04_Game/_Sql/gameSql.Class.asp"-->
<!-- #include virtual="/_Global/DbCono.asp" -->
<%

reqYear    = right("000" & dfRequest("year"), 4)
reqMonth   = right("0" & dfRequest("month"), 2)
reqDay     = right("0" & dfRequest("day")  , 2)

'IG_STATUS  = dfRequest("IG_STATUS")
ig_STATUS = "F"
ig_type            = dfStringUtil.F_initNumericParam(Trim(dfRequest.Value("ig_type")),0, 0, 2) 
reqSite = trim(dfRequest("site"))
startDate = reqYear & "-" & reqMonth & "-" & reqDay

%>
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
<%
'#################################################################
' 인덱스의 게임 결과값이 존재하는지 체크한다.
' 인덱스의 리드를 해당 싸이트의 리그로 컨버트 맞춰봄
'#################################################################


dim oDOM, url, xml
dim x, y, desc
dim useCNT
useCNT = 0

' XML 데이터 주소
url = reqSite & "http://www.rs-ck.com/totoeditor/editor/editor.asp?startDate="&startDate&"&endDate="&startDate&"&ig_type=" & ig_type & "&IG_STATUS=" & IG_STATUS
'response.Write url
'response.end
Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' 동기식 호출
    .setProperty "ServerHTTPRequest", True ' HTTP로 XML 데이터 가져옴
    .Load(url)
end with

Set objLst = oDOM.getElementsByTagName("data")
strSQL = ""

For i = 0 to (objLst.length -1)   
   
   
   strSQL = strSQL & "INSERT INTO INFO_INDEX_GAME"
   
   For j = 0 to objLst.item(i).childNodes.Length  -1       
        IF j = 0 Then                             
            strSQL1 = "("
            strSQL2 = "("                    
        End IF
               
        strSQL1 = strSQL1 & objLst.item(i).childNodes(j).nodeName               
                
        IF objLst.item(i).childNodes(j).nodeName = "RL_IDX" Then
            strSQL2 = strSQL2 & "'" &  objLst.item(i).childNodes(j).text & "'"
        ElseIF objLst.item(i).childNodes(j).nodeName = "RL_IMAGE" Then
            strSQL2 = strSQL2 & "'" &  objLst.item(i).childNodes(j).text & "'"
        Else
            strSQL2 = strSQL2 & "'" &  objLst.item(i).childNodes(j).text & "'"
        End IF
                
        IF j <> objLst.item(i).childNodes.Length  -1 Then 
            strSQL1 = strSQL1 & ", "
            strSQL2 = strSQL2 & ", "        
        End IF
        
        IF j = objLst.item(i).childNodes.Length  -1 Then 
            strSQL1 = strSQL1 & ") VALUES "
            strSQL2 = strSQL2 & ");"
        End IF
   Next   
   strSQL = strSQL & strSQL1 & strSQL2    
Next

'######### 기존 데이터 삭제    


    DELSQL = "DELETE FROM INFO_INDEX_GAME"
    DbCon.execute(DELSQL)
IF strSQL <> "" Then    
    '######### 새로운 데이터 입력
    DbCon.execute(strSQL)
End IF    
%>
<script type="text/javascript">
location.href = "Game_XMLList.asp?ig_type=<%= ig_type %>&IG_STATUS=<%= IG_STATUS %>&site=<%= reqSite %>";
</script>