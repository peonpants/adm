<%
	'*******************************************************************************************************************
	'파일명	: ASocket.inc
	'각 에러에 대한 상수 정의 파일
	'
	'											- Made by Gabia Inc. Hosting Business Dept/Engineer Team Assistant Manager taesachi
	'*******************************************************************************************************************

'************************************************************************************************************************
'															[ Socket Error 상수 정의 ]
'************************************************************************************************************************
	' Connection states

	Const asPROTOCOL_RAW						= 1   
	Const asPROTOCOL_TELNET	          		= 2 


	' Connection states

	Const asCONN_DISCONNECTED				= 1   
	Const asCONN_LISTENING						= 2 
	Const asCONN_CONNECTED					= 3


	' Error codes 

	Const asERR_WSASUCCESS						= 0
	Const asERR_WSAINVALIDPARAMETER		= 1
	Const asERR_WSACREATETHREADFAILED	= 2
	Const asERR_WSAEVALUATIONEXPIRED		= 3
	Const asERR_WSAINVALIDLICENSE				= 4
	Const asERR_BUFFEROVERFLOW				= 5
	Const asERR_NOBYTESINBUFFER				= 6

	Const asERR_WSAEINTR								= 10004
	Const asERR_WSAEBADF							= 10009
	Const asERR_WSAEACCES							= 10013
	Const asERR_WSAEFAULT							= 10014
	Const asERR_WSAEINVAL							= 10022
	Const asERR_WSAEMFILE							= 10024
	Const asERR_WSAEWOULDBLOCK				= 10035
	Const asERR_WSAEINPROGRESS				= 10036
	Const asERR_WSAEALREADY						= 10037
	Const asERR_WSAENOTSOCK						= 10038
	Const asERR_WSAEDESTADDRREQ				= 10039
	Const asERR_WSAEMSGSIZE						= 10040
	Const asERR_WSAEPROTOTYPE					= 10041
	Const asERR_WSAENOPROTOOPT				= 10042
	Const asERR_WSAEPROTONOSUPPORT      = 10043
	Const asERR_WSAESOCKTNOSUPPORT      = 10044
	Const asERR_WSAEOPNOTSUPP					= 10045
	Const asERR_WSAEPFNOSUPPORT				= 10046
	Const asERR_WSAEAFNOSUPPORT				= 10047
	Const asERR_WSAEADDRINUSE					= 10048
	Const asERR_WSAEADDRNOTAVAIL				= 10049
	Const asERR_WSAENETDOWN					= 10050
	Const asERR_WSAENETUNREACH				= 10051
	Const asERR_WSAENETRESET					= 10052
	Const asERR_WSAECONNABORTED			= 10053
	Const asERR_WSAECONNRESET					= 10054
	Const asERR_WSAENOBUFS						= 10055
	Const asERR_WSAEISCONN						= 10056
	Const asERR_WSAENOTCONN					= 10057
	Const asERR_WSAESHUTDOWN					= 10058
	Const asERR_WSAETOOMANYREFS			= 10059
	Const asERR_WSAETIMEDOUT					= 10060
	Const asERR_WSAECONNREFUSED				= 10061
	Const asERR_WSAELOOP							= 10062
	Const asERR_WSAENAMETOOLONG			= 10063
	Const asERR_WSAEHOSTDOWN					= 10064
	Const asERR_WSAEHOSTUNREACH				= 10065
	Const asERR_WSAENOTEMPTY					= 10066
	Const asERR_WSAEPROCLIM						= 10067
	Const asERR_WSAEUSERS							= 10068
	Const asERR_WSAEDQUOT							= 10069
	Const asERR_WSAESTALE							= 10070
	Const asERR_WSAEREMOTE						= 10071
	Const asERR_WSASYSNOTREADY				= 10091
	Const asERR_WSAVERNOTSUPPORTED		= 10092
	Const asERR_WSANOTINITIALISED				= 10093
	Const asERR_WSAEDISCON						= 10101
	Const asERR_WSAENOMORE						= 10102
	Const asERR_WSAECANCELLED					= 10103
	Const asERR_WSAEINVALIDPROCTABLE		= 10104
	Const asERR_WSAEINVALIDPROVIDER			= 10105
	Const asERR_WSAEPROVIDERFAILEDINIT		= 10106
	Const asERR_WSASYSCALLFAILURE			= 10107
	Const asERR_WSASERVICE_NOT_FOUND		= 10108
	Const asERR_WSATYPE_NOT_FOUND			= 10109
	Const asERR_WSA_E_NO_MORE					= 10110
	Const asERR_WSA_E_CANCELLED				= 10111
	Const asERR_WSAEREFUSED						= 10112
	Const asERR_WSAHOST_NOT_FOUND			= 11001
	Const asERR_WSATRY_AGAIN						= 11002
	Const asERR_WSANO_RECOVERY				= 11003
	Const asERR_WSANO_DATA						= 11004
	Const asERR_WSA_QOS_RECEIVERS			= 11005
	Const asERR_WSA_QOS_SENDERS				= 11006
	Const asERR_WSA_QOS_NO_SENDERS		= 11007
	Const asERR_WSA_QOS_NO_RECEIVERS		= 11008
	Const asERR_WSA_QOS_REQUEST_CONFIRMED = 11009
	Const asERR_WSA_QOS_ADMISSION_FAILURE = 11010
	Const asERR_WSA_QOS_POLICY_FAILURE	= 11011
	Const asERR_WSA_QOS_BAD_STYLE			= 11012
	Const asERR_WSA_QOS_BAD_OBJECT			= 11013
	Const asERR_WSA_QOS_TRAFFIC_CTRL_ERROR= 11014
	Const asERR_WSA_QOS_GENERIC_ERROR	= 11015
	Const asERR_WSA_QOS_ESERVICETYPE		= 11016
	Const asERR_WSA_QOS_EFLOWSPEC			= 11017
	Const asERR_WSA_QOS_EPROVSPECBUF	= 11018
	Const asERR_WSA_QOS_EFILTERSTYLE		= 11019
	Const asERR_WSA_QOS_EFILTERTYPE		= 11020
	Const asERR_WSA_QOS_EFILTERCOUNT		= 11021
	Const asERR_WSA_QOS_EOBJLENGTH		= 11022
	Const asERR_WSA_QOS_EFLOWCOUNT		= 11023
	Const asERR_WSA_QOS_EUNKNOWNPSOBJ     = 11024
	Const asERR_WSA_QOS_EPOLICYOBJ			= 11025
	Const asERR_WSA_QOS_EFLOWDESC			= 11026
	Const asERR_WSA_QOS_EPSFLOWSPEC		= 11027
	Const asERR_WSA_QOS_EPSFILTERSPEC	= 11028
	Const asERR_WSA_QOS_ESDMODEOBJ		= 11029
	Const asERR_WSA_QOS_ESHAPERATEOBJ	= 11030
	Const asERR_WSA_QOS_RESERVED_PETYPE   = 11031


'************************************************************************************************************************
'															[ SMS Error 상수 정의 ]
'************************************************************************************************************************

	Const SMS_RETURN_SUCCESS				= "0"
	Const SMS_FAULT_DATA						= "-1"
	Const SMS_TIMEOUT								= "100"
	Const SMS_HEAD_ERROR						= "200"
	Const SMS_LENGTH_ERROR					= "201"
	Const SMS_SEND_STATUS_ERROR			= "202"
	Const SMS_TIME_ERROR						= "203"
	Const SMS_LOGIN_ERROR						= "300"
	Const SMS_CANNOT_SEND					= "400"
	Const SMS_DB_INSERT_ERROR				= "500"
	Const SMS_SEND_COUNT_MINUS			= "501"
	Const SMS_CLIENT_IP_ERROR				= "600"
	Const SMS_ID_LENGTH_ERROR				= "701"
	Const SMS_PASS_LENGTH_ERROR			= "702"
	Const SMS_RECVTEL_LENGTH_ERROR	= "703"
	Const SMS_SENDTEL_LENGTH_ERROR	= "704"
	Const SMS_RESERVE_TIME_ERROR		= "705"
	Const SMS_SENDMSG_LENGTH_ERROR	= "706"
	Const SMS_SENDTOTAL_LENGTH_ERROR	= "707"
%>