<script type="text/javascript">
var target;

function MiniCal(jucke) {
	target=jucke
	x = (document.layers) ? loc.pageX : event.clientX;
	y = (document.layers) ? loc.pageY : event.clientY;
	minical.style.pixelTop	= y+10;
	minical.style.pixelLeft	= x-50;
	minical.style.display = (minical.style.display == "block") ? "none" : "block";
	Show_cal(0,0,0)
}
var stime
function doOver() {
	var el = window.event.srcElement;
	cal_Day = el.title;

	if (cal_Day.length > 7) {
		el.style.borderTopColor = el.style.borderLeftColor = "buttonhighlight";
		el.style.borderRightColor = el.style.borderBottomColor = "buttonshadow";
	}
	window.clearTimeout(stime);
}
function doClick() {
	cal_Day = window.event.srcElement.title;
	
	window.event.srcElement.style.borderColor = "red";
	if (cal_Day.length > 7) {
		target.value=cal_Day
	}
}
function doOut() {
	var el = window.event.fromElement;
	cal_Day = el.title;

	if (cal_Day.length > 7) {
		el.style.borderColor = "white";
	}
	stime=window.setTimeout("minical.style.display='none';", 200);
}

</script>

<Script Language="Vbscript">
Function Show_cal(sYear,sMonth,sDay)
	document.all.minical.innerHTML=""
	datToday=date()

	intThisYear	=	cint("0"&sYear) '년도넘겨받기
	intThisMonth=	cint("0"&sMonth) '월 넘겨받기
	intThisDay	=	cint("0"&sDay)

	if intThisYear	=0 then intThisYear=Year(datToday)		'만약 년도와 월값을 넘겨받지 않았다면 현재 년도를 년도 변수에
	if intThisMonth	=0 then intThisMonth=Month(datToday)	' 현재 월을 월 변수에
	if intThisDay	=0 then intThisDay=day(datToday)		'오늘 날짜

	if intThisMonth=1 then
		intPrevYear=intThisYear-1
		intPrevMonth=12
		intNextYear=intThisYear
		intNextMonth=2
	elseif intThisMonth=12 then
		intPrevYear=intThisYear
		intPrevMonth=11
		intNextYear=intThisYear + 1
		intNextMonth=1
	else
		intPrevYear=intThisYear
		intPrevMonth=intThisMonth -1
		intNextYear=intThisYear
		intNextMonth=intThisMonth+1
	end if

	NowThisYear=Year(datToDay) ' 현재연도값
	NowThisMonth=Month(datToday) '현재 월값
	NowThisDay=Day(datToday) '오늘 날짜 값

	datFirstDay=DateSerial(intThisYear, intThisMonth, 1) '넘겨받은 날짜의 월초기값 파악
	intFirstWeekday=Weekday(datFirstDay, vbSunday) '넘겨받은 날짜의 주초기값 파악
	intSecondWeekday=intFirstWeekday
	intThirdWeekday=intFirstWeekday

	datThisDay=cdate(intThisYear&"-"&intThisMonth&"-"&intThisDay)
	intThisWeekday=Weekday(datThisDay)

	Select Case intThisWeekday
		Case 1	varThisWeekday="일"
		Case 2	varThisWeekday="월"
		Case 3	varThisWeekday="화"
		Case 4	varThisWeekday="수"
		Case 5	varThisWeekday="목"
		Case 6	varThisWeekday="금"
		Case 7	varThisWeekday="토"
	End Select

	intPrintDay=1 '출력 초기일 값은 1부터
	secondPrintDay=1
	thirdPrintDay=1

	Stop_Flag=0

	if intThisMonth=4 or intThisMonth=6 or intThisMonth=9 or intThisMonth=11 then  '월말 값 계산
		intLastDay=30
	elseif intThisMonth=2 and not (intThisYear mod 4) = 0 then
		intLastDay=28
	elseif intThisMonth=2 and (intThisYear mod 4) = 0 then
		if (intThisYear mod 100) = 0 then
			if (intThisYear mod 400) = 0 then
				intLastDay=29
			else
				intLastDay=28
			end if
		else
			intLastDay=29
		end if
	else
		intLastDay=31
	end if

	if intPrevMonth=4 or intPrevMonth=6 or intPrevMonth=9 or intPrevMonth=11 then  '월말 값 계산
		intPrevLastDay=30
	elseif intPrevMonth=2 and not (intPrevYear mod 4) = 0 then
		intPrevLastDay=28
	elseif intPrevMonth=2 and (intPrevYear mod 4) = 0 then
		if (intPrevYear mod 100) = 0 then
			if (intPrevYear mod 400) = 0 then
				intPrevLastDay=29
			else
				intPrevLastDay=28
			end if
		else
			intPrevLastDay=29
		end if
	else
		intPrevLastDay=31
	end if

	Stop_Flag=0
	Cal_HTML=Cal_HTML& "<table border=0 cellpadding=1 cellspacing=1  onmouseover='doOver()' onmouseout='doOut()' onclick='doClick()' style='font-size : 12;font-family:굴림;'>"
	Cal_HTML=Cal_HTML& "<tr align=center>"
	Cal_HTML=Cal_HTML& "<td align=left  title='이전달' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intPrevYear&","&intPrevMonth&",1)'><font color=navy size=2>&lt;&lt;</font></td>"
	Cal_HTML=Cal_HTML& "<td colspan=5><font color=red><b>"
	Cal_HTML=Cal_HTML& intThisYear&"년 "&intThisMonth&"월"
	Cal_HTML=Cal_HTML& "</font></b></td>"
	Cal_HTML=Cal_HTML& "<td align=right title='다음달' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intNextYear&","&intNextMonth&",1)'><font color=navy size=2>&gt;&gt;</font></a></td>"
	Cal_HTML=Cal_HTML& "</tr>"
	Cal_HTML=Cal_HTML& "<tr align=center bgcolor=navy style='color:white; font-weight:bold'>"
	Cal_HTML=Cal_HTML& "<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>"
	Cal_HTML=Cal_HTML& "</tr>"

	FOR intLoopWeek=1 to 6   '주단위 루프 시작, 최대 6주

		Cal_HTML=Cal_HTML& "<tr align=right valign=top bgcolor=white >"
		for intLoopDay=1 to 7 '요일단위 루프 시작, 일요일부터

			if intThirdWeekDay > 1 then '첫주시작일이 1보다 크면
				Cal_HTML=Cal_HTML& "<td>&nbsp;</td>"
				intThirdWeekDay=intThirdWeekDay-1
			else
				if thirdPrintDay > intLastDay then '입력날짜가 월말보다 크다면
					Cal_HTML=Cal_HTML& "<td>&nbsp;</td>"
				else '입력날짜가 현재월에 해당되면
					IF intThisMonth <= 9 THEN
						t_intThisMonth = "0"&intThisMonth
					ELSE 
						t_intThisMonth = intThisMonth
					END IF 
					IF thirdPrintDay <= 9 THEN
						t_thirdPrintDay = "0"&thirdPrintDay
					ELSE
						t_thirdPrintDay = thirdPrintDay
					END IF 
					
					'Cal_HTML=Cal_HTML& "<td title='"&intThisYear&"-"&intThisMonth&"-"&thirdPrintDay&"' style='cursor: hand;border: 1px solid white;width:18; height:18;"
					Cal_HTML=Cal_HTML& "<td title='"&intThisYear & "-" & t_intThisMonth & "-" & t_thirdPrintDay&"' style='cursor: hand;border: 1px solid white;width:18; height:18;"
					if intThisYear-NowThisYear=0 and intThisMonth-NowThisMonth=0 and thirdPrintDay-intThisDay=0 then '오늘 날짜이면은 글씨폰트를 다르게
						Cal_HTML=Cal_HTML& "background-color:cyan;"
					end if
					if  intLoopDay=1 then '일요일이면 빨간 색으로
						Cal_HTML=Cal_HTML& "color:red;"
					else ' 그외의 경우
						Cal_HTML=Cal_HTML& "color:black;"
					end if
					Cal_HTML=Cal_HTML& "'>"&thirdPrintDay
				end if
				thirdPrintDay=thirdPrintDay+1 '날짜값을 1 증가

				if thirdPrintDay > intLastDay then	Stop_Flag=1	 '만약 날짜값이 월말값보다 크면 루프문 탈출

			end if
			Cal_HTML=Cal_HTML& "</td>"
		next
		Cal_HTML=Cal_HTML& "</tr>"
		if Stop_Flag=1 then	EXIT FOR
	NEXT
	Cal_HTML=Cal_HTML& "</table>"
	Cal_HTML=Cal_HTML& ""
	Cal_HTML=Cal_HTML& ""
	document.all.minical.innerHTML=Cal_HTML
END Function
</SCRIPT>