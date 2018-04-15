<%@LANGUAGE="VBSCRIPT" CODEPAGE=949  %>
<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- # include virtual="/_Global/AdminChk.asp" --->
<%
Dim IU_CODE
Dim IU_ID
Dim IU_SITE

'request 값 변수에 담기
IU_CODE = trim(request("IU_CODE"))
IU_ID = trim(request("IU_ID"))
IU_SITE = request("IU_SITE")

'코드값이 이미 있는지 체크한다.
SQL = "SELECT IU_CODE FROM Info_User_Code WHERE IU_CODE = " & IU_CODE
SET RS = Dbcon.Execute(SQL)



    IF NOT RS.EOF THEN	
    '값이 있으면 javascript에 알림창을 표시한다
%>
      
      
      
      
         <script language="javascript">
           alert("이미 있는 유니크 코드입니다. 다시 생성하시기 바랍니다. ");
         </script>




<%
	  response.end
    
      
      
      'else
      '이미 그 회원에게 유니크 코드가 있다면 .
      'sql = "SELECT IU_id FROM Info_User_Code WHERE IU_ID =" & IU_ID
      'SET sRS = Dbcon.Execute(SQL)

     
        
            'If Not sRS.EOF Then 

           '유니크 코드를 업데이트 한다 
            'SQL = "UPDATE Info_User_Code SET IU_CODE = '"&IU_CODE&"' WHERE IU_ID =" &IU_ID
            'Dbcon.Execute(SQL)

            
            
        else
        '값이 없으면 INSERT 한다
        SQL ="INSERT INTO Info_User_Code (IU_CODE, IU_ID, IU_SITE) VALUES ('"&IU_CODE&"','"&IU_ID&"','"&IU_SITE&"')"
        Dbcon.Execute(SQL)
        'End If


             
%>





<script language="javascript">
alert("데이터베이스에 코드생성이 완료되었습니다. ");
parent.location.reload();
</script>



<%
end if

rs.close
set rs = nothing

'srs.close
'set srs = nothing

%>