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
		AdminPosition = "마스터관리자"
	ELSEIF request.Cookies("AdminLevel") = 2 THEN
		AdminLevel = 2
		AdminPosition = "리셀러"
	END IF
%>	
<!-- #include virtual="/_Common/Inc/top.inc.asp"-->
<script language="javascript" type="text/javascript" src="Includes/common.js"></script>
<script src="/js/ajax.js" language="JavaScript" type="text/javascript"></script>
<script language="javascript" src="Includes/common.js"></script>
<script type="text/javascript">
	function logOut() {
		if (confirm("로그아웃 하시겠습니까?")) {
			top.location.href="./Login/LogOut.asp";
		}
	}
	
	function openAlarm() {
		var openUrl = "./05_Account/AccountAlarm.asp";
		window.open(openUrl,'alarm','width=300,height=50');
	}
	
	function dbInit() {
		if (confirm("리그정보를 제외한 모든 데이터가 삭제됩니다.\n정말 DB를 초기화 하시겠습니까?")) {
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
            document.getElementById("tdCast").innerHTML = "숨기기";
        }
        else
        {
            top.document.getElementById("mainFrameSet").cols = "80,*" ;
            heightDefault = 0;
            document.getElementById("tdCast").innerHTML = "펼치기";
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
	        숨기기
        </td>

	</tr>          

	<tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr1')" style="color:#ffffff; ">자주쓰는메뉴</a>
        </td>
    </tr>          
    <tr id="tr1">
        <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="1" >
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=0" target="ViewFrm" style="color:#000000; ">- 게시판</a>
            </td>
        </tr>   
        <tr>
		    <td height="15">        
		        <a href="/EPCenter/07_Customer/List.asp" target="ViewFrm" style="color:#000000; ">- 고객센터</a>
		    </td>

            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Game_7mGetData_Kr.asp" target="ViewFrm" style="color:000000; ">- 7m게임가져오기(축구)</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List.asp" target="ViewFrm" style="color:#000000; ">- 게임관리</a>				
                </td>
            </tr>    
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/ResultGame_Step2.asp" target="ViewFrm" style="color:#000000; ">- 정산하기</a>				
                </td>
            </tr>                

			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List_start.asp" target="ViewFrm" style="color:#000000; ">- 게임관리(검수)</a>				
                </td>
            </tr>                            
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_List.asp" target="ViewFrm" style="color:#000000; ">- 배팅리스트</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_DetailList.asp" target="ViewFrm" style="color:#000000; ">- 상세배팅리스트</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/BettingSadari_DetailList.asp" target="ViewFrm" style="color:#000000; ">- 상세배팅리스트(사다리)</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/BettingSadari_List.asp" target="ViewFrm" style="color:#000000; ">- 배팅리스트(사다리)</a>
		        </td>
            </tr>
			<tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/BettingSadariRefresh_List.asp" target="ViewFrm" style="color:#000000; ">- 배팅리스트(사다리:새로고침)</a>
		        </td>
            </tr>
        </tr>	   
        </table>		    
        </td>
    </tr>
	
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr3')" style="color:#ffffff; ">회원관리</a>
        </td>
    </tr>
    <tr id="tr3">    
	    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
            <td height="15"> 
		        <a href="./02_Member/List.asp" target="ViewFrm" style="color:#000000; ">- 회원정보</a>
                </td>
            </tr>
            <tr>
            <td height="15"> 
		        <a href="./02_Member/List_Real.asp" target="ViewFrm" style="color:#000000; ">- 회원정보(실제)</a>
                </td>
            </tr>
            <tr>
            <td height="15"> 
		        <a href="./02_Member/List_lvup_total.asp" target="ViewFrm" style="color:#000000; ">- 회원등업대상</a>
                </td>
            </tr>
            <tr>
            <td height="15"> 
		        <a href="./02_Member/writer_list.asp" target="ViewFrm" style="color:#000000; ">- 글쓰기용 회원정보</a>
                </td>
            </tr>           
            <tr>
                <td height="15">          		        
		        <a href="./01_CP/Login_List.asp" target="ViewFrm" style="color:#000000; ">- 로그인정보</a>
                </td>
            </tr>
            <tr>
                <td height="15">          		        
		        <a href="./01_CP/Block_Ip.asp" target="ViewFrm" style="color:#000000; ">- IP블럭정보</a>
                </td>
            </tr>            
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/DoubleLoginList.asp" target="ViewFrm" style="color:#000000; ">- 중복로그인</a>
                </td>
            </tr>                        
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/Recom_List.asp" target="ViewFrm" style="color:000000; ">- 추천회원정보</a>
                </td>
            </tr>
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/uniqcode.asp" target="ViewFrm" style="color:000000; ">- 가입 추천장</a>
                </td>
            </tr>                
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/nowmem.asp" target="ViewFrm" style="color:000000; ">- 현재접속자 & 쪽지</a>
                </td>
            </tr>            
            <tr>
                <td height="15">          		        
		        <a href="./02_Member/pointGift.asp" target="ViewFrm" style="color:000000; ">- 일괄포인트지급</a>
                </td>
            </tr>            
        </table>            		        	
		</td>
    </tr>
                
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr5')" style="color:#ffffff; ">게임관리</a>
        </td>
    </tr>
    <tr id="tr5">    
        <td>
	        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15">        		    
		            <a href="/EPCenter/06_Sports/List.asp" target="ViewFrm" style="color:#000000; ">- 종목관리</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/03_League/List.asp" target="ViewFrm" style="color:#000000; ">- 리그관리</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Game_7mGetData_Kr.asp" target="ViewFrm" style="color:000000; ">- 7m게임가져오기(축구)</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List.asp" target="ViewFrm" style="color:#000000; ">- 게임관리</a>				
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/List_start.asp" target="ViewFrm" style="color:#000000; ">- 게임관리(검수)</a>				
                </td>
            </tr>                            
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/ResultGame_Step2.asp" target="ViewFrm" style="color:#000000; ">- 정산하기</a>				
                </td>
            </tr>                
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_List1.asp" target="ViewFrm" style="color:#000000; ">- 배팅리스트</a>
		        </td>
            </tr>
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/04_Game/Betting_List_New.asp?sStartDate=&sEndDate=&Search=IB_ID&Find=&IB_AMOUNT=" target="ViewFrm" style="color:#000000; ">- 당첨샷용</a>
		        </td>
            </tr>            
            </table>		        
        </td>
    </tr>
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr6')" style="color:#ffffff; ">충전/환전관리</a>
        </td>
    </tr>
    <tr id="tr6">  
	    <td>		
        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15">  	    
		            <a href="/EPCenter/05_Account/Charge_List.asp" target="ViewFrm" style="color:#000000; ">- 충전관리</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Exchange_List.asp" target="ViewFrm" style="color:#000000; ">- 환전관리</a>
                </td>
            </tr>   
 
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/CashAccount_In.asp" target="ViewFrm" style="color:#000000; ">- 입금정산</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/CashAccount_Out.asp" target="ViewFrm" style="color:#000000; ">- 출금정산</a>
                </td>
            </tr>    

  
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Money_AddSub.asp" target="ViewFrm" style="color:#000000; ">- 머니사용로그</a>
                </td>
            </tr>                
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/point_list.asp" target="ViewFrm" style="color:#000000; ">- 포인트사용기록</a>
                </td>
            </tr>    
            
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Charge_Hour_stat.asp" target="ViewFrm" style="color:#000000; ">- 시간별충전현황</a>
		        </td>
            </tr>
            <tr>
                <td height="15"> 		    
		            <a href="/EPCenter/05_Account/Money_Log.asp" target="ViewFrm" style="color:#000000; ">- 날짜별현황</a>
		        </td>
            </tr>            
            
            
            
            </table>		      		    
		</td>
    </tr>
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr7')" style="color:#ffffff; ">고객센터&이벤트</a>
        </td>
    </tr>
    <tr id="tr7">  
	    <td>		
        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15">  		    
		            <a href="/EPCenter/08_Board/Board_List.asp?bType=" target="ViewFrm" style="color:#000000; ">- 게시판</a>
                </td>
            </tr>    
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=1" target="ViewFrm" style="color:#000000; ">- 공지사항</a>
            </td>
        </tr>
	    <tr>
            <td height="15"> 			
	            <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=2" target="ViewFrm" style="color:#000000; ">- 이벤트</a>
            </td>
        </tr>         
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_List.asp?BF_LEVEL=3" target="ViewFrm" style="color:#000000; ">- 흐르는공지</a>
            </td>
        </tr>   
        <tr>
            <td height="15">        
                <a href="/EPCenter/08_Board/Board_contents_list.asp" target="ViewFrm" style="color:#000000; ">- 댓글컨텐츠관리</a>
            </td>
        </tr>   		
        <tr>
            <td height="15"> 			
	            <a href="/EPCenter/08_Board/Pop_insert.asp" target="ViewFrm" style="color:#000000; ">- 팝업</a>
            </td>
        </tr>                
			<tr>
                <td height="15"> 			
		            <a href="/EPCenter/07_Customer/List.asp" target="ViewFrm" style="color:#000000; ">- 고객센터</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 			
		            <a href="/EPCenter/07_Customer/List_t.asp" target="ViewFrm" style="color:#000000; ">- 고객센터템플릿</a>
                </td>
            </tr>
            <!--                
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/inning/list.asp" target="ViewFrm" style="color:#000000; ">- 이닝이벤트</a>
                </td>
            </tr>
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/basket/list.asp" target="ViewFrm" style="color:#000000; ">- 쿼터이벤트</a>
                </td>
            </tr>            
            
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/login/list.asp?round=1" target="ViewFrm" style="color:#000000;" >- 로그인이벤트</a>
                </td>
            </tr>                        
           
            <tr>
                <td height="15">          
                    <a href="/EPCenter/11_event/smp/list.asp?round=1" target="ViewFrm" style="color:#000000;" >- 로또이벤트</a>
                </td>
            </tr>               
            
            <td height="15">          
                    <a href="/EPCenter/11_event/lotto/list.asp" target="ViewFrm" style="color:#000000;" >- 로또이벤트2</a>
                </td>
            </tr>
            -->              
             
            </table>		
		</td>
    </tr>       
    <tr>
	    <td height="20" bgcolor="#2E5EA0" style="padding-left:10px;">
	        <a href="javaScript:showHide('tr4')" style="color:#ffffff; ">통계&메인관리</a>
        </td>
    </tr>
    <tr id="tr4">    
        <td>
	        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
            <tr>
                <td height="15"> 
		            <a href="./02_Member/join_stat.asp" target="ViewFrm" style="color:000000; ">- 회원가입통계</a>
                </td>
            </tr>    
            <tr>
                <td height="15"> 
		            <a href="./02_Member/Login_stat.asp" target="ViewFrm" style="color:000000; ">- 로그인통계</a>
                </td>
            </tr>   
            <tr>
                <td height="15">         
		            <a href="./01_CP/info.asp" target="ViewFrm" style="color:#000000; ">- 관리자정보</a>
                </td>
            </tr>   
            <%
                IF NOT USER_LEVEL_BET_USE Then
            %>
            <tr>
                <td height="15"> 		    
		            <a href="./01_CP/Setting.asp" target="ViewFrm" style="color:#000000; ">- 게임설정</a>
                </td>
            </tr>   
            <%
                END IF
            %>            
            <tr>
                <td height="15"> 		    
		            <a href="./01_CP/Site_Setting.asp" target="ViewFrm" style="color:#000000; ">- 사이트설정</a>
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
        <a href="javaScript:logOut();"><span style="color:#000000;">로그아웃</span></a>
    </td>
</tr>
</table>
<script type="text/javascript">
new Ajax.PeriodicalUpdater("Account","/EPCenter/05_Account/Money_Total_Mini.asp",{frequency:30,decay:1})
</script>    

</BODY>
</html>
