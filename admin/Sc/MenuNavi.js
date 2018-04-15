function goHome() {
	top.location.href = "/";
}

function goLogout() {
	top.ProcFrm.location.href = "/Login/Logout_Proc.asp";
}

function goJoin() {
	top.MainFrm.location.href = "Join.asp";
}

function goMyInfo() {
	top.MainFrm.location.href = "MyInfo.asp";
}

function goCharge() {
	top.MainFrm.location.href = "Charge.asp";
}

function goExchange() {
	top.MainFrm.location.href = "Exchange.asp";	
}

function goMyBet() {
	top.MainFrm.location.href = "MyBet.asp";		
}

function goUserAgreement() {
	top.MainFrm.location.href="/UserAgreement.asp";
}

// Sports로 가기...(오늘의 게임...기본 승무패...)
function goSports(rs,rl) {
	top.MainFrm.location.href="/Sports.asp?Sel_Sports="+rs+"&Sel_League="+rl;
}

function goSportsHandicap(rs,rl) {
	top.MainFrm.location.href="/Sports.asp?Game_Type=Handicap&Sel_Sports="+rs+"&Sel_League="+rl;	
}

function goSMP() {
	top.MainFrm.location.href="/Sports.asp?Game_Type=SMP" ;
}

function goHandicap() {
	top.MainFrm.location.href="/Sports.asp?Game_Type=Handicap" ;
}

function goGameResult() {
	top.MainFrm.location.href = "GameResult.asp";
}

function goBetRule() {
	top.MainFrm.location.href = "BetRule.asp";
}

function goDescHandicap() {
	top.MainFrm.location.href = "Handicap.asp";
}

function goBoard(pf) {
	if ((pf == "board") || (pf == "")) top.MainFrm.location.href="/Board.asp";
	else if (pf == "notice") top.MainFrm.location.href="/Notice.asp";
	else if (pf == "event") top.MainFrm.location.href="/Event.asp";
	else if (pf == "analysis") top.MainFrm.location.href="/Analysis.asp";
}

function goCustomer() {
	top.MainFrm.location.href = "Customer.asp?Flag=write";
}




