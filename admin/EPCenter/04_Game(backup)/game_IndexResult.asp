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
' ���� �˼� ������  
' �ε����� ���带 �ش� ����Ʈ�� ���׷� ����Ʈ ���纽
'#################################################################


Set tRs = Server.CreateObject("ADODB.RecordSet")
        
SQL1  = "select isNull(min(ii_idx),0) as ii_idx from info_game where ig_status = 'E'"
tRS.Open SQL1, DbCon,adOpenStatic, adLockReadOnly, adCmdText

IF NOT tRs.EOF THEN			    
    ii_idx		= tRS("ii_idx")
    IF ii_idx = 0 Then
        tRS.Close
        Set tRS = Nothing 
        response.Write "<script>alert('������ ��Ⱑ �����ϴ�.');location.href = '/EPCenter/04_Game/list.asp?SFlag=E'</script>"
        response.End            
    End IF
Else
    tRS.Close
    Set tRS = Nothing 
    response.Write "<script>alert('������ ��Ⱑ �����ϴ�.');location.href = '/EPCenter/04_Game/list.asp?SFlag=E'</script>"
    response.End        
END IF

tRS.Close
Set tRS = Nothing 


dim oDOM, url, xml
dim x, y, desc
dim useCNT
useCNT = 0 
' XML ������ �ּ�
url = "http://www.rs-ck.com/Game_IndexGetDataResult.asp?ii_idx=" & ii_idx

Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' ����� ȣ��
    .setProperty "ServerHTTPRequest", True ' HTTP�� XML ������ ������
    .Load(url)
end with

Set objLst = oDOM.getElementsByTagName("data")

strSQL = ""

For i = 0 to (objLst.length -1)    
   strSQL = strSQL & " UPDATE INFO_GAME SET "
   strSQL1 = ""
   
   For j = 0 to objLst.item(i).childNodes.Length  -1      
                                       
        IF strSQL1 & objLst.item(i).childNodes(j).nodeName = "IG_IDX" Then
            strSQL3 = " WHERE II_IDX = " & strSQL2 & objLst.item(i).childNodes(j).text
        Else            
            strSQL1 = strSQL1 & objLst.item(i).childNodes(j).nodeName & "= '" & objLst.item(i).childNodes(j).text & "'"
            IF j <> objLst.item(i).childNodes.Length  -1 Then 
                strSQL1 = strSQL1 & ", "
            End IF
        End IF

   Next
   
   strSQL = strSQL & strSQL1 &  strSQL3 & ";"
   
Next

IF strSQL <> "" Then
    DbCon.execute(strSQL)
    response.Write "<script>alert('������ ��� ���ھ ������Ʈ �Ǿ����ϴ�.');location.href = '/EPCenter/04_Game/list.asp?SFlag=E'</script>"
Else
    response.Write "<script>alert('������ ��Ⱑ �����ϴ�.');location.href = '/EPCenter/04_Game/list.asp?SFlag=E'</script>"
End IF
Set Nodes = Nothing
Set oDOM = Nothing


	
%>

 
