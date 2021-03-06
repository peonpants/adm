<%
Const Ref = "D7EFGBCHL640MN598OIJKPQRSATWXVYZ123U"

' 암호화
Function encode(str,chipVal)
        Dim Temp, TempChar, Conv, Cipher, i : Temp = ""
        chipVal = CInt(chipVal)
        str = StringToHex(str)
        for i = 0 to len(str) - 1
                TempChar = Mid(str,i+1,1)
                Conv = InStr(Ref,TempChar)-1
                Cipher = Conv Xor chipVal
                Cipher = Mid(Ref,Cipher+1,1)
                Temp = Temp + Cipher
        next
        encode = Temp
End Function

' 복호화
Function decode(str,chipVal)
        Dim Temp, TempChar, Conv, Cipher, i : Temp = ""
        chipVal = CInt(chipVal)
        for i = 0 to len(str) - 1
                TempChar = Mid(str,i+1,1)
                Conv = InStr(Ref,TempChar)-1
                Cipher = Conv Xor chipVal
                Cipher = Mid(Ref,Cipher+1,1)
                Temp = Temp + Cipher
        next
        Temp = HexToString(Temp)
        decode = Temp
End Function

' 문자열 -> 16진수
Function StringToHex(pStr)
        dim i, one_hex, retVal
        for i = 1 to len(pStr)
                one_hex = hex(asc(mid(pStr,i,1)))
                retVal = retVal & one_hex
        next
        StringToHex = retVal
End Function

' 16진수 -> 문자열
Function HexToString(pHex)
        dim one_hex, tmp_hex, i, retVal
        for i = 1 to len(pHex)
                one_hex = mid(pHex,i,1)
                if IsNumeric(one_hex) then
                        tmp_hex = mid(pHex,i,2)
                        i = i + 1
                else
                        tmp_hex = mid(pHex,i,4)
                        i = i + 3
                end if
                retVal = retVal & chr("&H" & tmp_hex)        
        next
        HexToString = retVal
End Function



%>