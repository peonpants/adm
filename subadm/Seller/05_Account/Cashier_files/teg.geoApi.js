var TeG = TeG || {};

TeG.GeoApi = (function () {
    var that = this;

    var dataBase = '|247#AC#Ascension Island|376#AD#Andorra|971#AE#United Arab Emirates|93#AF#Afghanistan|1268#AG#Antigua and Barbuda|1264#AI#Anguilla|355#AL#Albania|374#AM#Armenia|599#AN#Netherlands Antilles|244#AO#Angola|672#AQ#Antarctica|54#AR#Argentina|1684#AS#American Samoa|43#AT#Austria|61#AU#Australia|297#AW#Aruba|358#AX#Aland Islands|994#AZ#Azerbaijan|387#BA#Bosnia and Herzegovina|1246#BB#Barbados|880#BD#Bangladesh|32#BE#Belgium|226#BF#Burkina Faso|359#BG#Bulgaria|973#BH#Bahrain|257#BI#Burundi|229#BJ#Benin|1441#BM#Bermuda|673#BN#Brunei Darussalam|591#BO#Bolivia|55#BR#Brazil|1242#BS#Bahamas|975#BT#Bhutan|267#BW#Botswana|375#BY#Belarus|501#BZ#Belize|1#CA#Canada|61#CC#Cocos (Keeling) Islands|243#CD#Congo, The Democratic Republic of the|236#CF#Central African Republic|242#CG#Congo|41#CH#Switzerland|225#CI#Cote d\'Ivoire|682#CK#Cook Islands|56#CL#Chile|237#CM#Cameroon|86#CN#China|57#CO#Colombia|506#CR#Costa Rica|53#CU#Cuba|238#CV#Cape Verde|61#CX#Christmas Island|357#CY#Cyprus|420#CZ#Czech Republic|49#DE#Germany|253#DJ#Djibouti|45#DK#Denmark|1767#DM#Dominica|1809#DO#Dominican Republic|1829#DO#Dominican Republic|213#DZ#Algeria|34#EA#Ceuta and Melilla|593#EC#Ecuador|372#EE#Estonia|20#EG#Egypt|212#EH#Western Sahara|291#ER#Eritrea|34#ES#Spain|251#ET#Ethiopia|388#EU#Europe|358#FI#Finland|679#FJ#Fiji|500#FK#Falkland Islands (Malvinas)|691#FM#Micronesia, Federated States of|298#FO#Faroe Islands|33#FR#France|241#GA#Gabon|44#GB#United Kingdom|1473#GD#Grenada|995#GE#Georgia|594#GF#French Guiana|44#GG#Guernsey|233#GH#Ghana|350#GI#Gibraltar|299#GL#Greenland|220#GM#Gambia|224#GN#Guinea|590#GP#Guadeloupe|240#GQ#Equatorial Guinea|30#GR#Greece|502#GT#Guatemala|1671#GU#Guam|245#GW#Guinea-Bissau|592#GY#Guyana|852#HK#Hong Kong|504#HN#Honduras|385#HR#Croatia|509#HT#Haiti|36#HU#Hungary|34#IC#Canary Islands|62#ID#Indonesia|353#IE#Ireland|972#IL#Israel|44#IM#Isle of Man|91#IN#India|246#IO#British Indian Ocean Territory|964#IQ#Iraq|98#IR#Iran, Islamic Republic of|354#IS#Iceland|39#IT#Italy|44#JE#Jersey|1876#JM#Jamaica|962#JO#Jordan|81#JP#Japan|254#KE#Kenya|996#KG#Kyrgyzstan|855#KH#Cambodia|686#KI#Kiribati|269#KM#Comoros|1869#KN#Saint Kitts and Nevis|850#KP#Korea, Democratic People\'s Republic of|82#KR#Korea, Republic of|965#KW#Kuwait|1345#KY#Cayman Islands|7#KZ#Kazakhstan|856#LA#Lao People\'s Democratic Republic|961#LB#Lebanon|1758#LC#Saint Lucia|423#LI#Liechtenstein|94#LK#Sri Lanka|231#LR#Liberia|266#LS#Lesotho|370#LT#Lithuania|352#LU#Luxembourg|371#LV#Latvia|218#LY#Libyan Arab Jamahiriya|212#MA#Morocco|377#MC#Monaco|373#MD#Moldova, Republic of|382#ME#Montenegro|261#MG#Madagascar|692#MH#Marshall Islands|389#MK#Macedonia|223#ML#Mali|95#MM#Myanmar|976#MN#Mongolia|853#MO#Macao|1670#MP#Northern Mariana Islands|596#MQ#Martinique|222#MR#Mauritania|1664#MS#Montserrat|356#MT#Malta|230#MU#Mauritius|960#MV#Maldives|265#MW#Malawi|52#MX#Mexico|60#MY#Malaysia|258#MZ#Mozambique|264#NA#Namibia|687#NC#New Caledonia|227#NE#Niger|672#NF#Norfolk Island|234#NG#Nigeria|505#NI#Nicaragua|31#NL#Netherlands|47#NO#Norway|977#NP#Nepal|674#NR#Nauru|683#NU#Niue|64#NZ#New Zealand|968#OM#Oman|507#PA#Panama|51#PE#Peru|689#PF#French Polynesia|675#PG#Papua New Guinea|63#PH#Philippines|92#PK#Pakistan|48#PL#Poland|508#PM#Saint Pierre and Miquelon|872#PN#Pitcairn|1787#PR#Puerto Rico|972#PS#Palestinian Territory|351#PT#Portugal|680#PW#Palau|595#PY#Paraguay|974#QA#Qatar|374#QN#Nagorno-Karabakh|994#QN#Nagorno-Karabakh|252#QS#Somaliland|90#QY#Turkish Republic of Northern Cyprus|262#RE#Reunion|40#RO#Romania|381#RS#Serbia|7#RU#Russian Federation|250#RW#Rwanda|966#SA#Saudi Arabia|677#SB#Solomon Islands|248#SC#Seychelles|249#SD#Sudan|46#SE#Sweden|65#SG#Singapore|290#SH#Saint Helena|386#SI#Slovenia|47#SJ#Svalbard and Jan Mayen|421#SK#Slovakia|232#SL#Sierra Leone|378#SM#San Marino|221#SN#Senegal|252#SO#Somalia|597#SR#Suriname|239#ST#Sao Tome and Principe|503#SV#El Salvador|963#SY#Syrian Arab Republic|268#SZ#Swaziland|290#TA#Tristan da Cunha|1649#TC#Turks and Caicos Islands|235#TD#Chad|228#TG#Togo|66#TH#Thailand|992#TJ#Tajikistan|690#TK#Tokelau|670#TL#Timor-Leste|993#TM#Turkmenistan|216#TN#Tunisia|676#TO#Tonga|90#TR#Turkey|1868#TT#Trinidad and Tobago|688#TV#Tuvalu|886#TW#Taiwan|255#TZ#Tanzania, United Republic of|380#UA#Ukraine|256#UG#Uganda|1#US#United States|598#UY#Uruguay|998#UZ#Uzbekistan|379#VA#Holy See (Vatican City State)|1784#VC#Saint Vincent and the Grenadines|58#VE#Venezuela|1284#VG#Virgin Islands, British|1340#VI#Virgin Islands, U.S.|84#VN#Vietnam|678#VU#Vanuatu|681#WF#Wallis and Futuna|685#WS#Samoa|991#XC#ITPCS|888#XD#OCHA|871#XE#Inmarsat (Atlantic East)|872#XF#Inmarsat (Pacific)|881#XG#Global Mobile Satellite System|873#XI#Inmarsat (Indian)|883#XL#International Networks|870#XN#Inmarsat SNAC service|878#XP#Universal Personal Telecommunications services|979#XR#International Premium Rate Service|808#XS#Shared Cost Services|800#XT#International Freephone|882#XV#International Networks|874#XW#Inmarsat (Atlantic West)|967#YE#Yemen|262#YT#Mayotte|27#ZA#South Africa|260#ZM#Zambia|263#ZW#Zimbabwe|';

    function getIsoCode() {
        if (typeof (geoip_country_code) == 'function') {
            return geoip_country_code();
        }
        
        return '';
    }

    return {
        getPhoneCode: function () {
            var iso = getIsoCode();

            if (iso.length == 0) {
                return '';
            }
            var getCountryInfoByCode = '\\|\\d+#' + iso + '#[^\\|]+\\|';
            var regExpIso = new RegExp(getCountryInfoByCode, "i");

            var countryInfo = dataBase.match(regExpIso);

            if (countryInfo == null) {
                return '';
            }

            var phoneCode = countryInfo[0].replace(/\|/g, '').split('#')[0];

            return phoneCode;
        },

        getIsoCode: function () {
            return getIsoCode();
        }
    };
});

var tegGeoApi = new TeG.GeoApi();
