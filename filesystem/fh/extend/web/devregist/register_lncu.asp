<!-- saved from url=(0022)http://internet.e-mail -->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�豸ע��</title>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" language="javascript">
var devRegisterSync = '<% devRegisterSync(); %>';

var setDeviceInfoSync = '<% setDeviceInfoSync(); %>';
var opt_powerSync = '<% opt_powerSync(); %>';
var check_self_sync = '<% check_self_sync(); %>';

var start = '0';
var bar;
var res;
var count = 0;
var result_flag = 0;
var result_count = 0;
//var request  = initXMLHttpClient();
var request = getRequest();
var progress;

var oltAuthRst = '<% getCfgGeneral(1, "olt_auth_rst"); %>';
var getACSIPRst;
var authStatus = '<% getCfgGeneral(1, "auth_status"); %>';
var authResult = '<% getCfgGeneral(1, "auth_result"); %>';
var authTimes = '<% getCfgGeneral(1, "auth_times"); %>';
var authLimit = '<% getCfgGeneral(1, "auth_limit"); %>';

var iNeedAcsAuthFlag;

var loId;
var loPwd;

function displayPortInfoImage()
{	 
	var lan_port_num = '<% getCfgGeneral(1, "lan_port_num"); %>';
	var voip_port_num = '<% getCfgGeneral(1, "voip_port_num"); %>';
	var status;
	var node;
	
	if(parseInt(lan_port_num) >= 1)
	{
		status = '<% getCfgGeneral(1, "lan1_state"); %>';;
		node = getElement("img_lan1");
		if(parseInt(status) == 0)
			node.src = "../images/lan1_up.png";
		else
			node.src = "../images/lan1_down.png";
	}
	if(parseInt(lan_port_num) >= 2)
	{
		status = '<% getCfgGeneral(1, "lan2_state"); %>';
		node = getElement("img_lan2");
		if(parseInt(status) == 0)
			node.src = "../images/lan2_up.png";
		else
			node.src = "../images/lan2_down.png";
	}
	if(parseInt(voip_port_num) >= 1)
	{
		status = '<% getCfgGeneral(1, "voip_regStatus_1"); %>';
		node = getElement("img_voip1");
		switch(parseInt(status))
		{
			case 0:
			case 1:
				node.src = "../images/voip1_down.png";
				break;
			case 2:
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
				node.src = "../images/voip1_up.png";
				break;
			case 12:
			case 13:
			default :
				node.src = "../images/voip1_down.png";
				break;		
		}
	}
}

function LoadFrame()
{
	displayPortInfoImage();
	
	var codeTxt;
	if(parseInt(devRegisterSync) == 0)
	{
		if(parseInt(authStatus) == 5)
		{
			if(parseInt(authResult) == 1)
			{
				codeTxt = "�Ѿ�ע��ɹ�����������ע�ᡣ";
			}
			else
			{
				codeTxt = "�Ѿ�ע��ɹ�����������ע�ᡣ��������ע�ᣬ���������ȫ�ָ����ԡ�";
			}
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else if(parseInt(authStatus) == 0 && parseInt(authResult) == 1)
		{
			codeTxt = "ע��ɹ����·�ҵ��ɹ���";
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else if(parseInt(authResult) == 0 || parseInt(authResult) == 2)
		{
			codeTxt = "�ϴ��豸ע��ҵ���·������������¼WEB��������ȫ�ָ�������ע�ᡣ";
			setDisplay("tb_register","none");
			setDisplay("tb_progressBar","");
			setDisplay("progress","none");
			document.getElementById("information").innerHTML = codeTxt;
		}
		else
		{
			setDisplay("tb_register","");
			setDisplay("tb_progressBar","none");
		}
		
	}
	else
	{
		setDisplay("tb_register","");
		setDisplay("tb_progressBar","none");
	}
}

function codeTransform()
{
	var codeTxt;
	var codeTxt2;
	if(parseInt(oltAuthRst) == 99)
	{
		codeTxt = "�ն�����ע��OLT";
	}
	else if(parseInt(oltAuthRst) != 0)
	{
		switch(parseInt(oltAuthRst))
		{
			case -1:
				codeTxt = "��OLT��ע��ʧ�ܣ������߼�ID�������Ƿ���ȷ��";
				break;
			case 2:
				codeTxt = "��OLT��ע��ʧ��(�߼�ID����)�������߼�ID�������Ƿ���ȷ��";
				break;
			case 3:
				codeTxt = "��OLT��ע��ʧ��(�߼��������)�������߼�ID�������Ƿ���ȷ��";
				break;
			case 4:
				codeTxt = "��OLT��ע��ʧ��(�߼�ID��ͻ)�������߼�ID�������Ƿ���ȷ��";
				break;
			case 10:
				codeTxt = "��OLT��ע��ʧ��(����SN��ͻ)�����������Ƿ���ȷ��";
				break;
			case 11:
				codeTxt = "��OLT��ע��ʧ��(����Դ)�������ԡ�";
				break;
			case 12:
				codeTxt = "��OLT��ע��ʧ��(ONU���ʹ���)��";
				break;
			case 13:
				codeTxt = "��OLT��ע��ʧ��(����SN����)�����������Ƿ���ȷ��";
				break;
			case 14:
				codeTxt = "��OLT��ע��ʧ��(�����������)�����������Ƿ���ȷ��";
				break;
			case 15:
				codeTxt = "��OLT��ע��ʧ��(���������ͻ)�����������Ƿ���ȷ��";
				break;
			default:
				codeTxt = "��OLT��ע��ʧ�ܣ������ԡ�";
				break;				
		}
		
	}
	else
	{
		if(parseInt(getACSIPRst) == 99)
		{
			codeTxt = "OLTע��ɹ����ն����ڻ�ȡ�����ַ��";
		}
		else if(parseInt(getACSIPRst) == -1)
		{
			codeTxt = "�ն˻�ȡ�����ַʧ�ܣ������ԡ�";
		}
		else		//getACSIPRst == 0
		{
			if(iNeedAcsAuthFlag == 0)	//first display
			{
				codeTxt = "�ն˻�ȡ�����ַ�ɹ���";
			}
			else
			{
				if(parseInt(authTimes) < parseInt(authLimit))
				{
					codeTxt2 = "�����ԣ�ʣ�ೢ�Դ�����" + (parseInt(authLimit) - parseInt(authTimes)) + ")";
				}
				else
				{
					codeTxt2 = "�ѳ����ն���֤������������ϵ�ͷ���";
				}
				switch(parseInt(authStatus))
				{
					case 0:
						switch(parseInt(authResult))
						{
							case 99:
								codeTxt = "�ն�ע��RMS����ƽ̨�ɹ����ȴ��·�ҵ�����ݣ�";
								break;
							case 0:
								codeTxt = "RMS�����·�ҵ������ϵ���ι��ˣ�";
								break;
							case 1:
								codeTxt = "ע��ȫ����ɣ�ҵ���·����óɹ�����ӭʹ��������ͨ��ͨ��ҵ��";
								break;
							case 2:
								codeTxt = "ע��ɹ����·�ҵ��ʧ�ܡ�";
								break;
							default:
								codeTxt = "�ն�ע��RMS����ƽ̨�ɹ���";
								break;
						}
						break;
					case 1:
						codeTxt = "�û���֤�벻���ڡ�" + codeTxt2;
						break;
					case 2:
						codeTxt = "�û��߼�ID�����ڡ�" + codeTxt2;
						break;
					case 3:
						codeTxt = "�û��߼�ID���û���֤��ƥ��ʧ�ܡ�" + codeTxt2;
						break;
					case 4:
						codeTxt = "ע�ᳬʱ��������·�����ԡ�";
						break;
					case 5:
						codeTxt = "�Ѿ�ע��ɹ�����������ע�ᡣ";
						break;
					case 99:
						codeTxt = "�ѻ�ù����ַ������ע��RMS����ƽ̨��";
						break;
					default:
						codeTxt = "ע��ʧ�ܣ������ԡ�";		/* �淶���޴���ʾ��Ϣ --��ȡע����ʧ�� */
						break;
				}
			}
		}
	}

	return codeTxt;
}

function identityRegist()
{	
	with ( document.forms[0] ) 
	{
		if(LOID.value.length <= 0) {
			alert("�߼�IDΪ�գ��������߼�ID!");
			return false;
		}

		if(LOPWD.value.length <= 0) {
			LOPWD.value="";
		}
		register();
		return true;
	}	
}
function register(){	
	setDisplay("tb_register","none");
	setDisplay("tb_progressBar","");
	
	progress = new CProgress("progress", 300, 15, 0);
	progress.Create();
	if(start == 0)
	{
		send_request();
		bar = setInterval("progress.Inc();",200);
//		res = setInterval("checkresult();",5000);
		res = setInterval("checkresult();",10000);	//2011-10-13��Ӧ�ṤҪ���޸�Ϊ10��
	}
	else if(start == 2)
	{
		document.getElementById("information").innerHTML = "ע������ѳ���������Դ���<br>����ϵ�ͷ���";
	}
	else
	{
		document.getElementById("information").innerHTML = "�������ڲ�����";
	}
}

function CProgress(progressIdStr, width, height, pos)
{
    this.progressIdStr = progressIdStr;
    this.progressId = document.getElementById(this.progressIdStr);
    this.barIdStr = progressIdStr + "_bar";
    this.barId = null;
    
    this.pos = pos>=100?100:pos;
    this.step = 1;
	this.rate = 10;
	this.limit = 10;
	this.result = "�ն�������OLTע�᣻";

    this.progressWidth = width;
    this.progressHeight = height;
    
    this.Create = Create;

    this.SetStep = SetStep;
    this.SetPos = SetPos;
	this.SetResult = SetResult;
	this.SetRate = SetRate;
	this.SetLimit = SetLimit;
    this.Inc = Inc;
    this.Desc = Desc;
}

function Create()
{
    if (document.all)
    {
        this.progressId.style.width = this.progressWidth+2;
    }
    else
    {
        this.progressId.style.width = this.progressWidth;
    }
    this.progressId.style.height = this.progressHeight;
    this.progressId.style.fontSize = this.progressHeight;
    this.progressId.style.border = "1px solid #000000";
    this.progressId.innerHTML = "<div id=\"" + this.barIdStr + "\" style=\"background-color:#aabbcc;height:100%;text-align:center\"></div>";
    this.barId = document.getElementById(this.barIdStr);
    this.SetPos(this.pos);
}

function SetStep(step)
{
    this.step = step;
}

function SetPos(pos)
{
    this.pos = (pos<=0)?0:pos;
    this.pos = (parseInt(this.pos) >parseInt(this.limit))?this.limit:this.pos;
    if(this.rate == -1)
    	this.pos = 100;

		showResult();
}

function Inc()
{
	count++;		
	this.pos = parseInt(this.pos) + parseInt(this.step);
	this.SetPos(this.pos);
}

function Desc()
{
    this.pos -= this.step;
    this.SetPos(this.pos);
}

function SetLimit(limit){
	this.limit = limit<0?0:limit;
	this.limit = this.limit>100?100:this.limit;
}

function SetRate(rate){	
	this.rate = rate;

	if(parseInt(rate) > parseInt(this.pos)){
		this.SetLimit(parseInt(rate));
	}
}

function SetResult(result){
	this.result = result;
}

function showResult(){	
	if(count > 3000) {								//2400	--8����	//2011-10-13Ӧ�ṤҪ���޸�Ϊ10����
		progress.barId.style.width = "100%";
		document.getElementById("information").innerHTML = 
			"<a href=\"/devregist/register_lncu.asp\">ע�ᳬʱ��������·�����ԡ�</a>";
	}else{
		progress.barId.style.width = progress.pos+"%";
//		if(parseInt(progress.pos) >= parseInt(progress.rate))
			document.getElementById("information").innerHTML = progress.result;
	}

	progress.barId.innerHTML=progress.barId.style.width;

	if(progress.barId.style.width == "100%"){
		window.clearInterval(bar);
		window.clearInterval(res);
		return;
	}
}

 // create an XMLHttpClient in a cross-browser manner  
 function initXMLHttpClient(){  
   var xmlhttp;  
   try {xmlhttp=new XMLHttpRequest()} // Mozilla/Safari/IE7 (normal browsers)  
   catch(e){                          // IE (?!)  
     var success=false;  
     var XMLHTTP_IDS=new Array('MSXML2.XMLHTTP.5.0','MSXML2.XMLHTTP.4.0',  
                               'MSXML2.XMLHTTP.3.0','MSXML2.XMLHTTP','Microsoft.XMLHTTP');  
     for (var i=0; i<XMLHTTP_IDS.length && !success; i++)  
       try {success=true; xmlhttp=new ActiveXObject(XMLHTTP_IDS[i])} catch(e){}  
     if (!success) throw new Error('Unable to create XMLHttpRequest!');  
   }  
   return xmlhttp;  
 }  
 
 function send_request(){ 
	loId = document.getElementById("LOID").value;
	loPwd = document.getElementById("LOPWD").value;
	request.open('GET','/goform/devRegister?LOID=' + loId + '&LOPWD=' + loPwd + '&' + Math.random(), true); // open asynchronus request  
	request.onreadystatechange = request_handler;          // set request handler  
	request.send(null);                                    // send request  
 } 

 function request_handler()
 { 
   if (request.readyState == 4){ // if state = 4 (the operation is completed)  
   
     if (request.status == 200 || request.status == 0){ // and the HTTP status is OK  
       // get progress from the XML node and set progress bar width and innerHTML  
		var array = request.responseText.split("|");
		oltAuthRst = array[0];
		getACSIPRst = array[1];
		authStatus = array[2];
		authResult = array[3];
		authTimes = array[4];
		authLimit = array[5];
		iNeedAcsAuthFlag = array[6];
		progress.SetRate(array[7]);	   
		progress.SetResult(codeTransform());
		result_flag = 1;
		result_count += 1;
     }  
     else{ // if request status is different then 200  
       progress.style.width = '100%';  
       progress.innerHTML='Error: ['+request.status+'] '+request.statusText;  
     }  
   }
 } 

 function checkresult(){
	 
	if(result_flag == 1){
		result_flag = 0;
		send_request();		
	}
 }
</script>
<STYLE type="text/css">
.STYLE_BODY {
	background-image: url(../images/background.png);
	background-repeat: repeat-x;
	
}
.STYLE1 {
	border: none;
	background-image: url(../images/fiberhomelogo-3.png);
	background-repeat: no-repeat;	
	background-position: bottom center;	
}
.STYLE2 {
	color: #3f5a1f;
	text-align: center;	
	font-size: 20px;
	font-weight:bold
}
.STYLE3 {
	color: #3f5a1f;
	text-align: left;	
	font-size: 13px;
	font-weight:bold
}
.STYLE4 {
	color: #3f5a1f;
	text-align: left;
	font-size: 13px;	
}
.STYLE5 {
	color: #87431e;
	text-align: left;	
	font-size: 16px;
}
</style>
</head>
<body class="STYLE_BODY" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadFrame()">
<form>
  <table valign="middle" height="100%" width="100%">
  <tbody>
    <tr valign="middle" height="80%">
      <td width="33%"></td>
      <td width="33%"><table valign="middle" align="center" background="../images/login_admin.png" border="0" cellpadding="0" cellspacing="0" width="935" height="415">
          <tbody>
            <tr>
              <td width="53%"><table valign="middle" height="415" width="100%" border="0">
                  <tbody>
                    <tr height="20%">
                      <td><table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
                          <tbody>
                            <tr height="60%">
                              <td width="40%" rowspan="2"></td>
                              <td width="20%" class="STYLE1"></td>
                              <td width="2%"></td>
                              <td width="38%" valign="bottom" class="STYLE5"><% getCfgGeneral(1, "DeviceType"); %></td>
                            </tr>
                            <tr>
                              <td colspan="2"></td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                    <tr height="62%">
                      <td ><table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
                          <tbody>
                            <tr>
                              <td width="18%" rowspan="3"></td>
                              <td class="STYLE2">�߼�IDע��</td>
                            </tr>
                            <tr>
                              <td class="STYLE3">��ͥ�����ն��߼�IDע����ʾ��</td>
                            </tr>
                            <tr>
                              <td align="left" valign="top" class="STYLE4">1.�������ˣ���鲢ȷ��LOS��Ϩ��PON����˸<br>
                                2.׼ȷ���롰�߼�ID���͡����롱�������ע�ᡱ����ע��<br>
                                3.��ע�ἰҵ���·������У�10�����ڣ����Ƕϵ硢��Ҫ�ι�����<br>
                                4.��ע�Ṧ�ܽ��������豸����֤��ҵ���·��������������豸��<br>
                                ������ע��</td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                    <tr height="15%">
                      <td><table border="0" cellpadding="1.5" cellspacing="0" height="100%" width="100%">
                          <tbody>
                            <tr height="50%">
                              <td width="10%" rowspan="2"></td>
                              <td width="18%" class="STYLE5">�չ⹦�ʣ�</td>
                              <td width="22%" class="STYLE5"><% getCfgGeneral(1, "onu_outpower"); %>
                                <span> dBm</span></td>
                              <td rowspan="2" class="STYLE5"><table align="center" border="0" height="100%" width="100%">
                                  <tbody>
                                    <tr>
                                      <td width="15%"><img id="img_lan1"></td>
                                      <td width="15%"><img id="img_lan2"></td>
                                      <td width="15%"><img id="img_lan3"></td>
                                      <td width="15%"><img id="img_lan4"></td>
                                      <td width="10%"></td>
                                      <td width="15%"><img id="img_voip1"></td>
                                      <td width="15%"><img id="img_voip2"></td>
                                    </tr>
                                  </tbody>
                                </table></td>
                            </tr>
                            <tr height="50%">
                              <td class="STYLE5">���⹦�ʣ�</td>
                              <td class="STYLE5"><% getCfgGeneral(1, "onu_inpower"); %>
                                <span> dBm</span></td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                    <tr height="3%">
                      <td></td>
                    </tr>
                  </tbody>
                </table></td>
              <td width="37%"><table valign="middle" height="100%" width="100%" border="0">
                  <tbody>
                    <tr height="12%">
                      <td width="100%"><table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
                          <tbody>
                            <tr>
                              <td align="right"><a href="../cu.html"><font color="#000000" size="2">���ص�¼ҳ��</font></a></td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                    <tr height="88%">
                      <td width="100%"><table id="tb_register" border="0" cellpadding="0" cellspacing="0" height="200">
                          <tbody>
                            <tr>
                              <td colspan="2" height="12"></td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center" height="25">ע: �������������߼�ID������</td>
                            </tr>
                            <tr>
                              <td align="right" height="25" valign="bottom" width="60">�߼�ID&nbsp;</td>
                              <td align="left" valign="bottom" width="200"><input name="LOID" id="LOID" size="24" maxlength="24" type="text"></td>
                            </tr>
                            <tr height="8">
                              <td colspan="2"></td>
                            </tr>
                            <tr>
                              <td align="right" height="25" valign="top" width="60">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                              <td align="left" valign="top" width="200"><input name="LOPWD" id="LOPWD" size="24" maxlength="12" type="text"></td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center" height="35"><input name="submit" value="&nbsp;ע&nbsp;��&nbsp;" type="button" onClick="identityRegist()">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input name="cancel" value="&nbsp;��&nbsp;��&nbsp;" type="reset">
                              </td>
                            </tr>
                            <tr>
                              <td colspan="2" height="20"></td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center" height="20" width="100%"><font size="2"> </font></td>
                            </tr>
                            <tr>
                              <td colspan="2" align="left" height="30"></td>
                            </tr>
                          </tbody>
                        </table>
                        <table id="tb_progressBar" align="center" border="0" cellpadding="0" cellspacing="0" height="80%" width="400" style="display:none">
                          <tbody>
                            <tr>
                              <td colspan="2" id="note" height="32"></td>
                            </tr>
                            <tr align="">
                              <td colspan="2" align="left" height="10" width="100%"><div style="width: 300px; height: 15px; font-size: 15px; border: 1px solid rgb(0, 0, 0);" id="progress" align="left">
                                  <div id="progress_bar" style="background-color: rgb(170, 187, 204); height: 100%; text-align: center;"></div>
                                </div></td>
                            </tr>
                            <tr>
                              <td colspan="2" id="information" align="left" height="20" width="100%">�ն�������OLTע��</td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center" height="20" width="100%"><font size="2"> </font></td>
                            </tr>
                            <tr>
                              <td colspan="2" align="left" height="60"></td>
                            </tr>
                          </tbody>
                        </table></td>
                    </tr>
                  </tbody>
                </table></td>
              <td width="10%">&nbsp;</td>
            </tr>
          </tbody>
        </table></td>
      <td width="34%"></td>
    </tr>
</form>
</body>
</html>
