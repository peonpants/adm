<!-- #include virtual="/_Global/DbCono.asp" -->
<!-- #include virtual="/_Global/AdminChk.asp" --->
<!-- #include virtual='/_Global/amount.asp' -->
<%
a = "010-1435-2453"
a = Replace(a,"-","")
'a = "01093364866"
'a = "01094875530"
'a = "01046003779"
'a = "01012341234"
'a = "01086059423"
'a = "01029580258"
'a = "01025313590"
'a = "01065214578"
'a = "01088563376"
'a = "01034544689"
'a = "01190630343"
'a = "01011111111"
'a = "01085639556"
'a = "01093456677"
'a = "01080052757"
'a = "0116149796"
'a = "01086059423"
'a = "01092667739"
'a = "01047541023"

a01 = ""
a02 = ""
a03 = ""
a04 = ""
a05 = ""
a06 = ""
a07 = ""
a08 = ""
a09 = ""
a10 = ""
a11 = ""
a12 = ""

a01 = Mid(a,4,1)
a02 = Mid(a,8,1)
a03 = Mid(a,2,1)
a04 = Mid(a,7,1)
a05 = Mid(a,3,1)
a06 = Mid(a,5,1)
a07 = Mid(a,9,1)
a08 = Mid(a,1,1)
a09 = Mid(a,10,1)
a10 = Mid(a,6,1)
a11 = Mid(a,11,1)

a = encode(a01 & a02 & a03 & a04 & a05 & a06 & a07 & a08 & a09 & a10 & a11,3)

response.write a & "<br>"

a = decode("2M2J2U2E2L2E2L2L222N24",3)
'a = "2N222U2U2M2J2E2L2E22"

					ea01 = Mid(a,1,1)
					ea02 = Mid(a,2,1)
					ea03 = Mid(a,3,1)
					ea04 = Mid(a,4,1)
					ea05 = Mid(a,5,1)
					ea06 = Mid(a,6,1)
					ea07 = Mid(a,7,1)
					ea08 = Mid(a,8,1)
					ea09 = Mid(a,9,1)
					ea10 = Mid(a,10,1)
					ea11 = Mid(a,11,1)

					ea = ea08 & ea03 & ea05 & ea01 & ea06 & ea10 & ea04 & ea02 & ea07 & ea09 & ea11 

response.write ea
%>