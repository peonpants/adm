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
' �ε����� ���� ������� �����ϴ��� üũ�Ѵ�.
' �ε����� ���带 �ش� ����Ʈ�� ���׷� ����Ʈ ���纽
'#################################################################

'########## ������ ����� �ּ� ���� �ҷ��´�.

Set tRs = Server.CreateObject("ADODB.RecordSet")
        
SQL1  = "select isNull(min(ii_idx),0) as ii_idx from info_game where ig_status = 'E'"
tRS.Open SQL1, DbCon,adOpenStatic, adLockReadOnly, adCmdText

IF NOT tRs.EOF THEN			    
    ii_idx		= tRS("ii_idx")
    IF ii_idx = 0 Then
        tRS.Close
        Set tRS = Nothing 
        response.End            
    End IF
Else
    tRS.Close
    Set tRS = Nothing 
    response.End        
END IF

tRS.Close
Set tRS = Nothing 


dim oDOM, url, xml
dim x, y, desc
dim useCNT
useCNT = 0 
' XML ������ �ּ�
url = "http://111.68.3.3:7788/Game_IndexGetDataResult.asp?ii_idx=" & ii_idx
 
Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' ����� ȣ��
    .setProperty "ServerHTTPRequest", True ' HTTP�� XML ������ ������
    .Load(url)
end with

Set objLst = oDOM.getElementsByTagName("data")
   
IF objLst.length <> 0 Then   
%>
<div style='width:155px;color:ffffff;font-size:11px;background:#000;text-align:center'>

<a href="/EPCenter/04_Game/game_IndexResult.asp" target="ViewFrm" style="color:#ffffff;">������ ������ �����մϴ�.</a>

</div>
<%
End IF
Set DbCon = Nothing
%>