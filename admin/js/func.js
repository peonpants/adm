function chkNum(checkStr) {
    if(checkStr == "") return false;
	for(i = 0;i < checkStr.length;i++) {
		ch = checkStr.charAt(i);
		if(!(ch >= "0" && ch <= "9"))
			return false;
	}
	return true;
}

// 영문인지를 체크..
function chkEng(checkStr) {
	var str_space = /s/;

    if(checkStr == "") return false;
	for(i = 0;i < checkStr.length;i++) {
		ch = checkStr.charAt(i);
		if(!((ch >= "A" && ch <= "Z") || (ch >= "a" && ch <= "z") || ch == "." || ch == "," || ch == ' '))
			return false;
		
	}
	return true;
}


// 숫자와 영문인지를 체크..
function chkNumEng(checkStr) {
    if(checkStr == "") return false;
	for(i = 0;i < checkStr.length;i++) {
		ch = checkStr.charAt(i);
		if(!((ch >= "0" && ch <= "9") || (ch >= "A" && ch <= "Z") || (ch >= "a" && ch <= "z")))
			return false;
	}
	return true;
}

// 숫자와 컴마 체크..
function chkNumEngComma(checkStr) {
    if(checkStr == "") return false;
	for(i = 0;i < checkStr.length;i++) {
		ch = checkStr.charAt(i);
		if(!((ch >= "0" && ch <= "9") || ch == "."))
			return false;
	}
	return true;
}

// 아이디 체크
function chkIDStr(checkStr) {
    if(checkStr == "") return false;
	for(i = 0;i < checkStr.length;i++) {
		ch = checkStr.charAt(i);
		if(!((ch >= "0" && ch <= "9") || (ch >= "A" && ch <= "Z") || (ch >= "a" && ch <= "z") || ch == "-" || ch == "_" || ch == "."))
			return false;
	}
	return true;
}

// 영문 이름 체크
function chkNameENG(checkStr) {
    if(checkStr == "") return false;
	for(i = 0;i < checkStr.length;i++) {
		ch = checkStr.charAt(i);
		if(!
			(
				(ch >= "A" && ch <= "Z") || 
				(ch >= "a" && ch <= "z")
			)
		)
			return false;
	}
	return true;
}

function email_check(emailad) {
	var exclude=/[^@\-\.\w]|^[_@\.\-]|[\._\-]{2}|[@\.]{2}| [^@]*\1/;
	var check=/@[\w\-]+\./;
	var checkend=/\.[a-zA-Z]{2,3}$/;
	var parse_email = emailad.split("@");
	if ( emailad ) {
		if(((emailad.search(exclude) != -1)||(emailad.search(check)) == -1)||(emailad.search(checkend) == -1)){
   	    	   return false;
		} else {
			return true;
		}
	}
}

function newPopup(width, height, url, popName) {

	var width = width;
	var height = height;
	var topPosition = (screen.height - height) / 2;
	var leftPosition = (screen.width - width) / 2;
	
	window.open(url,popName,'top='+topPosition+', left='+leftPosition+', width='+width+', height='+height+', statusbar=no,scrollbars=auto,toolbar=no,resizable=no')
}

function newItemBoardPopup(){
	newPopup(317, 271, '/EToTo_Admin/member/new_item_board_popup.php', "newItemPopup");
}