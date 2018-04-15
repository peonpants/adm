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
<%
'#################################################################
' 리그 검수 페이지  
' 인덱스의 리드를 해당 싸이트의 리그로 컨버트 맞춰봄
'#################################################################

dim oDOM, url, xml
dim x, y, desc
dim useCNT
useCNT = 0 
' XML 데이터 주소
url = "http://111.68.3.3:7788/Game_IndexGetData.asp"

Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' 동기식 호출
    .setProperty "ServerHTTPRequest", True ' HTTP로 XML 데이터 가져옴
    .Load(url)
end with

Set objLst = oDOM.getElementsByTagName("data")

Dim booReagueCheck
booReagueCheck = true

For i = 0 to (objLst.length -1)   
   
   strSQL = strSQL & "INSERT INTO INFO_INDEX_GAME"
   
   For j = 0 to objLst.item(i).childNodes.Length  -1

        '######### 리그 등록 여부 판단
        IF objLst.item(i).childNodes(j).nodeName = "RL_LEAGUE" Then
            IG_LEAGUE = objLst.item(i).childNodes(j).text
            
            Set tRs = Server.CreateObject("ADODB.RecordSet")
            
            SQL1  = "SELECT RL_IDX, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
            tRS.Open SQL1, DbCon,adOpenStatic, adLockReadOnly, adCmdText
            
	        IF tRs.EOF THEN			    
                txtReagueCheck = "존재하지 않는 리그목록이 있습니다.<br>" & vbcrlf
                booReagueCheck = false			    
            Else
                RL_IDX		= tRS("RL_IDX")
                RL_IMAGE	= tRS("RL_IMAGE")         	                	            		    
	        END IF
           
            tRS.Close
            Set tRS = Nothing            
        End IF
        
        IF booReagueCheck Then                  
            IF j = 0 Then                             
                strSQL1 = "("
                strSQL2 = "("                    
            End IF
                   
            strSQL1 = strSQL1 & objLst.item(i).childNodes(j).nodeName               
                    
            IF objLst.item(i).childNodes(j).nodeName = "RL_IDX" Then
                strSQL2 = strSQL2 & "'" &  RL_IDX & "'"
            ElseIF objLst.item(i).childNodes(j).nodeName = "RL_IMAGE" Then
                strSQL2 = strSQL2 & "'" &  RL_IMAGE & "'"
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
        End IF            

   Next
   
   strSQL = strSQL & strSQL1 & strSQL2 
   
Next

'######## 리그 등록이 완료된 경우
IF booReagueCheck Then
    
    '######### 기존 데이터 삭제    
    DELSQL = "DELETE FROM INFO_INDEX_GAME"
    DbCon.execute(DELSQL)
    
    '######### 새로운 데이터 입력
    'response.Write strSQL
    DbCon.execute(strSQL)
    
    '######## 등록 가능 건수를 가져온다.
    cntSQL = "SELECT count(A.IG_IDX) as cnt FROM INFO_INDEX_GAME A LEFT OUTER JOIN  INFO_GAME B  ON A.IG_IDX = B.II_IDX WHERE B.II_IDX IS NULL"
    SET RS = DbCon.execute(cntSQL)    
    IF NOT RS.EOF THEN
        useCNT = RS("cnt")
    End IF
    Set RS = Nothing
End IF    

Set Nodes = Nothing
Set oDOM = Nothing


%>
<div style='width:155px;color:ffffff;font-size:11px;background:#000;text-align:center'>
<%=now() %> <br>
<a href="/EPCenter/04_Game/game_IndexReague.asp" target="ViewFrm" style="color:#ffffff;">
<% 
IF NOT booReagueCheck  Then
    response.Write txtReagueCheck 
ElseIF booReagueCheck And useCNT > 0 Then
    response.write "신규 게임"  &  useCNT & "개 -등록하기"
End IF
%>
</a>
</div>
<%
Set DbCon = Nothing
%>