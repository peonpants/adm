<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- # include virtual="/_Global/AdminChk.asp" --->
<%
Dim IU_CODE
Dim IU_ID
Dim IU_SITE

'request �� ������ ���
IU_CODE = trim(request("IU_CODE"))
IU_ID = trim(request("IU_ID"))
IU_SITE = request("IU_SITE")

'�ڵ尪�� �̹� �ִ��� üũ�Ѵ�.
SQL = "SELECT IU_CODE FROM Info_User_Code WHERE IU_CODE = " & IU_CODE
SET RS = Dbcon.Execute(SQL)



    IF NOT RS.EOF THEN	
    '���� ������ javascript�� �˸�â�� ǥ���Ѵ�
%>
      
      
      
      
         <script language="javascript">
           alert("�̹� �ִ� ����ũ �ڵ��Դϴ�. �ٽ� �����Ͻñ� �ٶ��ϴ�. ");
         </script>




<%
	  response.end
    
      
      
      'else
      '�̹� �� ȸ������ ����ũ �ڵ尡 �ִٸ� .
      'sql = "SELECT IU_id FROM Info_User_Code WHERE IU_ID =" & IU_ID
      'SET sRS = Dbcon.Execute(SQL)

     
        
            'If Not sRS.EOF Then 

           '����ũ �ڵ带 ������Ʈ �Ѵ� 
            'SQL = "UPDATE Info_User_Code SET IU_CODE = '"&IU_CODE&"' WHERE IU_ID =" &IU_ID
            'Dbcon.Execute(SQL)

            
            
        else
        '���� ������ INSERT �Ѵ�
        SQL ="INSERT INTO Info_User_Code (IU_CODE, IU_ID, IU_SITE) VALUES ('"&IU_CODE&"','"&IU_ID&"','"&IU_SITE&"')"
        Dbcon.Execute(SQL)
        'End If


             
%>





<script language="javascript">
alert("�����ͺ��̽��� �ڵ������ �Ϸ�Ǿ����ϴ�. ");
parent.location.reload();
</script>



<%
end if

rs.close
set rs = nothing

'srs.close
'set srs = nothing

%>