<style>
.navbtnStyle{
    text-shadow: 0px 1px 1px #fff;
    background-image: -webkit-linear-gradient(top,#e0e0e0 0,#fff 100%);
    background-image: -webkit-linear-gradient(top,#e0e0e0 0, #fff 100%);
    background-image: -o-linear-gradient(top,#e0e0e0 0,#fff 100%);
    background-image: -webkit-gradient(linear,left top,left bottom,from(#e0e0e0),to(#fff));
    background-image: linear-gradient(to bottom,#e0e0e0 0,#fff 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffe0e0e0', endColorstr='#ffffffff', GradientType=0);
    filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
    background-repeat: repeat-x;
	padding:3px 6px 3px 6px !important;
	border:1px solid #669 !important;
	color:#669;
}
.navbtnStyle:hover{
    text-shadow: 0px 1px 1px #fff;
    background-image: -webkit-linear-gradient(top,#fff 0,#e0e0e0 100%);
    background-image: -webkit-linear-gradient(top,#fff 0, #e0e0e0 100%);
    background-image: -o-linear-gradient(top,#fff 0,#e0e0e0 100%);
    background-image: -webkit-gradient(linear,left top,left bottom,from(#fff),to(#e0e0e0));
    background-image: linear-gradient(to bottom,#fff 0,#e0e0e0 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffffff', endColorstr='#ffe0e0e0', GradientType=0);
    filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
    background-repeat: repeat-x;
	padding:3px 6px 3px 6px !important;
	border:1px solid #669 !important;
}
.paging_crnt{
	padding:3px 6px 3px 6px !important;
	border:1px solid #669 !important;
	font-size:11px !important;
}
.paging_crnt:hover{
	padding:3px 6px 3px 6px !important;
	border:1px solid #669 !important;
	font-size:11px !important;
}
</style>
<%
	Public Const ButtonType_Text = 1			' type of navigate button is text
	Public Const ButtonType_Image = 2			' type of navigate button is image

	Class Pager
		Public CurrentPageIndex					' current page index
		Public PageIndexVariableName			' variable name on query string which indicates current page index
		Public PageSize							' size of page
		Public RecordCount						' total record count
		Public PageCount						' total page count
		Public TargetUrl						' navigate url
		Public QueryString						' a string variable that contains query string
		Public ButtonType
		Public FirstButtonText
		Public PrevButtonText
		Public NextButtonText
		Public LastButtonText
		Public NumericButtonDelimiter
		Public NumericButtonFormatString
		Public HideOnSingleView
		Public ZeroPrefixOnSingleDigit
		Public NumericButtonCssClass
		Public SelectedNumericButtonCssClass
		Public LastNavigateButtonCssClass
		Public NavigateButtonCssClass
		Public PageButtonCount
		Public NavigationButtonDelimiter
		Public NavigationShortCut               'Shortcut page selector View
		Public NavigationShortCutString
		Public ViewPageCount
		

		Private Sub Class_Initialize()
			PageIndexVariableName = "page"
			CurrentPageIndex = 0
			PageSize = 10
			RecordCount = 0
			PageCount = 0
			TargetUrl = Request.ServerVariables("SCRIPT_NAME")
			QueryString = ""
			ButtonType = ButtonType_Text
			FirstButtonText = "ó��"
			PrevButtonText = "����"
			NextButtonText = "����"
			LastButtonText = "������"
			NumericButtonDelimiter = "&nbsp;"
			NumericButtonFormatString = "{0}"
			HideOnSingleView = False
			ZeroPrefixOnSingleDigit = False
			PageButtonCount = 10
			NavigationButtonDelimiter = "&nbsp;"
			SelectedNumericButtonCssClass = "highlight"
			NavigationShortCut = False
			NavigationShortCutString = ""
		End Sub

		Private Sub Class_Terminate()
		End Sub
		
		Public Function CalculatePageCount
			PageCount = (RecordCount \ PageSize)
			
			If RecordCount Mod PageSize > 0 Then PageCount = PageCount + 1 
			CalculatePageCount = PageCount
		End Function

		Public Sub Render
			Dim sPagerHtml
			Dim nMinPageIndex, nMaxPageIndex, nLastPageIndex
			Dim sUrl, sUrls(4), sButtons(4)
			
			If CurrentPageIndex < 1 Then Err.Raise -1, "Pager.asp", "Invalid page index."
			If PageSize <= 0 Then Err.Raise -2, "Pager.asp", "Invalid page size."
			If (ButtonType < ButtonType_Text) Or (ButtonType > ButtonType_Image) Then ButtonType = ButtonType_Text
			If Len(FirstButtonText) = 0 Then FirstButtonText = "ó��"
			If Len(PrevButtonText) = 0 Then PrevButtonText = "����"
			If Len(NextButtonText) = 0 Then NextButtonText = "����"
			If Len(LastButtonText) = 0 Then LastButtonText = "������"
			If Len(NumericButtonDelimiter) = 0 Then NumericButtonDelimiter = "&nbsp;"
			If Len(NavigationButtonDelimiter) = 0 Then NavigationButtonDelimiter = "&nbsp;"
			If Len(NumericButtonFormatString) = 0 Then NumericButtonFormatString = "{0}"
			If Len(TargetUrl) = 0 Then TargetUrl = Request.ServerVariables("SCRIPT_NAME")
			IF Len(LastNavigateButtonCssClass) = 0 Then  LastNavigateButtonCssClass = NavigateButtonCssClass
			
			
			Call CalculatePageCount
			
			If PageCount = 0 Then 
				nLastPageIndex = 1
			Else
				nLastPageIndex = PageCount
			End If
			
			ViewPageCount = nLastPageIndex

			If nLastPageIndex = 1 And HideOnSingleView Then Exit Sub
			nMinPageIndex = (((CurrentPageIndex - 1) \ PageButtonCount) * PageButtonCount) + 1
			nMaxPageIndex = nMinPageIndex + (PageButtonCount - 1)
			If nMaxPageIndex > nLastPageIndex Then nMaxPageIndex = nLastPageIndex

			sUrl = TargetUrl
			Dim key
			If Len(QueryString) <= 0 Then
				For Each key In Request.QueryString
					
					If key <> PageIndexVariableName Then
						If Len(QueryString) > 0 Then QueryString = QueryString & "&"
						QueryString = QueryString & key & "=" & Request.QueryString(key)
					End If
				Next
			End If
			
			If Len(QueryString) > 0 Then
				Dim qsArray, bPageParamExists
				bPageParamExists = False
				qsArray = Split(QueryString, "&")
				
				sUrl = sUrl & "?"
				For i = 0 To UBound(qsArray)
					If i > 0 Then sUrl = sUrl & "&"
					Dim itemArray
					itemArray = Split(qsArray(i), "=")
					
					If UBound(itemArray) > -1 Then					
						If itemArray(0) = PageIndexVariableName Then
							bPageParamExists = True
							sUrl = sUrl & itemArray(0) & "={0}"
						Else
							sUrl = sUrl & itemArray(0) & "=" & itemArray(1)
						End If
					End If
				Next
				
				If Not bPageParamExists Then
					surl = sUrl & "&" & PageIndexVariableName & "={0}"
				End If
			Else
				sUrl = sUrl & "?" & PageIndexVariableName & "={0}"
			End If
			
			If nMinPageIndex <= 1 Then
				'sUrls(0) = "javascript:;"
				sUrls(0) = Replace(sUrl, "{0}", 1)
			Else
				sUrls(0) = Replace(sUrl, "{0}", 1)
			End If

			If nMinPageIndex <= PageButtonCount Then
				sUrls(1) = "javascript:;"
			Else
				sUrls(1) = Replace(sUrl, "{0}", nMinPageIndex - (PageButtonCount))
			End If

			If nMaxPageIndex >= nLastPageIndex Then
				sUrls(2) = "javascript:;"
				'sUrls(3) = "javascript:;"
				sUrls(3) = Replace(sUrl, "{0}", nLastPageIndex)
			Else
				sUrls(2) = Replace(sUrl, "{0}", nMaxPageIndex + 1)
				sUrls(3) = Replace(sUrl, "{0}", nLastPageIndex)
			End If

			If ButtonType = ButtonType_Image Then
				sButtons(0) = "<img src=""" & FirstButtonText & """ border=""0"" align=""absmiddle"">"
				sButtons(1) = "<img src=""" & PrevButtonText & """ border=""0"" align=""absmiddle"">"
				sButtons(2) = "<img src=""" & NextButtonText & """ border=""0"" align=""absmiddle"">"
				sButtons(3) = "<img src=""" & LastButtonText & """ border=""0"" align=""absmiddle"">"
			Else
				sButtons(0) = FirstButtonText
				sButtons(1) = PrevButtonText
				sButtons(2) = NextButtonText
				sButtons(3) = LastButtonText
			End If

            If NavigationShortCut Then
                NavigationShortCutString = "<span class=""" & NavigateButtonCssClass & """>Page&nbsp;<span style=""border:1px solid #DADADA;padding:0 2 0 4px""><span class=""" & NavigateButtonCssClass & """>" & CurrentPageIndex & " <img src=""" & NM_IMAGE_URL & "/img/portal/c000101_common/portal/icon_arrow2.gif"" align=""absmiddle"" style=""margin:2 0 0 0px"" border=""0px"" style=""cursor:pointer;"" onclick=""alert('aaa');""></span></span>&nbsp;of&nbsp;" & PageCount & "</span>&nbsp;&nbsp;"
            End If

			sPagerHtml = sPagerHtml & NavigationShortCutString
			sPagerHtml = sPagerHtml & "<nav><ul class=""pagination pagination-sm""><li><a  href=""" & sUrls(0) & """>" & sButtons(0) & "</a></li>"
'			sPagerHtml = sPagerHtml & "<div class=""bordersored"" style=""text-align:center;""><div class=""btn-toolbar bordersored"" role=""toolbar"" aria-label=""...""><div class=""btn-group"" role=""group"" aria-label=""...""><a class=""btn navbtnStyle " & NavigateButtonCssClass & """ href=""" & sUrls(0) & """>" & sButtons(0) & "</a>"
'			sPagerHtml = sPagerHtml & NavigationButtonDelimiter
			sPagerHtml = sPagerHtml & "<li><a  href=""" & sUrls(1) & """  >" & sButtons(1) & "</a></li>"
'			sPagerHtml = sPagerHtml & "<a class=""btn navbtnStyle " & NavigateButtonCssClass & """ href=""" & sUrls(1) & """  >" & sButtons(1) & "</a>"
'			sPagerHtml = sPagerHtml & NavigationButtonDelimiter


			For i = nMinPageIndex To nMaxPageIndex
				Dim pageCaption

				If Len(pageCaption) = 1 And ZeroPrefixOnSingleDigit Then pageCaption = "0" & pageCaption
				If CInt(i) = CInt(CurrentPageIndex) Then
					sPagerHtml = sPagerHtml & "<li class=""active""><a href=""#""> &nbsp;" & i & "&nbsp;</a></li>"	
				Else 
					sPagerHtml = sPagerHtml & "<li><a   href=""" & Replace(sUrl, "{0}", i) & """>&nbsp;"
					sPagerHtml = sPagerHtml & Replace(NumericButtonFormatString, "{0}", i) & "&nbsp;</a></li>"
				End If
				
				If i < nMaxPageIndex Then
					'sPagerHtml = sPagerHtml & Trim(NumericButtonDelimiter)
				Else
'					sPagerHtml = sPagerHtml & NavigationButtonDelimiter
				End If
			Next

			sPagerHtml = sPagerHtml & "<li><a   href=""" & sUrls(2) & """>" & sButtons(2) & "</a></li>"
'			sPagerHtml = sPagerHtml & NavigationButtonDelimiter  
			sPagerHtml = sPagerHtml & "<li><a  href=""" & sUrls(3) & """>" & sButtons(3) & "</a></li></ul></nav>"
            If NavigationShortCut Then
			    sPagerHtml = sPagerHtml & "<div id=""jump"" style=""position:absolute; left:84px; top:510px; z-index:1; visibility: hidden; width: 76px;"">"
			    sPagerHtml = sPagerHtml & "<table width=""77"" height=""26"" border=""0"" cellpadding=""0"" cellspacing=""0"" background=""" & NM_IMAGE_URL & "/img/portal/c000101_common/portal/jump_bg.gif"">"
			    sPagerHtml = sPagerHtml & "<tr><td style=""padding:0 0 0 5px""><input name=""jumpnum"" type=""text"" class=""paging_jump"" style=""width:30px"" value=""""><a href=""#""><img src=""" & NM_IMAGE_URL & "/img/portal/c000101_common/portal/jump_btn.gif"" width=""35"" height=""17"" border=""0"" align=""absmiddle"" style=""margin:0 0 0 3px""></a></td></tr>"
			    sPagerHtml = sPagerHtml & "</table></div>"
			End If
			
			Response.Write sPagerHtml
		End Sub
	End Class

%>