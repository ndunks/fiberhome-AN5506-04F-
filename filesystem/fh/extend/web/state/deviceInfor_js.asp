<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<meta http-equiv="Refresh" content="20"> 

<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="/lang/b28n.js"></script>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" src="/js/checkValue.js"></script>
<title>Device Information</title>
<script language="JavaScript" type="text/javascript">

/* ����û��Ƿ�LOGIN */
var checkResult = '<% cu_web_access_control(); %>'
web_access_check(checkResult);

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("state", lang);

var setDeviceInfoSync = '<% setDeviceInfoSync(); %>';

var reg_state = '<% getCfgGeneral(1, "reg_state"); %>';
var ONT_state = '<% getCfgGeneral(1, "ONT_state"); %>';

function initTranslation()
{
	var e = document.getElementById("deviceinf_prompt");
	e.innerHTML = _("deviceinf_prompt");

	e = document.getElementById("DeInf");
	e.innerHTML = _("DeInf");
	e = document.getElementById("softver");
	e.innerHTML = _("softver");
	e = document.getElementById("hardver");
	e.innerHTML = _("hardver");
	e = document.getElementById("device_model");
	e.innerHTML = _("device_model");
	e = document.getElementById("device_descrip");
	e.innerHTML = _("device_descrip");
	e = document.getElementById("ONU_state");
	e.innerHTML = _("ONU_state");
	e = document.getElementById("CPU_rate");
	e.innerHTML = _("CPU_rate");
	e = document.getElementById("mem_rate");
	e.innerHTML = _("mem_rate");
			
}

function codeTransform1()
{
	var codeTxt;
	reg_state = parseInt(reg_state);

	/* modify by ��С��, 20150922, ԭ��:Ӧ�߳�Ҫ�󣬷�ֵΪ0/99ʱ���ж�O5 */
	if(reg_state == 0 || reg_state == 99)
	{
		/* modify by ��С��, 20150424, ԭ��:����������֤�ɹ�ʱreg_stateҲΪ99����Ҫ���ж�O5״̬ */
		if(ONT_state == "O5(STATE_OPERATION)")
		{
			codeTxt = "��ע������֤";
		}
		else
		{
			codeTxt = "δע��δ��֤";
		}
	}
	else		//-1
	{
		codeTxt = "��ע��δ��֤";
	}

	return codeTxt;
}

function initValue()
{
	initTranslation();

}

</script>
</head>
<body class="mainbody" onLoad="initValue()">
<form method="post" name="deviceinf" id="deviceinf">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr>
                <td id="deviceinf_prompt" class="title_01" style="padding-left: 10px;" width="100%">You can query device information here.</td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr>
        <td height="5px"></td>
      </tr>
    </tbody>
  </table>
  <table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
    <tbody>
      <tr class="tabal_head">
        <td colspan="2" id="DeInf">Device Information</td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="softver">Software Version</td>
        <td class="tabal_right"><% getCfgGeneral(1, "software_version"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="hardver">Hardware Version</td>
        <td class="tabal_right"><% getCfgGeneral(1, "hardware_version"); %></td>
      </tr>
      <tr>
        <td class="tabal_left" width="25%" id="device_model">�豸�ͺ�</td>
        <td class="tabal_right"><% getCfgGeneral(1, "DeviceType"); %></td>
      </tr>
        <tr>
        <td class="tabal_left" width="25%" id="device_descrip">�豸����</td>
        <td class="tabal_right"><% getCfgGeneral(1, "PonType"); %></td>
      </tr>
        <tr>
        <td class="tabal_left" width="25%" id="ONU_state">ONT ע��״̬</td>
        <td class="tabal_right" id ="ONU_state_value">
			                <script language="javascript">
					var codeTxt = codeTransform1();
					document.write(codeTxt);
				</script>
               </td> 
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="ONU_ID">ONT ID</td>
        <td class="tabal_right"><% getCfgGeneral(1, "ONT_ID"); %></td> 
      </tr>
   
       <tr>
        <td class="tabal_left" width="25%" id="CPU_rate">CPU ʹ����</td>
        <td class="tabal_right"><% getCfgGeneral(1, "CPU_rate"); %></td> 
      </tr>
       <tr>
        <td class="tabal_left" width="25%" id="mem_rate">Memory ʹ����</td>
        <td class="tabal_right"><% getCfgGeneral(1, "mem_rate"); %></td> 
      </tr>
    
      </tbody>
  </table>
</form>
</body>
</html>