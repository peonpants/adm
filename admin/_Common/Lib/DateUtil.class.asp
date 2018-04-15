<%
'
' DateUtil.class.asp 날짜 관련 함수 모음  클래스
' 기본 날짜형은 YYYY-MM-DD형식으로 반환 된다. 
'
' Date : 2005.3.2 by offman 
'



Class	DateUtil

   public mDate  ' 날짜 CDate Type으로 저장 

   
   ' CDate Type를 날짜를 Default 로 사용한다.   
   Public Default Property Get GetDate ()
   
   	GetDate = mDate 
   	
   End Property 
   
   ' 해당 년도를 가지고 온다.
   
   Public Property Get GetYear ()
   
   	GetYear = Year( mDate ) 
   	
   End Property 

    
   ' 해당 월을 가지고 온다.
   Public Property Get GetMonth ()
   
   	GetMonth = Month( mDate ) 
   	
   End Property 
  
   ' 해당 일을 가지고 온다.
    Public Property Get GetDay ()
   
   	GetDay = Month( mDate ) 
   	
   End Property 
  
    
	' 현재 시각을 셋팅한다. 
	Public Function SetNow ( )
		
		mDate  = CDate(Date)
		
		SetNow = mDate
		
	End Function
	
	' 내부 함수,  지정된 날짜를 셋팅한다. 
	Private Function SetMDate( pDate )
	
		mDate =  CDate( pDate )
		
		SetMDate = mDate
		
	End Function 
	
	
	' 지정된 날짜를 셋팅한다. 
	Public Function SetDate( pDate, pToken )
		
		If IsNull(pToken) or Len(pToken ) = 0 Then
		
			SetDate = SetDate1(pDate) 
			
		Else 
			SetDate = SetDate2(pDate, pToken )
		End If
		
	End Function
	
	
	' 지정된 날짜를 셋팅한다. 
	Public Function SetDate1( pDate )
		
		Dim fYear, fMonth, fDay
		fYear = mid(pDate,1,4)
		fMonth = mid(pDate,5,2)
		fDay = mid(pDate,7,2)
		
		SetMDate( fYear &"-"& fMonth &"-"& fDay )
		
		SetDate1 = mDate
		
	End Function
	
	
	' 지정된 날짜를 셋팅한다. 
	Public Function SetDate2( pDate, pToken )
		
		Dim fArr
		Dim fYear, fMonth, fDay
	
			
		fArr = Split( pDate, pToken )
		
		fYear = fArr(0)
		fMonth = fArr(1)
		fDay = fArr(2)
		
		SetMDate( fYear &"-"& fMonth &"-"& fDay )
		
		SetDate2 = mDate
		
	End Function
	
	' 해당 요일을 가지고 온다. ( 0 - 일요일, 1 - 월요일 ... ) 
	
	Public Function GetWeekDay(  ) 
	
		GetWeekDay = WeekDay( mDate ) 
	
	End Function	
	
	' 해당 요일을 가지고 온다. ( 월,화,수,목,금,토) 
	
	
	Public Function GetWeekDayName( ) 
	
		Dim CWeekName( 7 ) 
		CWeekName(1) =  "일"
		CWeekName(2) =  "월"
		CWeekName(3) =  "화"
		CWeekName(4) =  "수"
		CWeekName(5) =  "목"
		CWeekName(6) =  "금"
		CWeekName(7) =  "토"
		
		GetWeekDayName = CWeekName(WeekDay( mDate ))	
		
	End Function	
	
	' 일단위로 날짜를 이동한다. 
	
	Public function SetAddDay( pDays )
			
			SetAddDay = SetMDate( DateAdd("d", pDays, mDate) )
			
	End Function
	
	' 주단위로 날짜를 이동한다. 
	
	Public function SetAddWeek( pWeeks )
			
			SetAddWeek = SetMDate( DateAdd("ww", pWeeks, mDate) )
			
	End Function
	
	' 월단위로 날짜를 이동한다. 
	
	Public function SetAddMonth( pMonths )
			
			SetAddMonth = SetMDate( DateAdd("m", pMonths, mDate) )
			
	End Function
	
	' 년단위로 날자르 이동한다 

	Public function SetAddYear( pYears )
			
			SetAddYear = SetMDate( DateAdd("yyyy", pYears, mDate) )
			
	End Function
	
	' Return : 해당월의 첫째날
	Public function GetFirstDateInMonth()
		Dim tmpDate 
		GetFirstDateInMonth = CDate(GetYear   & "-" & GetMonth & "-01")
	End function
	
	
	
	' Return : 해당월의 마지막날
	Public function GetLastDateInMonth()
		
		Dim tmpDate 
		tmpDate		= GetYear   & "-" & GetMonth & "-01"
		tmpDate		= DateAdd("m", 1, CDate(tmpDate))
		GetLastDateInMonth		= CDate(DateAdd("d",-1, tmpdate))
	End function
	
	
	' Return : 특정월의 마지막날
	Public function GetLastDateInReqMonth( pYears, pMonths )
		
		Dim tmpDate 
		tmpDate		= pYears & "-" & pMonths & "-01"
		tmpDate		= DateAdd("m", 1, CDate(tmpDate))
		GetLastDateInReqMonth	= CDate(DateAdd("d",-1, tmpdate))
		
	End function
	
	
	' 날짜형식 변환 (2004-11-01 -> 2004년 11월 1일)
	public Function CalandarDay()
				
				If IsDate(mDate) Then
					CalandarDay = year(mDate) & "년 " & month(mDate) & "월 " & day(mDate) & "일"
					
				else
					CalandarDay = ""
				end If
			
    End Function
    
    
    ' 주어진 날짜와 사이 일수 이다. 
	public Function GetDateDiff( pDate)
				
			GetDateDiff = DateDiff( "d", mDate, pDate ) 
			
    End Function
    
End class

Dim dfDateUtil

Set dfDateUtil = new DateUtil


'Response.Write "SetDate( 2001-1-1, -  ) :: "&dfDateUtil.SetDate( "2001-1-1", "-" ) & "<br>"
'Response.Write "SetDate( 20050228 ) :: "&dfDateUtil.SetDate( "20050228", "" ) & "<br>"
'Response.Write "SetNow() :: " & dfDateUtil.SetNow() & "<br>"
'Response.Write "GetWeekDayName(  ) :: " & dfDateUtil.GetWeekDayName() & "<br>"
'Response.Write "SetAddDay( -1 ) :: " & dfDateUtil.SetAddDay( -1) & "<br>"
'Response.Write "SetAddWeek( -1 ) :: " & dfDateUtil.SetAddWeek( -1) & "<br>"
'Response.Write "SetAddMonth(-1 ) :: " & dfDateUtil.SetAddMonth( -1) & "<br>"
'Response.Write "SetAddYear( -1) :: " & dfDateUtil.SetAddYear( -1) & "<br>"
'Response.Write "GetFirstDateInMonth() :: "& dfDateUtil.GetFirstDateInMonth() & "<br>"
'Response.Write "GetLastDateInMonth() :: "& dfDateUtil.GetLastDateInMonth() & "<br>"
'Response.Write "GetDate() :: "&dfDateUtil & "<br>"
'Response.Write "GetDateDiff() :: "&dfDateUtil.GetDateDiff( "2003-04-01") & "<br>"


%>

