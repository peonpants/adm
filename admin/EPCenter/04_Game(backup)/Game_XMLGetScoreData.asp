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

ig_idx    = dfRequest("II_IDX")

dim oDOM, url, xml
dim x, y, desc
dim useCNT
useCNT = 0

' XML ������ �ּ�
'url = "http://210.146.28.200/totoeditor/editor/editor.asp?ig_idx=" & ig_idx
url = "http://www.rs-ck.com/totoeditor/editor/editor.asp?ig_idx=" & ig_idx
Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' ����� ȣ��
    .setProperty "ServerHTTPRequest", True ' HTTP�� XML ������ ������
    .Load(url)
end with

Set objLst = oDOM.getElementsByTagName("data")
strSQL = ""

For i = 0 to (objLst.length -1)   
    For j = 0 to objLst.item(i).childNodes.Length  -1 
        response.Write objLst.item(i).childNodes(j).text & ","
    Next
Next
%> 