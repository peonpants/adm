<%

Class TCalendar

    Private FCurrDate, FMonthOffSet, FBlankDay, FWeekCaption, FStartWeek , i


    Public Property Let StartWeek(Value)
		    FStartWeek = Value
    End Property
    Public Property Get StartWeek()
	    StartWeek = FStartWeek
    End Property

    Public Property Let CurrDate(Value)
    if isDate(Value) then
	    FCurrDate = Value
    end if
    End Property
    
    Public Property Get CurrDate()
	    Currdate = FCurrDate
    End Property

    Public Property Let BlankDay(Value)
	    FBlankDay = Value
    End Property
    Public Property Get BlankDay()
	    BlankDay = FBlankDay
    End Property

    Private Function MonthOffSet(AYear, AMonth) 
    MonthOffSet = weekday(DateSerial(AYear, AMonth, 1), FStartWeek)-1 mod 7
    End Function


    Private Function isLeapYear(ByRef AYear)
	    isLeapYear = ((AYear mod 4 = 0) and (AYear mod 100 <> 0) or (AYear mod 400 = 0))
    end Function 


    Private Function DaysPerMonth(ByRef AYear, AMonth)
	    Dim DaysInMonth
	     DaysInMonth= array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
	     DaysPerMonth = DaysInMonth(AMonth-1)
	     if (AMonth = 2) and isLeapYear(AYear) then 
	 	    DaysPerMonth = DaysInMonth(AMonth-1) +1 
	     end if
    End Function 


    Private Function DayOfWeek(Value, index) 
        DayOfWeek= dateadd("d",index-Weekday(Value), Value)
    End Function


    Private Function WeekDayOfMonth(ByRef AYear, AMonth)
            Dim FirstDayMonth
            FirstDayMonth = DateSerial(AYear, AMonth, 1)
            WeekDayOfMonth = dateadd("d",1-Weekday(FirstDayMonth), FirstDayMonth)
    End Function 

    Private Function ChangeMonth(ByRef Delta)
	    ChangeMonth = dateAdd("m", Delta, FCurrDate)
    End Function 

    Private Function isCurrent(ByRef Value)
     isCurrent = dateDiff("d", CurrDate, Value)
    end Function

    Private Function WriteBlankDay(ByRef startIdx, endIdx)
        for i=startIdx to endIdx
	        WriteBlankDay = WriteBlankDay & "<td>" & BlankDay & "</td>"
        next
    End Function


    Public Function CreateCalendar()
        Dim CurrYear, CurrMonth, CurrDay
        CurrYear = Year(CurrDate)
        CurrMonth = Month(CurrDate)
        CurrDay = Day(CurrDate)

        response.write "<table cellspacing=0 cellpadding=0 calss='CalTable' id='CalTable'>"

        response.write "<tr>" 
        for i=1 to 7
	        response.write "<td class='CalTitle'>"& WeekDayName(i,True, FStartWeek)  &"</td>"
        next 
        response.write "</tr>"



        response.write "<tr>" 
        for i=1 to MonthOffSet(CurrYear, CurrMonth)
	        response.write "<td class='CalBlank' id=CalBlank" & i & ">" & BlankDay & "</td>"
        next
        Dim tmpRed
        for i=1 to DaysPerMonth(CurrYear, CurrMonth) 
        	
	        if weekDay(dateSerial(CurrYear, CurrMonth, i)) = FstartWeek	  then 
	        tmpRed=  "style='background-color:Red;'" 
	        else
	        tmpRed = ""
	        end if
        	
	        response.write "<td class='CalDay' id='" & dateSerial(CurrYear, CurrMonth, i) & "' " &tmpRed &">" & i & "</td>" &vbCr
	        if  (MonthOffSet(CurrYear, CurrMonth) + i) mod 7 = 0  and  i < DaysPerMonth(CurrYear, CurrMonth) then 
		        response.write "</tr><tr>"
	        end if
        Next

        for i=1 to (7-MonthOffSet(CurrYear, CurrMonth+1)) mod 7 
	        response.write "<td class='CalBlank' id=CalBlank" & i & ">" & BlankDay & "</td>"
        next
        response.write "</tr>"

        response.write "<tr Class='MoveButton' ><td class='coolButton' date='" & ChangeYear(-1) & "'>&lt;&lt;</td>"
        response.write "<td class='coolButton' date='" & ChangeMonth(-1) & "'>&lt;</td>"
        response.write "<td colspan=3 date='" & CurrDate & "'>" & currDate & "</td>"
        response.write "<td class='coolButton' date='" & ChangeMonth(1) & "'>&gt;</td>"
        response.write "<td id='coolButton' class='coolButton' date='" & ChangeYear(1) & "'>&gt;&gt;</td>"
        response.write "</tr>"

        response.write "</table>"
    End Function

    Private Function ChangeYear(ByRef Delta)
        ChangeYear = dateAdd("yyyy", Delta, FCurrDate)
    end Function 

    Private Sub Class_Initialize()
        BlankDay = "&nbsp;"
        FStartWeek = vbSunday
        FCurrDate = date()
    End Sub
    
end Class



%>
