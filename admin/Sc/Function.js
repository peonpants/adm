// 영어,숫자만 가능
function EnNumCheck(word)
{
	  var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
	  for (i=0; i< word.length; i++)
	  {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++)
		{
		  if (idcheck == str.charAt(j)) break;
		  if (j+1 == str.length)
		  {
			return false;
		  }
		}
	  }
	  return true;
}

function NumCommaCheck(word)
{
	var str = ",1234567890";
	for (i=0; i< word.length; i++)
	  {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++)
		{
		  if (idcheck == str.charAt(j)) break;
		  if (j+1 == str.length)
		  {
			return false;
		  }
		}
	  }
	  return true;
}

function NumDash(word)
{
	var str = "-1234567890";
	for (i=0; i< word.length; i++)
	  {
		idcheck = word.charAt(i);
		for (j = 0 ;  j < str.length ; j++)
		{
		  if (idcheck == str.charAt(j)) break;
		  if (j+1 == str.length)
		  {
			return false;
		  }
		}
	  }
	  return true;
}

function NumCheck(word)
{
	var str = "1234567890";
	  for (i=0; i< word.length; i++) {
			idcheck = word.charAt(i);
			for (j = 0 ;  j < str.length ; j++)
			{
		  	if (idcheck == str.charAt(j)) break;
		  	if (j+1 == str.length)
		  	{
					return false;
		  	}
			}
	  }
	  return true;
}


//	전화번호 체크[숫자로만 구성되고 3 ~ 4개의 길이를 가져야 함]
function IsPhoneChek(strNumber)
{
	var regExpr = /^[0-9]{3,4}$/;
	
	if ( regExpr.test( strNumber ) )
		return true;
	else
		return false;
}


function keyCheck(){
  if(event.keyCode < 48 || event.keyCode > 57)// 0~9의 ASCII코드의 값 범위
  {
   alert("숫자만 사용할수 있습니다");
   event.returnValue= false ;//숫자가 아닌경우 입력이 안됨   
  }
}
