<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include file="../../_Common/Lib/MailCom.Class.asp" -->
<%
	IB_IDX		= REQUEST("IB_IDX")
	PAGE		= REQUEST("Page")
	sStartDate	= REQUEST("sStartDate")
	sEndDate	= REQUEST("sEndDate")
	Search		= REQUEST("Search")
	Find		= REQUEST("Find")
	str = "" 
	str = str &  "<html><head><title></title></head><body>"
		SQLMSG = "SELECT IB_Type,IG_Idx,IB_Num,IB_Benefit,IB_Amount,CONVERT(VARCHAR, IB_RegDate, 102) + ' ' + CONVERT(VARCHAR(5), IB_RegDate, 114) AS IB_RegDate,IB_ID,IB_SITE FROM INFO_BETTING WHERE IB_Idx="& IB_Idx &""
		SET RS = DbCon.Execute(SQLMSG)

		IB_Type = rs("IB_Type")
		IG_Idx  =rs("IG_Idx")
		IB_Num = rs("IB_Num")
		IB_Benefit = rs("IB_Benefit")
		IB_Amount = rs("IB_Amount")
		IB_RegDate = rs("IB_RegDate")
		IB_ID = rs("IB_ID")
		IB_SITE = rs("IB_SITE")
        
        str = str & " <table border='1' bordercolorlight='#706E6E' cellspacing='0' cellpadding='1' bordercolordark='#bebebe' width='100%'>"
        str = str & " <tr><td bgcol or='706E6E' style='padding-left:12' height='23'>"
        str = str & " 	<b><font co lor='FFFF00'>게임 관리</font><font color='ffffff'>&nbsp;&nbsp;▶ 배팅 상세 - [ 아이디 : " &IB_ID & " / 사이트명 : " & IB_SITE & " ]</font></b></td></tr></table>"
                      
        str = str & " <table border ='1' bordercolorlight='#706E6E' cellspacing='0' cellpadding='1' bordercolordark='#bebebe' width='100%'>"
        str = str & " <tr><td width ='40' rowspan='2' align='center'>NO</td>"
        str = str & "     <td width ='100' rowspan='2' align='center'>경기일자</td>"
        str = str & "     <td rowsp an='2' align='center'>리그</td>"
        str = str & "     <td rowsp an='2' align='center'>홈 vs 원정</td>"
        str = str & "     <td colsp an='3' width='150' align='center'  class='white bold'>배당률</td>"
        str = str & "     <td width ='50' rowspan='2' align='center'  >배팅내역</td>"
        str = str & "     <td width ='80' rowspan='2' align='center'  >결과</td>"
        str = str & "     <td width ='80' rowspan='2' align='center'  >배팅일자</td></tr>"
        str = str & " <tr>     "     
        str = str & " 	<td width=' 40' height='22' align='center'  class='white'>승</td>"
        str = str & " 	<td width=' 40' align='center'  class='white'>무</td>"
        str = str & " 	<td width=' 40' align='center'  class='white'>패</td></tr>"
	
		IF IB_Type = "M" THEN
			arr_IG_Idx = split(IG_Idx, ",")
			arrLen = UBound(arr_IG_Idx)
			GameCnt = arrLen+1
			arr_IB_Num = split(IB_Num, ",")
			arr_IB_Benefit = split(IB_Benefit,",")
		END IF

		IF IB_Type = "S" THEN

			SQLMSG = "SELECT RL_League,IG_Status, IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Result, IG_Team1Benefit, "
			SQLMSG = SQLMSG & " IG_DrawBenefit, IG_Team2Benefit FROM INFO_GAME WHERE IG_Idx = '"& IG_Idx &"' "
			SET RS1 = DbCon.Execute(SQLMSG)			

			RL_League = rs1("RL_League")
			IG_Team1 = rs1("IG_Team1")
			IG_Team2 = rs1("IG_Team2")
			IG_Status = rs1("IG_Status")
			IG_Result = rs1("IG_Result")
			IG_StartTime = rs1("IG_StartTime")
			IG_Team1Benefit = rs1("IG_Team1Benefit")
			IG_DrawBenefit = rs1("IG_DrawBenefit")
			IG_Team2Benefit = rs1("IG_Team2Benefit")
			IG_Handicap = rs1("IG_Handicap")
			
			If IB_Num = 1 then
				'// TotalBenefitRate = rs1("IG_Team1Benefit")
				choice = "<span class='yellow bold'>승</span>"
			Elseif IB_Num = 0 then
				'// TotalBenefitRate = rs1("IG_DrawBenefit")
				choice = "<span class='white bold'>무</span>"
			Elseif IB_Num = 2 then
				'//TotalBenefitRate = rs1("IG_Team2Benefit")
				choice = "<span class='red bold'>패</span>"
			End if
			
			TotalBenefit = Cdbl(IB_Benefit) * Cdbl(IB_Amount)
			
			if IG_Status = "S" or IG_Status = "E" then
				ProcFlag = "false"
				ResultFlag = "false"
			else							'// F(게임졀과 적용)...이면...
				ProcFlag = "true"
				if IG_Status = "C" then
					ResultFlag = "true"
				else
					if Cint(IG_Result) = Cint(IB_Num) then
						ResultFlag = "true"
					else
						ResultFlag = "false"
					end if
				end if
			end if
			
			If IG_Status = "C" then
				DspResult = "<td align='center'><span style='color:gray;font-weight:bold;'>취소</span></td>"
				bgColor = "White"
			Else	
				If ProcFlag = "true" and ResultFlag = "true" then
					DspResult = "<td align='center'><span style='color:orange;font-weight:bold;'>적중</span></td>"
					bgColor = "Yellow"
				Elseif ProcFlag = "true" and ResultFlag = "false" then
					DspResult = "<td align='center'><span style='color:red;font-weight:bold;'>실패</span></td>"
					bgColor = "Red"
				Else
					bgColor = "gray"
					DspResult = "<td align='center'><span style='color:blud;font-weight:bold;'>진행중</span></td>"
				End if
			End if
			
			'// TotalBenefit = Cdbl(TotalBenefitRate) * Cdbl(IB_Amount)
			
	    str = str & " <tr> "
        str = str & "<td rowspan='2' align='center'>1</td>"
        str = str & "				<td height='20' align='center'>" & IG_StartTime & "</td>"
        str = str & "				<td>&nbsp;" & RL_League & "</td>"
        str = str & "				<td align='center'>" & IG_Team1
        
        if IG_Handicap <> 0 then 
            str = str & "(<font color='ff0000'>" & IG_Handicap & "</font>)"
        end if
        
        str = str & "								 : "
        str = str & IG_Team2

        str = str & "</td><td align='center'>"
        
        if IB_Num = 1 then 
            str = str & IB_Benefit 
        else 
            str = str & IG_Team1Benefit
        end if 
        
        str = str & "   </td>"        
        str = str & "   <td align='center'>"
        
        if IB_Num = 0 then
            str = str &  IB_Benefit
        else
            str = str & IG_DrawBenefit 
        end if
        
        str = str & "   </td>"        
        str = str & "   <td align='center'>"
        
        if IB_Num = 2 then
            str = str & IB_Benefit
        else 
            str = str &  IG_Team2Benefit 
        end if
        str = str & "   </td>"        
        str = str & "   <td align='center'>" & choice & "</td>"        
        str = str & DspResult
        str = str & "   <td align='center' class='td_game'>" & IB_RegDate & "</td>"
        str = str & "</tr>"
        str = str & "<tr>"
        str = str & "	<td height='22' align='center'  class='td_result'>배팅금액</td>"
        str = str & "				<td align='center'>" & formatnumber(IB_Amount,0) & "</td>"
        str = str & "				<td align='center'>예상배당률</td>"
        str = str & "				<td colspan='3' align='center'  class='yellow bold'>"
        
        If IG_Status = "C" then 
            str = str & "					<font color=white>--</font>"
        Else
            str = str & 					formatnumber(IB_Benefit,2) & "</td>"
        End if 
        
        str = str & "				<td align='center'>배당금</td>"
        str = str & "				<td align='center'>"
        if IG_Status = "C" then 
            str = str & "					<font color=white>--</font>"
        else
            str = str & 					formatnumber(TotalBenefit,0)        
        end if
        str = str & "				</td>"
        str = str & "				<td align='center'>"
	    If IG_Status = "S" or IG_Status = "E" then
                str = str & " '진행중'"
        Elseif IG_Status = "C" then
            str = str &  "<font color='gray'>게임취소</font>"
        Elseif IG_Status = "F" then
            str = str & "					 '게임종료'"
	    end if
        str = str & "				</td>"
        str = str & "			  </tr>"
        
	Else
		TotalBenefitRate = 1
						
		ProcFlag = "true"
		ResultFlag = "true"
						
		StrProc = ""
		StrResult = ""
		
		CancelCnt = 0
		for i=0 to arrLen

			SQLMSG = "SELECT RL_League,IG_Status, CONVERT(VARCHAR, IG_StartTime, 102) + ' ' + CONVERT(VARCHAR(5), IG_StartTime, 114) AS IG_StartTime, IG_Team1, IG_Team2, IG_Handicap, IG_Result, IG_Team1Benefit, "
			SQLMSG = SQLMSG & " IG_DrawBenefit, IG_Team2Benefit FROM INFO_GAME WHERE IG_Idx = '"& arr_IG_Idx(i) &"' "
			SET RS1 = DbCon.Execute(SQLMSG)

				RL_League = rs1("RL_League")
				IG_Team1 = rs1("IG_Team1")
				IG_Team2 = rs1("IG_Team2")
				IG_Status = rs1("IG_Status")
				IG_Result = rs1("IG_Result")
				IG_StartTime = rs1("IG_StartTime")
				IG_Team1Benefit = rs1("IG_Team1Benefit")
				IG_DrawBenefit = rs1("IG_DrawBenefit")
				IG_Team2Benefit = rs1("IG_Team2Benefit")
				IG_Handicap = rs1("IG_Handicap")
				
				If arr_IB_Num(i) = 1 then
					BenefitRate = arr_IB_Benefit(i)
					choice = "<span style='color:orange;font-weight:bold;'>승</span>"
				Elseif arr_IB_Num(i) = 0 then
					BenefitRate = arr_IB_Benefit(i)
					choice = "<span style='color:gray;font-weight:bold;'>무</span>"
				Elseif arr_IB_Num(i) = 2 then
					BenefitRate = arr_IB_Benefit(i)
					choice = "<span style='color:red;font-weight:bold;'>패</span>"
				End if
								
				'// 게임이 아직 끝나지 않았으면...
				if IG_Status = "S" or IG_Status = "E" then
					ProcFlag = "false"
				else
					ProcFlag = "true"
					
					if IG_Status = "C" then
						ResultFlag = "true"
					else
						'// 게임종료...적중실패...
						if Cint(IG_Result) = Cint(arr_IB_Num(i)) then
							ResultFlag = "true"
						else
							ResultFlag = "false"
						end if
					end if
				end if
				
				if ProcFlag = "true" and ResultFlag = "true" then
					bgColor = "yellow"
					bgShape = "0"
				Elseif ProcFlag = "true" and ResultFlag = "false" then
					bgColor = "red"
					bgShape = "X"
				else
					bgColor = "gray"
					bgShape = "△"
				end if
				
				StrProc = StrProc & "," & ProcFlag
				
				If ProcFlag = "true" and ResultFlag = "true" then
					If IG_Status = "C" then
						DspResult = "<td align='center'><span style='color:gray;font-weight:bold;'>취소</span></td>"
					else
						DspResult = "<td align='center'><span style='color:orange;font-weight:bold;'>적중</span></td>"
					end if
				Elseif ProcFlag = "true" and ResultFlag = "false" then
					DspResult = "<td align='center'><span style='color:red;font-weight:bold;'>실패</span></td>"
				Else
					DspResult = "<td align='center'><span style='color:blue;font-weight:bold;'>진행중</span></td>"
				End if

        str = str & "<tr>"
        if i = 0 then 
            str = str & "<td rowspan=" &  arrLen+2 & " align=center >1</td>"
        end if 
        str = str & "<td height='20' align='center' class='td_game'>" & IG_StartTime & "</td>"
		str = str & "<td class='td_game'>" & RL_League & "</td>"
		str = str & "<td align='center' class='td_game bold'>"
		str = str & left(IG_Team1,15) 
        if IG_Handicap <> 0 then 
            str = str & "(<font color='ff0000'>" & IG_Handicap & "</font>)"
        end if
								 
		str = str & ": " & left(IG_Team2,15)
								
		str = str & "</td><td align='center'>"
		if arr_IB_Num(i) = 1 then
		    str = str &  formatnumber(arr_IB_Benefit(i),2)
		else
		    str = str & formatnumber(IG_Team1Benefit,2)
		end if 
        str = str & "</td><td align='center'>"
        if arr_IB_Num(i) = 0 then
            str = str & formatnumber(arr_IB_Benefit(i),2)
        else
            str = str & formatnumber(IG_DrawBenefit,2) 
        end if 
        str = str & "</td><td align='center'>"
        if arr_IB_Num(i) = 2 then
            str = str & formatnumber(arr_IB_Benefit(i),2)
        else
            str = str & formatnumber(IG_Team2Benefit,2) 
        end if        
	    str = str & "</td><td align='center'>" & choice & "</td>"  & DspResult

		if i = 0 then
            str = str & "<td rowspan='" & arrLen+1 &"' align='center' class='td_game'>"
			ibregdate = split(IB_RegDate, " ")
		    str = str &  ibregdate(0) & "<br>" & ibregdate(1) & "</td>"
		end if
		str = str & " </tr>	"
			  

		    if IG_Status <> "C" then
			    TotalBenefitRate = Cdbl(TotalBenefitRate) * Cdbl(BenefitRate)
		    else
			    CancelCnt = CancelCnt + 1
		    end if
		next
			TotalBenefit = int(TotalBenefitRate*100)/100 * Cdbl(IB_Amount)
		
		'// 최종 승패결과...
		find_proc = Instr(StrProc,"false")
		'// find_result = Instr(StrResult,"false")
        str = str & "<tr>"
		str = str & "<td height='22' align='center'  class='td_result'>배팅금액</td>"
		str = str & "<td align='center'  class='yellow bold'>" & formatnumber(IB_Amount,0) &"</td>"
		str = str & "<td align='center'  class='td_result'>예상배당률</td>"
		str = str & "<td colspan='3' align='center'  class='yellow bold'>"
	    if Cint(CancelCnt) = Cint(arrLen)+1 then 
		    str = str & "<font color=white>--</font>"
        else 
			str = str & numdel(TotalBenefitRate)
        end if 
        str = str & "</td>"
        str = str & "<td align='center'  class='td_result'>배당금</td>"
		str = str & "<td align='center'  class='yellow bold'>"
        
        if Cint(CancelCnt) = Cint(arrLen)+1 then 
            str = str & "					<font style='color:#ffffff;'>--</font>"
        else 
            str = str &  formatnumber(TotalBenefit,0)
        end if
		str = str & "</td>"
        str = str & "<td align='center'  class='yellow'>"

					If Cint(CancelCnt) = Cint(arrLen)+1 then
						 str = str & " <font color=white>게임취소</font>"
					else
						If find_proc > 0 then
							 str = str & " 진행중"
						Else
							 str = str & " 게임종료"
						end if
					end if
        str = str & "</td>"
		str = str & "</tr>"
	End if
	str = str & "</table>"
	
    'response.write str
    'response.Write "받는 이메일 주소 pureto@live.co.kr  "
    pSubject = "▶ 배팅 상세 - [ 아이디 : " &IB_ID & " / 사이트명 : " & IB_SITE & " ]"
    
    Call dfMailCom.MailSend("hisoo@live.co.kr", "admin@pureto.co.kr", pSubject, str, True)
    
    
	RS1.Close
	Set RS1 = Nothing	

	RS.Close
	Set RS = Nothing	

	DbCon.Close
	Set DbCon=Nothing
%>
<script>
alert("메일발송되었습니다.");
history.back();
</script>