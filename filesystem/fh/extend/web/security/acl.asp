<!-- Copyright 2011, Fiberhome Telecommunication Technologies Co.,Ltd. All Rights Reserved. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../style/style.css" type="text/css"/>
<script type="text/javascript" src="../lang/b28n.js"></script>
<script type="text/javascript" src="../js/utils.js"></script>
<script type="text/javascript" src="../js/checkValue.js"></script>
<title>IP Filter</title>
<script language="JavaScript" type="text/javascript">

/*  asp ҳ���м����û��Ƿ�LOGIN�ļ��begin*/
var  checkResult = '<% cu_web_access_control(  ) ;%>'
web_access_check( checkResult) ;
//web_access_check_admin( checkResult) ;
/*  �����û��Ƿ�LOGIN�ļ��end*/

var lang = '<% getCfgGeneral(1, "language"); %>';
Butterlate.setTextDomain("acl", lang);

var ACLModeSync = '<% ACLModeSync(); %>';
	
var acl_rulesSum = '<% getCfgGeneral(1, "acl_rulesSum"); %>';

var acl_mode = '<% getCfgGeneral(1, "acl_mode"); %>';

var acl_type = '<% getCfgGeneral(1, "acl_type"); %>';

var sumPerPortArr = new Array(0, 0, 0, 0);

function initTranslation()
{ 
	var e = document.getElementById("acl_funcPrompt");
	e.innerHTML = _("acl_funcPrompt");
	e = document.getElementById("acl_usePrompt");
	e.innerHTML = _("acl_usePrompt");
	
	e = document.getElementById("acl_refresh");
	e.value = _("acl_refresh");	
	e = document.getElementById("acl_submit");
	e.value = _("acl_submit");
	e = document.getElementById("acl_apply");
	e.value = _("acl_apply");	
	e = document.getElementById("acl_cancel");
	e.value = _("acl_cancel");
	e = document.getElementById("acl_add");
	e.value = _("acl_add");
	e = document.getElementById("acl_delete");
	e.value = _("acl_delete");
	e = document.getElementById("acl_deleteAll");
	e.value = _("acl_deleteAll");
	
	e = document.getElementById("acl_switchTitle");
	e.innerHTML = _("acl_switchTitle");
	e = document.getElementById("acl_disableTitle");
	e.innerHTML = _("acl_disableTitle");	
	e = document.getElementById("acl_enableTitle");
	e.innerHTML = _("acl_enableTitle");	
	e = document.getElementById("acl_modeTitle");
	e.innerHTML = _("acl_modeTitle");
	e = document.getElementById("acl_modeBlackTitle");
	e.innerHTML = _("acl_modeBlackTitle");
	e = document.getElementById("aacl_modeWhiteTitle");
	e.innerHTML = _("aacl_modeWhiteTitle");
	e = document.getElementById("acl_typeTitle0");
	e.innerHTML = _("acl_typeTitle");
	e = document.getElementById("acl_typeTitle");
	e.innerHTML = _("acl_typeTitle");
	e = document.getElementById("acl_typeTitle2");
	e.innerHTML = _("acl_typeTitle");
	e = document.getElementById("acl_listHead");
	e.innerHTML = _("acl_listHead");	
	e = document.getElementById("acl_portTitle");
	e.innerHTML = _("acl_portTitle");	
	e = document.getElementById("acl_portTitle2");
	e.innerHTML = _("acl_portTitle");
		
	e = document.getElementById("acl_portTips");
	e.innerHTML = _("acl_portTips");
	e = document.getElementById("acl_ipTips");
	e.innerHTML = _("acl_ipTips");
	e = document.getElementById("acl_macTips");
	e.innerHTML = _("acl_macTips");
	e = document.getElementById("acl_vidTips");
	e.innerHTML = _("acl_vidTips");
}
function LoadFrame()
{ 
	initTranslation();
	
	showAclBasicData();

	setDisplay("ConfigForm1", "none");
	initSumPerPortArr();
	
}

function showAclBasicData()
{
	if(acl_mode == 0)	//disable
	{
		getElement("acl_switch")[0].checked = true;
		onClickSwitch(0);
	}
	else
	{
		getElement("acl_switch")[1].checked = true;
		onClickSwitch(1);	
		if(acl_mode == 2)	//black
		{
			getElement("acl_mode")[0].checked = true;
		}
		else if(acl_mode == 1)	//white
		{
			getElement("acl_mode")[1].checked = true;
		}
	}

	getElement("acl_type")[acl_type].selected = true;
	
}

function initSumPerPortArr()
{
	var tab = getElement("acl_ruleTable");

	if(acl_rulesSum > 0)
	{
		var curPort;
		for(var i = 2; i < tab.rows.length; i++)
		{
			curPort = parseInt(tab.rows[i].cells[0].getElementsByTagName("input")[0].value);
			sumPerPortArr[curPort-1]++;
		}
	}
}

function onClickSwitch(switchValue)
{
	if(switchValue == 0)	//disable
	{
		setDisplay("tr_aclMode", "none");
//		getElement("acl_mode")[0].checked = false;	//radio������δʵ��--yuzi
//		getElement("acl_mode")[1].checked = false;
		getElement("acl_type").disabled = 1;
		getElement("acl_add").disabled = 1;
		getElement("acl_delete").disabled = 1;
		getElement("acl_deleteAll").disabled = 1;
		
		var tab = getElement("acl_ruleList").getElementsByTagName('table');
		var rowLen = tab[0].rows.length;
		var lastRow = tab[0].rows[rowLen - 1];
		var temp = lastRow.id.split('_')[1];
		if(temp == "new")
		{
			tab[0].deleteRow(rowLen-1);	
		}
		setDisplay("ConfigForm1", "none");

	}
	else
	{
		setDisplay("tr_aclMode", "")
		getElement("acl_mode")[0].checked = true;
//		getElement("acl_mode").disabled = 0;
		getElement("acl_type").disabled = 0;
		getElement("acl_add").disabled = 0;
		getElement("acl_delete").disabled = 0;
		getElement("acl_deleteAll").disabled = 0;
	}
}

function changeType(newType, tabTitle)
{
//	if(confirm("������෢���仯����ɾ��ԭ�й����Ƿ����?") == false)
	if(confirm(_("acl_changeTypeConfirm")) == false)
	{
		getElement("acl_type")[acl_type].selected = true;
		return ;	
	}
	else	//ȷ��ɾ��
	{
		acl_type = newType;
		removeAll(tabTitle);
	}
	
	setDisplay("ConfigForm1", "none");
}

function removeAll(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	
	var row, col;
	var rowLen = tab[0].rows.length;

	for(var i = 2; i < rowLen; i++)		//0--head; 1--title
	{
		tab[0].deleteRow(2);
	}
	
	acl_rulesSum = 0;
	for(var i = 0; i < 4; i++)
	{
		sumPerPortArr[i] = 0;
	}
}

function remove(tabTitle, removeArr)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	
	var row, col;
	var indexLen = removeArr.length;
	var curDelIndex;
	var curPort;

	for(var i = indexLen - 1; i >= 0; i--)
	{
		for(var j = 0; j < tab[0].rows.length; j ++)
		{
			if(tab[0].rows[j].id.split('_')[1] == removeArr[i])
			{
				curDelIndex = tab[0].rows[j].rowIndex;
				break;
			}
		}
		//����port��Ŀ��
		curPort = tab[0].rows[curDelIndex].cells[0].getElementsByTagName("input")[0].value;;
		sumPerPortArr[curPort-1]--;
		
		tab[0].deleteRow(curDelIndex);
		acl_rulesSum--;
	}
}

function add(tab)
{	
	var curPort = parseInt(getElement("acl_port").value);
	
	//����Ϸ���
	if(!checkValue())
		return;
	
	if(curPort != 0)	//not ALL
	{
		//������Ŀ��
		if(!checkDataSum(curPort))
			return;
		
		//�����ظ���
		if(!checkDataRepeatability(tab, curPort, "new"))
			return;
		
		addNewData(tab, curPort);
	}
	else
	{		
		for(var i = 1; i <= 4; i++)
		{
			//������Ŀ��
			if(!checkDataSum(i))
				return;
			
			//�����ظ���
			if(!checkDataRepeatability(tab, i, "new"))
				return;
		}
		
		addNewData(tab, 1);
		for(var i = 2; i <= 4; i++)
		{
			addNewRow(tab);
			addNewData(tab, i);
		}
	}
	selectLine(tab[0].rows[tab[0].rows.length-1].id);
}

function addNewRow(tab)
{
	var row, col;
	var rowLen = tab[0].rows.length;
	var titleRow = tab[0].rows[1];
	var lastRow = tab[0].rows[rowLen - 1];

	if(acl_rulesSum > 32)		//4*8
	{		
//   		alert("���ֻ�ܴ���32������!");
 		alert(_("acl_mostRulesAlert"));
		return;
	}
	
	if (lastRow.id == 'record_new')		//�½�
	{
		selectLine("record_new");
		return;
	}
    else if (lastRow.id == 'record_no')		//ԭ������
    {
        tab[0].deleteRow(rowLen-1);
        rowLen = tab[0].rows.length;
    }
	
	row = tab[0].insertRow(rowLen);	

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'tabal_01';
		row.id = 'record_new';
		row.attachEvent("onclick", function(){selectLine("record_null");});
		row.align = 'center';
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','tabal_01');
		row.setAttribute('id','record_new');
		row.setAttribute('onclick','selectLine(this.id);');
		row.setAttribute('align','center');
	}
	row.insertCell(0).innerHTML = '<input readonly="readonly" style="width:43px"  value="--">';
	row.insertCell(1).innerHTML = '<input readonly="readonly" style="width:142px" value="--">';
	row.insertCell(2).innerHTML = '<input readonly="readonly" style="width:170px" value="--">';
	row.insertCell(3).innerHTML = '<input readonly="readonly" style="width:170px" value="--">';
	row.insertCell(4).innerHTML = '<input readonly="readonly" style="width:100px" value="--">';
	row.insertCell(5).innerHTML = '<input type="checkbox" name="acl_removeFlag" >'
		
}
function addNewData(tab, curPort)
{		
	var curRow = getElement("record_new");
	
	var rowLen = tab[0].rows.length;
	
	var newRowID;
	if(acl_rulesSum == 0)//��ǰ������
	{
		newRowID = 0;
	}
	else
	{
		var lastRow = tab[0].rows[rowLen-2];		//��һ��
		newRowID = parseInt(lastRow.id.split('_')[1]) + 1;
	}
	curRow.id = "record_" + newRowID;
	
	curRow.cells[0].getElementsByTagName("input")[0].name = "acl_port_" + newRowID;
	curRow.cells[1].getElementsByTagName("input")[0].name = "acl_type_" + newRowID;
	curRow.cells[2].getElementsByTagName("input")[0].name = "acl_ip_" + newRowID;
	curRow.cells[3].getElementsByTagName("input")[0].name = "acl_mac_" + newRowID;
	curRow.cells[4].getElementsByTagName("input")[0].name = "acl_vid_" + newRowID;
	
	curRow.cells[0].getElementsByTagName("input")[0].value = curPort;
	curRow.cells[2].getElementsByTagName("input")[0].value = getElement("acl_ip").value;
	curRow.cells[5].getElementsByTagName("input")[0].value = newRowID;

	switch(parseInt(acl_type))
	{
		case 0: 
			curRow.cells[1].getElementsByTagName("input")[0].value = "IP";
			break;
		case 1: 
			curRow.cells[1].getElementsByTagName("input")[0].value = "IP + Mac";
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			break;
		case 2: 
			curRow.cells[1].getElementsByTagName("input")[0].value = "IP + Mac + Vid";
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			curRow.cells[4].getElementsByTagName("input")[0].value = getElement("acl_vid").value;
			break;
		default:
			break;			
	}
	sumPerPortArr[curPort-1]++;
	acl_rulesSum++;
	
}

function checkDataSum(curPort)
{
	if(sumPerPortArr[curPort-1] >= 8)
	{		
//   	alert("�˿�" + curPort + "�Ѵ���8������! �����ٴ���!");
 		alert(_("acl_portTitle") + curPort + _("acl_portMostRulesAlert"));
		return false;
	}
	return true;
}

function checkDataRepeatability(tab, curPort, curIndex)
{
	var rowLen = tab[0].rows.length;
	var newIP = getElement("acl_ip").value;
	var newMAC = getElement("acl_mac").value;
	var newVID = getElement("acl_vid").value;
	var i;

	if(rowLen == 3)	//��ǰ�����ݣ���3��Ϊrecord_new
	{
		return true;
	}
	
	for(i = 2; i < rowLen; i++)
	{
		if(tab[0].rows[i].cells[0].getElementsByTagName("input")[0].value != curPort)//port
			continue;
		else
		{
			if(tab[0].rows[i].cells[2].getElementsByTagName("input")[0].value != newIP)//ip
				continue;
			else if(acl_type == 0)
			{
				if(curIndex == tab[0].rows[i].id.split("_")[1])
				{
					continue;
				}
				else
				{
//					alert("�����й����ظ�������������!");
					alert(_("acl_ruleRepeatAlert"));
					return false;
				}
				
			}
			else if(acl_type == 1)
			{
				if(tab[0].rows[i].cells[3].getElementsByTagName("input")[0].value != newMAC)//mac
					continue;
				else
				{
					if(curIndex == tab[0].rows[i].id.split("_")[1])
					{
						continue;
					}
					else
					{
	//					alert("�����й����ظ�������������!");
						alert(_("acl_ruleRepeatAlert"));
						return false;
					}
				}
			}
			else if(acl_type == 2)
			{
				if(tab[0].rows[i].cells[3].getElementsByTagName("input")[0].value != newMAC)//mac
					continue;
				else
				{
					if(tab[0].rows[i].cells[4].getElementsByTagName("input")[0].value != newVID)//vid
						continue;
					else
					{
						if(curIndex == tab[0].rows[i].id.split("_")[1])
						{
							continue;
						}
						else
						{
		//					alert("�����й����ظ�������������!");
							alert(_("acl_ruleRepeatAlert"));
							return false;
						}
					}
				}
			}
			
		}
	}
	return true;
	
}

function modify(tab, curIndex)
{	
	var curPort = parseInt(getElement("acl_port").value);
	
	//����Ϸ���
	if(!checkValue())
		return;

	//�����ظ���
	if(!checkDataRepeatability(tab, curPort, curIndex))
		return;
	
	var curRow = getElement("record_" + curIndex);
	
	var rowLen = tab[0].rows.length;
		
	curRow.cells[0].getElementsByTagName("input")[0].value = curPort;
	curRow.cells[2].getElementsByTagName("input")[0].value = getElement("acl_ip").value;

	switch(parseInt(acl_type))
	{
		case 0: 
			break;
		case 1: 
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			break;
		case 2: 
			curRow.cells[3].getElementsByTagName("input")[0].value = getElement("acl_mac").value;
			curRow.cells[4].getElementsByTagName("input")[0].value = getElement("acl_vid").value;
			break;
		default:
			break;			
	}
	selectLine(curRow);
}

function clickAdd(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	addNewRow(tab);
	
	selectLine("record_new");
	getElement("acl_port").focus();
	
//	setDisplay("ConfigForm1", "");	//ȫɾ��ñ�����
}

function selectLine(id)
{
	var objTR = getElement(id);

	if (objTR != null)
	{
		if(getElement("acl_switch")[0].checked)	//disable
		{
			return;
		}
		
		var temp = objTR.id.split('_')[1];
		if (temp == 'new')		//�½�
		{					
			getElement("acl_port").value = "0";
			getElement("acl_type2").value = acl_type;			
			getElement("acl_ip").value = "";
			getElement("acl_mac").value = "";
			getElement("acl_vid").value = "";
			
			getElement("acl_port").disabled = 0;
						
			setLineHighLight(objTR);
		}
        else if (temp == 'no')	//ԭ���û�
        {
        }
		else
		{
			getElement("acl_port").value = objTR.cells[0].getElementsByTagName("input")[0].value;
			getElement("acl_type2").value = acl_type;			
			getElement("acl_ip").value = objTR.cells[2].getElementsByTagName("input")[0].value;
			getElement("acl_mac").value = objTR.cells[3].getElementsByTagName("input")[0].value;
			getElement("acl_vid").value = objTR.cells[4].getElementsByTagName("input")[0].value;

			getElement("acl_port").disabled = 1;
		
            setLineHighLight(objTR);
		}
		//type�����޸�
		getElement("acl_type2").disabled = 1;
		
		switch(parseInt(acl_type))
		{
			case 0:		//ip
				getElement("acl_mac").disabled = 1;
				getElement("acl_vid").disabled = 1;
				getElement("acl_mac").value = "--";
				getElement("acl_vid").value = "--";
				break;
			case 1:		//ip+mac
				getElement("acl_mac").disabled = 0;
				getElement("acl_vid").disabled = 1;
				getElement("acl_vid").value = "--";
				break;
			case 2:		//ip+mac+vid
				getElement("acl_mac").disabled = 0;
				getElement("acl_vid").disabled = 0;
				break;
			default:
				break;
		}
		
		//��־��ǰ�༭�����id
		getElement("acl_curIndex").value = temp;	
		
		setDisplay("ConfigForm1", "");	
		getElement("acl_ip").focus();
		
	}	 
}

function clickRemove(tabTitle)
{
	if(acl_rulesSum == 0)
	{			
// 		alert("��ǰû�й��򣬲���ɾ��!");
 		alert(_("acl_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('acl_removeFlag');
    var noChooseFlag = true;

	var removeArr = new Array();
	var j = 0;
	
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			if(checkNodes[i].checked == true)
			{   
				removeArr[j++] = checkNodes[i].value;
			}
		}
		if(removeArr.length > 0)
			noChooseFlag = false;
	}
	else if(checkNodes.checked == true)  //for one connection
	{
		removeArr[0] = checkNodes.value;
		noChooseFlag = false;
	}
	if(noChooseFlag)
	{
//		alert('��������ѡ��һ������');
		alert(_("acl_noChooseAlert"));
		return ;
	}
	        
//	if(confirm("��ȷ��ɾ����ѡ����?") == false)
	if(confirm(_("acl_deleteRuleConfirm")) == false)
    	return;
	else
		remove(tabTitle, removeArr);

	if(tab[0].rows.length > 2)
		selectLine(tab[0].rows[2].id);	//��ʾ��һ��������
	else
		setDisplay("ConfigForm1", "none");
}

function clickRemoveAll(tabTitle)
{
	if(acl_rulesSum == 0)
	{				
// 		alert("��ǰû�й��򣬲���ɾ��!");
   		alert(_("acl_noRuleAlert"));
   		return;
	}
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var checkNodes = getElement('acl_removeFlag');
	if(checkNodes.length > 0)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = true;
		}
	}
	else
	{
		checkNodes.checked = true;
	}
	
//	if(confirm("��ȷ��ɾ����ѡ����?") == false)
	if(confirm(_("acl_deleteRuleConfirm")) == false)
	{
		for(var i = 0; i < checkNodes.length; i++)
		{
			checkNodes[i].checked = false;
		} 
		return;
	}
	else
	{
		removeAll(tabTitle);
	}

	setDisplay("ConfigForm1", "none");
}

function clickApply(tabTitle)
{	
	var curIndex = getElement("acl_curIndex").value;
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	
	//add
	if(curIndex == "new")
	{
		add(tab);
	}
	else
	{
		modify(tab, curIndex);
	}
}

function cancelRuleEdit()
{
	if(acl_rulesSum > 0)
	{	
		var row0 = getElement("acl_ruleTable").rows[2];
		selectLine(row0.id);
		setDisplay("ConfigForm1", "");
	}
	else
	{	
		setDisplay("ConfigForm1", "none");
	}
}

function clickSubmit()
{
	var tab = getElement("acl_ruleList").getElementsByTagName('table');
	var acl_lastRowNo;
	if(acl_rulesSum == 0)
	{
		acl_lastRowNo = -1;
	}
	else
	{
		acl_lastRowNo = tab[0].rows[tab[0].rows.length - 1].id.split("_")[1];
	}
	getElement("acl_lastRowNo").value = acl_lastRowNo;
	getElement("acl_ruleForm").submit();
}
function checkValue()
{
	if(!acl_checkIP(getElement("acl_ip")))
	{
		return false;
	}
	
	if(acl_type == 1 || acl_type == 2)
		if(!acl_checkMAC(getElement("acl_mac")))
		{
			return false;
		}
	
	if(acl_type == 2)
		if(!acl_checkVID(getElement("acl_vid")))
		{
			return false;
		}
	
	return true;
}

function acl_checkIP(dom)
{
	dom.value = trim(dom.value);
	if(!CheckNotNull(dom.value))	//������Ϊ��
	{
//		alert("������IP!");
		alert(_("acl_ipNullAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	if(!validateIP(dom.value))
	{
//		alert("������Ϸ�IP!");
		alert(_("acl_ipIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}

function acl_checkMAC(dom)
{
	dom.value = trim(dom.value);
	if(!CheckNotNull(dom.value))	//������Ϊ��
	{
//		alert("������Mac!");
		alert(_("acl_macNullAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	if(!validateMAC(dom.value))
	{
//		alert("Mac��ַ����ȷ��Mac��ַ��ʽΪ00:24:21:19:BD:E4"); 
		alert(_("acl_macIllegalAlert"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
	return true;
}
function acl_checkVID(dom)
{
	dom.value = trim(dom.value);
	if(isAllNum(dom.value))
	{
		dom.value = parseInt(dom.value);
		if(1 <= dom.value && dom.value <= 4095)
		{
			return true;
		}
		else
		{
	//		alert("��ЧVID��ΧΪ1��4095.");
			alert(_("acl_vidIllegalAlert1"));
			dom.value = dom.defaultValue;
			dom.focus();
			return false;
		}
	}
	else
	{
//		alert("������������.");
		alert(_("acl_vidIllegalAlert2"));
		dom.value = dom.defaultValue;
		dom.focus();
		return false;
	}
}

var previousTR = null;
function setLineHighLight(objTR)
{
    if (previousTR != null)
	{
	    previousTR.style.backgroundColor = '#f4f4f4';
		for (var i = 0; i < previousTR.cells.length; i++)
		{
			previousTR.cells[i].style.color = '#000000';
		}
	}
	
	objTR.style.backgroundColor = '#B7E3E3';//c7e7fe
	for (var i = 0; i < objTR.cells.length; i++)
	{
		objTR.cells[i].style.color = '#000000';		
	}
	previousTR = objTR;
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame()">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td class="prompt"><table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
            <tr>
              <td id="acl_funcPrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
            <tr>
              <td id="acl_usePrompt" style="padding-left: 10px;" class="title_01" width="100%"></td>
            </tr>
          </tbody>
        </table></td>
    </tr>
    <tr>
      <td height="5px"></td>
    </tr>
  </tbody>
</table>
<form method="post" id="acl_ruleForm" action="/goform/ACLCfg" >
  <table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
    <tbody>
      <tr id="tr_submitButton">
        <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr height="22">
                <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                    <tbody>
                      <tr>
                        <td><input type="reset" value="Refresh" id="acl_refresh" class="submit" onClick="window.location.reload();"/></td>
                        <td><input type="submit" value="Submit" id="acl_submit" class="submit" onClick="clickSubmit();"/></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr id="tr_basicData">
        <td><table class="tabal_bg" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td class="tabal_left" align="left" width="15%" id="acl_switchTitle">ACL Enable</td>
                <td class="tabal_right" width="15%"><input name="acl_switch" id="acl_disable" value="0" checked="checked" onclick="onClickSwitch(this.value)" type="radio"/>
                  <span id="acl_disableTitle">Disable</span></td>
                <td class="tabal_right"><input name="acl_switch" id="acl_enable" value="1" onclick="onClickSwitch(this.value)" type="radio"/>
                  <span id="acl_enableTitle">Enable</span></td>
              </tr>
            <div id="div_aclEnable">
              <tr id="tr_aclMode">
                <td class="tabal_left" align="left" width="15%" id="acl_modeTitle">ACL Mode</td>
                <td class="tabal_right"><input name="acl_mode" id="acl_modeBlack" value="2" checked="checked" type="radio"/>
                  <span id="acl_modeBlackTitle">Blacklist</span></td>
                <td class="tabal_right"><input name="acl_mode" id="acl_modeWhite" value="1" type="radio"/>
                  <span id="aacl_modeWhiteTitle">Whitelist</span></td>
              </tr>
              <tr>
                <td class="tabal_left" align="left" width="15%" id="acl_typeTitle0">ACL Type</td>
                <td colspan="2" class="tabal_right"><select name="acl_type" id="acl_type" size="1" style="width:150px" onchange="changeType(this.value, 'acl_ruleList')">
                    <option value="0" selected="selected">IP</option>
                    <option value="1">IP + Mac</option>
                    <option value="2">IP + Mac + Vid</option>
                  </select></td>
              </tr>
            </div>
          </table></td>
      </tr>
      <tr id="tr_editButton">
        <td><table id="acl_ruleEditTable" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tbody>
              <tr width="7">
                <td align="right"><table border="0" cellpadding="1" cellspacing="0">
                    <tbody>
                      <tr>
                        <td><input type="button" value="Add" id="acl_add" class="submit" onClick="clickAdd('acl_ruleList');"/></td>
                        <td><input type="button" value="Delete" id="acl_delete" class="submit" onClick="clickRemove('acl_ruleList');"/></td>
                        <td><input type="button" value="Delete All" id="acl_deleteAll" class="submit" onClick="clickRemoveAll('acl_ruleList');"/></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr id="tr_rulesData">
        <td id="acl_ruleList"><table class="tabal_bg" id="acl_ruleTable" border="0" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr class="tabal_head" id="0">
                <td colspan="6" id="acl_listHead">ACL Rules List</td>
              </tr>
              <tr class="tabal_title" id="title" align="center">
                <th width="6%" 	id="acl_portTitle">Port</th>
                <th width="22%" id="acl_typeTitle">ACL Type</th>
                <th width="26%" id="acl_ipTitle">IP</th>
                <th width="26%" id="acl_macTitle">Mac</th>
                <th width="15%" id="acl_vidTitle">Vlan ID</th>
                <th width="5%"  id="acl_removeFlagTitle"></th>
              </tr>
              <!--output detail data from server-->
              <% ACLSync(); %>
            </tbody>
          </table></td>
      </tr>
      <tr>
        <td height="22"><input type="hidden" name="acl_lastRowNo" id="acl_lastRowNo" value="0"/></td>
      </tr>
    </tbody>
  </table>
</form>
<table border="0" cellpadding="0" cellspacing="0" height="5" width="100%">
  <tbody>
    <tr>
      <td><div id="ConfigForm1">
          <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
            <tbody>
              <tr>
                <td><table class="tabal_bg" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr>
                        <td ><div id="div_acl_rule">
                            <table class="tabal_bg" cellpadding="0" cellspacing="1" width="100%">
                              <tbody>
                                <tr>
                                  <td id="acl_portTitle2" class="tabal_left" width="25%">Port</td>
                                  <td class="tabal_right"><select name="acl_port" id="acl_port" size="1" style="width:150px">
                                      <option value="0">ALL</option>
                                      <option value="1">1</option>
                                      <option value="2">2</option>
                                      <option value="3">3</option>
                                      <option value="4">4</option>
                                    </select>
                                    <span class="gray" id="acl_portTips"></span></td>
                                </tr>
                                <tr>
                                  <td id="acl_typeTitle2" class="tabal_left" width="25%">ACL Type</td>
                                  <td class="tabal_right"><select name="acl_type2" id="acl_type2" size="1" style="width:150px">
                                      <option value="0" selected="selected">IP</option>
                                      <option value="1">IP + Mac</option>
                                      <option value="2">IP + Mac + Vid</option>
                                    </select></td>
                                </tr>
                                <tr>
                                  <td id="acl_ipTitle2" class="tabal_left" width="25%">IP</td>
                                  <td class="tabal_right"><input name="acl_ip" id="acl_ip" maxlength="24" type="text" style="width:150px"/>
                                    <span class="gray" id="acl_ipTips"></span></td>
                                </tr>
                                <tr>
                                  <td id="acl_macTitle2" class="tabal_left" width="25%">Mac</td>
                                  <td class="tabal_right"><input name="acl_mac" id="acl_mac" maxlength="24" type="text" style="width:150px"/>
                                    <span class="gray" id="acl_macTips"></span></td>
                                </tr>
                                <tr>
                                  <td id="acl_vidTitle2" class="tabal_left" width="25%">Vlan ID</td>
                                  <td class="tabal_right"><input name="acl_vid" id="acl_vid" maxlength="24" type="text" style="width:150px"/>
                                    <span class="gray" id="acl_vidTips"></span></td>
                                </tr>
                              </tbody>
                            </table>
                          </div></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table>
          <table class="tabal_button" width="100%">
            <tbody>
              <tr>
                <td width="25%"></td>
                <td class="tabal_submit"><input type="submit" value="Apply" name="acl_apply" id="acl_apply" class="submit" onClick="clickApply('acl_ruleList');" />
                  <input type="reset" value="Cancel" name="acl_cancel" id="acl_cancel" class="submit" onClick="cancelRuleEdit();" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <input type="hidden" name="acl_curIndex" id="acl_curIndex" value="0">
      </td>
    </tr>
  </tbody>
</table>
</body>
</html>
