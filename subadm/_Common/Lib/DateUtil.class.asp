<%
'
' DateUtil.class.asp ��¥ ���� �Լ� ����  Ŭ����
' �⺻ ��¥���� YYYY-MM-DD�������� ��ȯ �ȴ�. 
'
' Date : 2005.3.2 by offman 
'



Class	DateUtil

   public mDate  ' ��¥ CDate Type���� ���� 

   
   ' CDate Type�� ��¥�� Default �� ����Ѵ�.   
   Public Default Property Get GetDate ()
   
   	GetDate = mDate 
   	
   End Property 
   
   ' �ش� �⵵�� ������ �´�.
   
   Public Property Get GetYear ()
   
   	GetYear = Year( mDate ) 
   	
   End Property 

    
   ' �ش� ���� ������ �´�.
   Public Property Get GetMonth ()
   
   	GetMonth = Month( mDate ) 
   	
   End Property 
  
   ' �ش� ���� ������ �´�.
    Public Property Get GetDay ()
   
   	GetDay = Month( mDate ) 
   	
   End Property 
  
    
	' ���� �ð��� �����Ѵ�. 
	Public Function SetNow ( )
		
		mDate  = CDate(Date)
		
		SetNow = mDate
		
	End Function
	
	' ���� �Լ�,  ������ ��¥�� �����Ѵ�. 
	Private Function SetMDate( pDate )
	
		mDate =  CDate( pDate )
		
		SetMDate = mDate
		
	End Function 
	
	
	' ������ ��¥�� �����Ѵ�. 
	Public Function SetDate( pDate, pToken )
		
		If IsNull(pToken) or Len(pToken ) = 0 Then
		
			SetDate = SetDate1(pDate) 
			
		Else 
			SetDate = SetDate2(pDate, pToken )
		End If
		
	End Function
	
	
	' ������ ��¥�� �����Ѵ�. 
	Public Function SetDate1( pDate )
		
		Dim fYear, fMonth, fDay
		fYear = mid(pDate,1,4)
		fMonth = mid(pDate,5,2)
		fDay = mid(pDate,7,2)
		
		SetMDate( fYear &"-"& fMonth &"-"& fDay )
		
		SetDate1 = mDate
		
	End Function
	
	
	' ������ ��¥�� �����Ѵ�. 
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
	
	' �ش� ������ ������ �´�. ( 0 - �Ͽ���, 1 - ������ ... ) 
	
	Public Function GetWeekDay(  ) 
	
		GetWeekDay = WeekDay( mDate ) 
	
	End Function	
	
	' �ش� ������ ������ �´�. ( ��,ȭ,��,��,��,��) 
	
	
	Public Function GetWeekDayName( ) 
	
		Dim CWeekName( 7 ) 
		CWeekName(1) =  "��"
		CWeekName(2) =  "��"
		CWeekName(3) =  "ȭ"
		CWeekName(4) =  "��"
		CWeekName(5) =  "��"
		CWeekName(6) =  "��"
		CWeekName(7) =  "��"
		
		GetWeekDayName = CWeekName(WeekDay( mDate ))	
		
	End Function	
	
	' �ϴ����� ��¥�� �̵��Ѵ�. 
	
	Public function SetAddDay( pDays )
			
			SetAddDay = SetMDate( DateAdd("d", pDays, mDate) )
			
	End Function
	
	' �ִ����� ��¥�� �̵��Ѵ�. 
	
	Public function SetAddWeek( pWeeks )
			
			SetAddWeek = SetMDate( DateAdd("ww", pWeeks, mDate) )
			
	End Function
	
	' �������� ��¥�� �̵��Ѵ�. 
	
	Public function SetAddMonth( pMonths )
			
			SetAddMonth = SetMDate( DateAdd("m", pMonths, mDate) )
			
	End Function
	
	' ������� ���ڸ� �̵��Ѵ� 

	Public function SetAddYear( pYears )
			
			SetAddYear = SetMDate( DateAdd("yyyy", pYears, mDate) )
			
	End Function
	
	' Return : �ش���� ù°��
	Public function GetFirstDateInMonth()
		Dim tmpDate 
		GetFirstDateInMonth = CDate(GetYear   & "-" & GetMonth & "-01")
	End function
	
	
	
	' Return : �ش���� ��������
	Public function GetLastDateInMonth()
		
		Dim tmpDate 
		tmpDate		= GetYear   & "-" & GetMonth & "-01"
		tmpDate		= DateAdd("m", 1, CDate(tmpDate))
		GetLastDateInMonth		= CDate(DateAdd("d",-1, tmpdate))
	End function
	
	
	' Return : Ư������ ��������
	Public function GetLastDateInReqMonth( pYears, pMonths )
		
		Dim tmpDate 
		tmpDate		= pYears & "-" & pMonths & "-01"
		tmpDate		= DateAdd("m", 1, CDate(tmpDate))
		GetLastDateInReqMonth	= CDate(DateAdd("d",-1, tmpdate))
		
	End function
	
	
	' ��¥���� ��ȯ (2004-11-01 -> 2004�� 11�� 1��)
	public Function CalandarDay()
				
				If IsDate(mDate) Then
					CalandarDay = year(mDate) & "�� " & month(mDate) & "�� " & day(mDate) & "��"
					
				else
					CalandarDay = ""
				end If
			
    End Function
    
    
    ' �־��� ��¥�� ���� �ϼ� �̴�. 
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

