<!-- #include virtual="/_Common/Config/CommonCS.asp"-->
<!-- #include virtual="/_Common/Lib/Request.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBConn.class.asp"-->
<!-- #include virtual="/_Common/Lib/DBCmdSql.class.asp"-->
<!-- #include virtual="/_Common/API/Injection.COM/injection.class.asp"-->
<!-- #include virtual="/_Common/API/BlockIP.COM/BlockIPSql.class.asp"-->
<!-- #include virtual="/_Common/Api/AdminCheck.COM/AdminChk.asp" --->
<%
	IF request.Cookies("AdminLevel") = 1 THEN
		AdminLevel = 1
		AdminPosition = "�����Ͱ�����"
	ELSEIF request.Cookies("AdminLevel") = 2 THEN
		AdminLevel = 2
		AdminPosition = "������"
	END IF
%>	
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<script language="javascript" type="text/javascript" src="Includes/common.js"></script>
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<script language="javascript" src="Includes/common.js"></script>
<script type="text/javascript">
	function logOut() {
		if (confirm("�α׾ƿ� �Ͻðڽ��ϱ�?")) {
			top.location.href="./Login/LogOut.asp";
		}
	}
	
	function openAlarm() {
		var openUrl = "./05_Account/AccountAlarm.asp";
		window.open(openUrl,'alarm','width=300,height=50');
	}
	
	function dbInit() {
		if (confirm("���������� ������ ��� �����Ͱ� �����˴ϴ�.\n���� DB�� �ʱ�ȭ �Ͻðڽ��ϱ�?")) {
			top.HiddenFrm.location.href="DB_Init.asp";
		}
	}
	
	var heightDefault= 0 
	function leftMenuShowHide()
	{
        if(top.document.getElementById("mainFrameSet").cols == "200,*")
        {
            heightDefault = 1;
        }
        
        if(heightDefault == 0)
        {
            top.document.getElementById("mainFrameSet").cols = "200,*" ;
            heightDefault = 1;
            document.getElementById("tdCast").innerHTML = "�����";
        }
        else
        {
            top.document.getElementById("mainFrameSet").cols = "80,*" ;
            heightDefault = 0;
            document.getElementById("tdCast").innerHTML = "��ġ��";
        }        	    
	}
	
    function showHide(objID)
    {
        dis = document.getElementById(objID).style.display == "none" ? "block" : "none";
        document.getElementById(objID).style.display = dis
    }	
</script>
</head>
<table border="0" cellspacing="0" cellpadding="0" width=100%>
<tr>
    <td height="755" align="center" valign="top" bgcolor="#ffffff" style="color:#000000; padding-left:10px;">

	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
            <tr>
                <td id="Account">        
                </td>
            </tr>  

    <div id="nowMember">
	 <script>
	 new Ajax.PeriodicalUpdater("nowMember","/EPCenter/02_Member/nowMemSimple.asp",{frequency:30,decay:1})
	 </script>
	</div>

	<tr>
	    <td height="15" bgcolor="#000000" style="padding-left:10px;color:#ffffff;font-weight:bold;cursor:pointer" id="tdCast" onclick="leftMenuShowHide();">
	        �����
        </td>

	</tr>          

	<tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr1')" style="color:#ffffff; ">���־��¸޴�</a>
        </td>
    </tr>          
    <tr id="tr1">
        <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="1" >
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=0" target="ViewFrm" style="color:#000000; ">- �Խ���</a>
            </td>
        </tr>   
        <tr>
		    <td height="15">        
		        <a href="/EPCenter/07_Customer/List.asp" target="ViewFrm" style="color:#000000; ">- ������</a>
		    </td>

            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Game_7mGetData_Kr.asp" target="ViewFrm" style="color:000000; ">- 7m���Ӱ�������(�౸)</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List.asp" target="ViewFrm" style="color:#000000; ">- ���Ӱ���</a>				
                </td>
            </tr>    
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/ResultGame_Step2.asp" target="ViewFrm" style="color:#000000; ">- �����ϱ�</a>				
                </td>
            </tr>                

			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List_start.asp" target="ViewFrm" style="color:#000000; ">- ���Ӱ���(�˼�)</a>				
                </td>
            </tr>                            
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_List.asp" target="ViewFrm" style="color:#000000; ">- ���ø���Ʈ</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_DetailList.asp" target="ViewFrm" style="color:#000000; ">- �󼼹��ø���Ʈ</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/BettingSadari_DetailList.asp" target="ViewFrm" style="color:#000000; ">- �󼼹��ø���Ʈ(��ٸ�)</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/BettingSadari_List.asp" target="ViewFrm" style="color:#000000; ">- ���ø���Ʈ(��ٸ�)</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/BettingSadariRefresh_List.asp" target="ViewFrm" style="color:#000000; ">- ���ø���Ʈ(��ٸ�:���ΰ�ħ)</a>
		        </td>
            </tr>
        </tr>	   
        </table>		    
        </td>
    </tr>
	
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr3')" style="color:#ffffff; ">ȸ������</a>
        </td>
    </tr>
    <tr id="tr3">    
	    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
            <td height="15"> 
		        <a href="./02_Member/List.asp" target="ViewFrm" style="color:#000000; ">- ȸ������</a>
                </td>
            </tr>
            <tr>
            <td height="15"> 
		        <a href="./02_Member/List_Real.asp" target="ViewFrm" style="color:#000000; ">- ȸ������(����)</a>
                </td>
            </tr>
            <tr>
            <td height="15"> 
		        <a href="./02_Member/List_lvup_total.asp" target="ViewFrm" style="color:#000000; ">- ȸ��������</a>
                </td>
            </tr>
            <tr>
            <td height="15"> 
		        <a href="./02_Member/writer_list.asp" target="ViewFrm" style="color:#000000; ">- �۾���� ȸ������</a>
                </td>
            </tr>           
            <tr>
                <td height="15">          		        
		        <a href="./01_CP/Login_List.asp" target="ViewFrm" style="color:#000000; ">- �α�������</a>
                </td>
            </tr>
            <tr>
                <td height="15">          		        
		        <a href="./01_CP/Block_Ip.asp" target="ViewFrm" style="color:#000000; ">- IP������</a>
                </td>
            </tr>            
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/DoubleLoginList.asp" target="ViewFrm" style="color:#000000; ">- �ߺ��α���</a>
                </td>
            </tr>                        
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/Recom_List.asp" target="ViewFrm" style="color:000000; ">- ��õȸ������</a>
                </td>
            </tr>
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/uniqcode.asp" target="ViewFrm" style="color:000000; ">- ���� ��õ��</a>
                </td>
            </tr>                
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/nowmem.asp" target="ViewFrm" style="color:000000; ">- ���������� & ����</a>
                </td>
            </tr>            
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/pointGift.asp" target="ViewFrm" style="color:000000; ">- �ϰ�����Ʈ����</a>
                </td>
            </tr>            
        </table>            		        	
		</td>
    </tr>
                
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr5')" style="color:#ffffff; ">���Ӱ���</a>
        </td>
    </tr>
    <tr id="tr5">    
        <td>
	        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15">        		    
		            <a href="/EPCenter/06_Sports/List.asp" target="ViewFrm" style="color:#000000; ">- �������</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/03_League/List.asp" target="ViewFrm" style="color:#000000; ">- ���װ���</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Game_7mGetData_Kr.asp" target="ViewFrm" style="color:000000; ">- 7m���Ӱ�������(�౸)</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List.asp" target="ViewFrm" style="color:#000000; ">- ���Ӱ���</a>				
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List_start.asp" target="ViewFrm" style="color:#000000; ">- ���Ӱ���(�˼�)</a>				
                </td>
            </tr>                            
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/ResultGame_Step2.asp" target="ViewFrm" style="color:#000000; ">- �����ϱ�</a>				
                </td>
            </tr>                
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_List1.asp" target="ViewFrm" style="color:#000000; ">- ���ø���Ʈ</a>
		        </td>
            </tr>
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_List_New.asp?sStartDate=&sEndDate=&Search=IB_ID&Find=&IB_AMOUNT=" target="ViewFrm" style="color:#000000; ">- ��÷����</a>
		        </td>
            </tr>            
            </table>		        
        </td>
    </tr>
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr6')" style="color:#ffffff; ">����/ȯ������</a>
        </td>
    </tr>
    <tr id="tr6">  
	    <td>		
        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15">  	    
		            <a href="/EPCenter/05_Account/Charge_List.asp" target="ViewFrm" style="color:#000000; ">- ��������</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Exchange_List.asp" target="ViewFrm" style="color:#000000; ">- ȯ������</a>
                </td>
            </tr>   
 
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/CashAccount_In.asp" target="ViewFrm" style="color:#000000; ">- �Ա�����</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/CashAccount_Out.asp" target="ViewFrm" style="color:#000000; ">- �������</a>
                </td>
            </tr>    

  
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Money_AddSub.asp" target="ViewFrm" style="color:#000000; ">- �Ӵϻ��α�</a>
                </td>
            </tr>                
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/point_list.asp" target="ViewFrm" style="color:#000000; ">- ����Ʈ�����</a>
                </td>
            </tr>    
            
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Charge_Hour_stat.asp" target="ViewFrm" style="color:#000000; ">- �ð���������Ȳ</a>
		        </td>
            </tr>
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Money_Log.asp" target="ViewFrm" style="color:#000000; ">- ��¥����Ȳ</a>
		        </td>
            </tr>            
            
            
            
            </table>		      		    
		</td>
    </tr>
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr7')" style="color:#ffffff; ">������&�̺�Ʈ</a>
        </td>
    </tr>
    <tr id="tr7">  
	    <td>		
        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15">  		    
		            <a href="/EPCenter/08_Board/Board_List.asp?bType=" target="ViewFrm" style="color:#000000; ">- �Խ���</a>
                </td>
            </tr>    
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=1" target="ViewFrm" style="color:#000000; ">- ��������</a>
            </td>
        </tr>
	    <tr>
            <td height="15"> 			
	            <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=2" target="ViewFrm" style="color:#000000; ">- �̺�Ʈ</a>
            </td>
        </tr>         
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=3" target="ViewFrm" style="color:#000000; ">- �帣�°���</a>
            </td>
        </tr>   
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_contents_list.asp" target="ViewFrm" style="color:#000000; ">- �������������</a>
            </td>
        </tr>   		
        <tr>
            <td height="15"> 			
	            <a href="/EPCenter/08_Board/Pop_insert.asp" target="ViewFrm" style="color:#000000; ">- �˾�</a>
            </td>
        </tr>                
			<tr>
                <td height="15"> 			
		            <a href="/EPCenter/07_Customer/List.asp" target="ViewFrm" style="color:#000000; ">- ������</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 			
		            <a href="/EPCenter/07_Customer/List_t.asp" target="ViewFrm" style="color:#000000; ">- ���������ø�</a>
                </td>
            </tr>
            <!--                
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/inning/list.asp" target="ViewFrm" style="color:#000000; ">- �̴��̺�Ʈ</a>
                </td>
            </tr>
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/basket/list.asp" target="ViewFrm" style="color:#000000; ">- �����̺�Ʈ</a>
                </td>
            </tr>            
            
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/login/list.asp?round=1" target="ViewFrm" style="color:#000000;" >- �α����̺�Ʈ</a>
                </td>
            </tr>                        
           
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/smp/list.asp?round=1" target="ViewFrm" style="color:#000000;" >- �ζ��̺�Ʈ</a>
                </td>
            </tr>               
            
            <td height="15">          
                    <a href="/EPCenter/11_event/lotto/list.asp" target="ViewFrm" style="color:#000000;" >- �ζ��̺�Ʈ2</a>
                </td>
            </tr>
            -->              
             
            </table>		
		</td>
    </tr>       
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr4')" style="color:#ffffff; ">���&���ΰ���</a>
        </td>
    </tr>
    <tr id="tr4">    
        <td>
	        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15"> 
		            <a href="./02_Member/join_stat.asp" target="ViewFrm" style="color:000000; ">- ȸ���������</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 
		            <a href="./02_Member/Login_stat.asp" target="ViewFrm" style="color:000000; ">- �α������</a>
                </td>
            </tr>   
            <tr>
                <td height="15">         
		            <a href="./01_CP/info.asp" target="ViewFrm" style="color:#000000; ">- ����������</a>
                </td>
            </tr>   
            <%
                IF NOT USER_LEVEL_BET_USE Then
            %>
            <tr>
                <td height="15"> 		    
		            <a href="./01_CP/Setting.asp" target="ViewFrm" style="color:#000000; ">- ���Ӽ���</a>
                </td>
            </tr>   
            <%
                END IF
            %>            
            <tr>
                <td height="15"> 		    
		            <a href="./01_CP/Site_Setting.asp" target="ViewFrm" style="color:#000000; ">- ����Ʈ����</a>
                </td>
            </tr>   
    <tr>
        <td id="game_account" >
            <script>
            new Ajax.PeriodicalUpdater("game_account","/EPCenter/04_Game/game_AccountAlram.asp",{frequency:45,decay:1})
            </script>    
        </td>
    </tr>	

            </table>
        </td>
    </tr>            
</table>
<tr>
    <td height="25" align="right">
        <a href="javaScript:logOut();"><span style="color:#000000;">�α׾ƿ�</span></a>
    </td>
</tr>
</table>
<script type="text/javascript">
new Ajax.PeriodicalUpdater("Account","/EPCenter/05_Account/Money_Total_Mini.asp",{frequency:30,decay:1})
</script>    

</BODY>
</html>
