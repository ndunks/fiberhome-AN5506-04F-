<!-- saved from url=(0022)http://internet.e-mail -->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�豸ע��</title>
<script type="text/javascript" src="/js/utils.js"></script>
<script type="text/javascript" language="javascript">

var devRegisterJiangSu_teleSync = '<% devRegisterJiangSu_teleSync(); %>';

var devreg_result = '<% getCfgZero("1", "LOID_result");%>';

function LoadFrame()
{
	if ( devreg_result == '1')
	{
		document.getElementById("devreg_tip").innerHTML = "����LOID�ɹ�!";
	}
	else if ( devreg_result == '0')
	{
		document.getElementById("devreg_tip").innerHTML = "����LOIDʧ��!";
	}
	else 
	{
		document.getElementById("devreg_tip").innerHTML = "";
	}
}

function checkValue()
{
	var logicSN = document.getElementById("LOID");
	var logicPwd = document.getElementById("LOPWD");
	if (!CheckNotNull(logicSN.value)) 
	{
		alert(_("sncfg_loidNullAlert"));
		logicSN.value = logicSN.defaultValue;
		logicSN.focus();
		return false;
	}

	if(!checkASCIIChar(logicSN.value))
	{
		alert(_("sncfg_loidchnAlert"));
		logicSN.value = logicSN.defaultValue;
		logicSN.focus();
		return false;
	}
}

</script>
</head>
<body onLoad="LoadFrame();">
<form method="post" name="ddns_form" action="/goform/devRegister_JiangSu_tele" onSubmit="return CheckValue()">
  <table align="center" border="0" cellpadding="0" cellspacing="0" width="808">
    <tbody>
      <tr>
        <td></td>
      </tr>
      <tr>
        <td><table align="middle" border="0" cellpadding="0" cellspacing="0" width="808">
            <tbody>
              <tr>
                <td rowspan="3" width="77"></td>
                <td align="center" background="../images/register_content.gif" height="323" width="653">
					<table border="0" cellpadding="0" cellspacing="0" height="50" width="96%">
                    <tbody>
                      <tr>
                        <td align="right"><a href="../login.html"><font color="#000000" size="2">���ص�¼ҳ��</font></a></td>
                      </tr>
                    </tbody>
                  </table>
                  <table id="tb_register" border="0" cellpadding="0" cellspacing="0" height="200" width="400" >
                    <tbody>
                      <tr>
                        <td colspan="2" height="12"></td>
                      </tr>
					  
                      <tr>
                        <td colspan="2" align="center" height="25">����������ҵ��ʱ���ṩ���ʺš�</td>
                      </tr>
                      <tr>
                        <td align="right" height="25" valign="bottom" width="130">�߼�ID��</td>
                        <td align="left" valign="bottom" width="200"><input name="LOID" id="LOID" size="24" maxlength="24" type="text"></td>
                      </tr>
                      <tr height="8">
                        <td colspan="2"></td>
                      </tr>
                      <tr>
                        <td align="right" height="25" valign="top" width="130">��&nbsp;&nbsp;�룺</td>
                        <td align="left" valign="top" width="200"><input name="LOPWD" id="LOPWD" size="24" maxlength="12" type="text"></td>
                      </tr>
                      <tr>
                        <td colspan="2" align="center" height="35"><input name="submit" value="&nbsp;ע&nbsp;��&nbsp;" type="submit">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <input name="cancel" value="&nbsp;ȡ&nbsp;��&nbsp;" type="reset">
                        </td>
                      </tr>
					  
                      <tr>
                        <td colspan="2" align="center" height="30" width="100%" id="devreg_tip" style="color:#FF0000"><font size="4"> LOID���Ƴɹ�! </font></td>
                      </tr>
                       <tr>
                        <td colspan="2" align="center" height="50"  width="100%"><font size="4">  </font></td>
                      </tr>
                    
                    </tbody>
                  </table>
              </td>
                <td rowspan="3" width="78"></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>

