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
<title>���װ˼� > ����������</title>
<link rel="stylesheet" type="text/css" href="/EPCenter/Css/Style.css">
</head>
<body topmargin="0" marginheight="0">

<table border="0" cellpadding="10" width="100%">
<tr>
    <td bgcolor="000000"  height="25">
	<b style="color:ffffff">���������� > �ű� ���� ����ϱ�</b>
	</td>
</tr>
<tr>
    <td bgcolor="eeeeee"  height="25">
	���װ� ���� ��� ������ �߻� �� �� �ֽ��ϴ�. ���� ��� �� ����ϼ���. 
	<br />
	�̵�Ͻ� ǥ�õ˴ϴ�.
	</td>
</tr>

</table>

<table>
<tr>
    <td>
<%
'#################################################################
' ���� �˼� ������  
' �ε����� ���带 �ش� ����Ʈ�� ���׷� ����Ʈ ���纽
'#################################################################

dim oDOM, url, xml
dim x, y, desc
dim useCNT
useCNT = 0 
' XML ������ �ּ�
url = "http://111.68.3.3:7788/Game_IndexGetData.asp"

Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' ����� ȣ��
    .setProperty "ServerHTTPRequest", True ' HTTP�� XML ������ ������
    .Load(url)
end with

Set objLst = oDOM.getElementsByTagName("data")

Dim booReagueCheck
booReagueCheck = true

For i = 0 to (objLst.length -1)   
   
   strSQL = strSQL & "INSERT INTO INFO_INDEX_GAME"
   
   For j = 0 to objLst.item(i).childNodes.Length  -1

        '######### ���� ��� ���� �Ǵ�
        IF objLst.item(i).childNodes(j).nodeName = "RL_LEAGUE" Then
            IG_LEAGUE = objLst.item(i).childNodes(j).text
            
            Set tRs = Server.CreateObject("ADODB.RecordSet")
            
            SQL1  = "SELECT RL_IDX, RL_IMAGE FROM Ref_League WHERE RL_LEAGUE = '" & IG_LEAGUE & "' "
            tRS.Open SQL1, DbCon,adOpenStatic, adLockReadOnly, adCmdText
            
	        IF tRs.EOF THEN			    
                Response.WRITE "���׸� <a href='/EPCenter/03_League/List.asp'><font color='red'>" & IG_LEAGUE & "</font></a> �� ���׸�Ͽ��� ã�� �� �����ϴ�.<br>" & vbcrlf
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

'######## ���� ����� �Ϸ�� ���
IF booReagueCheck Then
    
    '######### ���� ������ ����    
    DELSQL = "DELETE FROM INFO_INDEX_GAME"
    DbCon.execute(DELSQL)
    
    '######### ���ο� ������ �Է�
    'response.Write strSQL
    DbCon.execute(strSQL)
    
    '######## ��� ���� �Ǽ��� �����´�.
    cntSQL = "SELECT count(A.IG_IDX) as cnt FROM INFO_INDEX_GAME A LEFT OUTER JOIN  INFO_GAME B  ON A.IG_IDX = B.II_IDX WHERE B.II_IDX IS NULL"
    SET RS = DbCon.execute(cntSQL)    
    IF NOT RS.EOF THEN
        useCNT = RS("cnt")
    End IF
End IF    



Set Nodes = Nothing
Set oDOM = Nothing


	
%>
</td>
</tr>
<tr>
    <td>
        <% IF booReagueCheck Then %>
        <%= useCNT  %>�� ��ϰ���<br />
        <input type="button" value="���� ����ϱ�" onclick="location.href='game_IndexGame_Proc.asp'" />
        <% Else %>
        <input type="button" value="���ӵ���� �ϱ� ���ؼ��� ���׸� ������ּ���" />
        <% End IF %>
    </td>
</tr>
</table>
</body>
</html>
 
