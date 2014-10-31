<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.eazytec.common.util.ConstWords"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.eazytec.web.controller.dwr.DwrSysProcessService"%>
<%@page import="com.eazytec.core.pojo.SysConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>服务条款</title>
<%
String path = request.getContextPath();
WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
DwrSysProcessService service = (DwrSysProcessService)context.getBean("dwrSysProcessService");
String ptname = "企业管理平台";
SysConfig indexconfing = service.getSysconfigByCode(ConstWords.getProjectCode());
if(indexconfing!=null){
	ptname = indexconfing.getProjectName();
}
 %>
 <link rel='Shortcut Icon' href='<%=path %>/favicon.ico' />
<link rel='Bookmark' href='<%=path %>/favicon.ico' />
<link rel='stylesheet' type='text/css' href='<%=path %>/css/normal.css' />
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="750" align="center" height="60">
<tr height="60">
<td width="110">
<img src="<%=path %>/images/login_title.png" border="0" height="45"/>
</td>
<td align="left"><font face="幼圆" style="font-size:22px;"  color="#666666"><strong><%=ptname %></strong></font></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="750" align="center">
<tr>
<td valign="top">
<div style="height: 100%;border: 1px solid #c1c1c1;text-align: left;">
	<div style="color: green;font-size: 14px;margin: 20px;text-align: left;"><strong>服务条款</strong></div>
	<div style="margin: 20px;overflow: auto;border: 1px solid #d1d1d1;height: 360px;">
<div style="text-justify: inter-ideograph; line-height: 15pt;text-align: center;"><strong><span style="font-size: 10.5pt; color: #404040">卓易科技服务条款</span></strong><span style="font-size: 9pt; color: #404040"><br />
</span><span style="font-size: 9pt; color: #404040">最后更新时间：</span><span style="font-size: 9pt; color: #404040">2010</span><span style="font-size: 9pt; color: #404040">年</span><span style="font-size: 9pt; color: #404040">5</span><span style="font-size: 9pt; color: #404040">月</span><span style="font-size: 9pt; color: #404040">7</span><span style="font-size: 9pt; color: #404040">日</span></div>
<br/>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　【注意】请用户仔细阅读以下全部内容<strong><u>（特别是粗体下划线标注的内容）</u></strong>。如用户不同意本服务条款任意内容，请不要使用卓易科技相关服务。如用户通过进入注册程序并勾选</span><span style="font-size: 9pt; color: #404040">&ldquo;</span><span style="font-size: 9pt; color: #404040">我同意卓易科技服务条款</span><span style="font-size: 9pt; color: #404040">&rdquo;</span><span style="font-size: 9pt; color: #404040">，即表示用户与江苏卓易信息科技有限公司已达成协议，自愿接受本服务条款的所有内容。此后，用户不得以未阅读本服务条款内容作任何形式的抗辩。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　1</span><span style="font-size: 9pt; color: #404040">、服务条款的确认和接纳</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　卓易科技服务涉及到的卓易科技产品的所有权以及相关软件的知识产权归江苏卓易信息科技有限公司所有。江苏卓易信息科技有限公司所提供的服务必须按照其发布的公司章程，服务条款和操作规则严格执行。本服务条款的效力范围及于江苏卓易信息科技有限公司的一切产品和服务，用户在享受江苏卓易信息科技有限公司任何单项服务时，应当受本服务条款的约束。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　当用户使用卓易科技各单项服务时，用户的使用行为视为其对该单项服务的服务条款以及江苏卓易信息科技有限公司在该单项服务中发出的各类公告的同意。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　2</span><span style="font-size: 9pt; color: #404040">、卓易科技通行证与服务简介</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<b><u>本服务条款所指的</u></b></span><b><u><span style="font-size: 9pt; color: #404040">&ldquo;</span></u></b><b><u><span style="font-size: 9pt; color: #404040">卓易科技通行证</span></u></b><b><u><span style="font-size: 9pt; color: #404040">&rdquo;</span></u></b><b><u><span style="font-size: 9pt; color: #404040">包括为公司提供的用户名和密码。</span></u></b></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　江苏卓易信息科技有限公司运用自己的操作系统通过国际互联网络为用户提供各项服务。用户必须：</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　（</span><span style="font-size: 9pt; color: #404040">1</span><span style="font-size: 9pt; color: #404040">）提供设备，如个人电脑、手机或其他上网设备。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　（</span><span style="font-size: 9pt; color: #404040">2</span><span style="font-size: 9pt; color: #404040">）个人上网和支付与此服务有关的费用。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><b><span style="font-size: 9pt; color: #404040">　　3</span></b><b><u><span style="font-size: 9pt; color: #404040">、服务条款的修改</span></u></b></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<b><u>江苏卓易信息科技有限公司有权在必要时通过在网页上发出公告等合理方式修改本服务条款以及各单项服务的相关条款。用户在享受各项服务时，应当及时查阅了解修改的内容，并自觉遵守本服务条款以及该单项服务的相关条款。用户如继续使用本服务条款涉及的服务，则视为对修改内容的同意；用户在不同意修改内容的情况下，有权停止使用本服务条款涉及的服务。</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><strong><span style="font-size: 9pt; color: #404040">　　4</span></strong><strong><u><span style="font-size: 9pt; color: #404040">、用户隐私制度</span></u></strong></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<strong><u>用户知悉并同意，为便于向用户提供更好的服务，网江苏卓易信息科技有限公司将在用户自愿选择服务或者提供信息的情况下收集用户的个人信息，并将这些信息进行整合。在用户使用江苏卓易信息科技有限公司服务时，服务器会自动记录一些信息，包括但不限于</u></strong></span><strong><u><span style="font-size: 9pt; color: #404040">URL</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">、</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">IP</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">地址、浏览器类型、使用语言、访问日期和时间，等。为方便用户登录或使用江苏卓易信息科技有限公司的服务，江苏卓易信息科技有限公司在有需要时将使用</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">cookies</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">等技术，并将收集到的信息发送到对应的服务器。用户可以选择接受或者拒绝</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">cookies</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">。如用户选择拒绝</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">cookies</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">，则用户有可能无法登陆或使用依赖于</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">cookies</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">的服务或者功能。江苏卓易信息科技有限公司收集的信息将成为江苏卓易信息科技有限公司常规商业档案的一部分，且有可能因为转让、合并、收购、重组等原因而被转移到江苏卓易信息科技有限公司的继任公司或者指定的一方。江苏卓易信息科技有限公司同意善意使用收集的信息，且采取各项措施保证信息安全。</span></u></strong></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040"></span><strong>　　</strong><strong><u><span style="font-size: 9pt; color: #404040">尊重用户个人隐私是江苏卓易信息科技有限公司的一项基本政策。所以，作为对以上第</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">2</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">条个人注册资料分析的补充，江苏卓易信息科技有限公司不会公开或透露用户的注册资料及保存在卓易科技各项服务中的非公开内容，除非江苏卓易信息科技有限公司在诚信的基础上认为透露这些信息在以下几种情况是必要的：</span></u></strong></div>
<div style="text-justify: inter-ideograph; text-indent: 17.7pt; line-height: 15pt"><strong><u><span style="font-size: 9pt; color: #404040">（</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">1</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">）遵守有关法律规定，包括在国家有关机关查询时，提供用户的注册信息、用户在卓易科技有限的网页上发布的信息内容及其发布时间、互联网地址或者域名。</span></u></strong></div>
<div style="text-justify: inter-ideograph; text-indent: 17.6pt; line-height: 15pt"><strong><u><span style="font-size: 9pt; color: #404040">（</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">2</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">）保持维护卓易科技的知识产权和其他重要权利。</span></u></strong></div>
<div style="text-justify: inter-ideograph; text-indent: 17.7pt; line-height: 15pt"><strong><u><span style="font-size: 9pt; color: #404040">（</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">3</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">）在紧急情况下竭力维护用户个人和社会大众的隐私安全。</span></u></strong></div>
<div style="text-justify: inter-ideograph; text-indent: 17.7pt; line-height: 15pt"><strong><u><span style="font-size: 9pt; color: #404040">（</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">4</span></u></strong><strong><u><span style="font-size: 9pt; color: #404040">）根据本条款相关规定或者卓易科技认为必要的其他情况下。</span></u></strong></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　5</span><span style="font-size: 9pt; color: #404040">、用户的帐号、密码和安全性</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　用户一旦注册成功成为用户，将得到一个密码和帐号。如果用户未保管好自己的帐号和密码而对用户、江苏卓易信息科技有限公司或第三方造成的损害，用户将负全部责任。另外，每个用户都要对其帐户中的所有活动和事件负全责。用户不可随意改变用户的密码。用户同意若发现任何非法使用用户帐号或安全漏洞的情况，有义务立即通告江苏卓易信息科技有限公司。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><b><span style="font-size: 9pt; color: #404040">　　6</span></b><b><u><span style="font-size: 9pt; color: #404040">、拒绝提供担保和免责声明</span></u></b></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<b><u>用户明确同意使用卓易科技服务的风险由用户个人承担。江苏卓易信息科技有限公司的通行证帐号与服务以</u></b></span><b><u><span style="font-size: 9pt; color: #404040">&ldquo;</span></u></b><b><u><span style="font-size: 9pt; color: #404040">现有</span></u></b><b><u><span style="font-size: 9pt; color: #404040">&rdquo;</span></u></b><b><u><span style="font-size: 9pt; color: #404040">的状态提供给用户，江苏卓易信息科技有限公司明确表示不提供任何类型的担保，不论是明确的或隐含的。江苏卓易信息科技有限公司不担保服务一定能满足用户的要求，也不担保服务不会受中断，江苏卓易信息科技有限公司对服务的及时性、安全性、真实性、出错发生都不作担保。江苏卓易信息科技有限公司拒绝提供任何担保，包括信息能否准确、及时、顺利地传送。用户理解并接受下载或通过卓易科技产品服务取得的任何信息资料取决于用户自己，并由其承担系统受损、资料丢失以及其它任何风险。</span></u></b></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><b><span style="font-size: 9pt; color: #404040">　　7</span></b><b><u><span style="font-size: 9pt; color: #404040">、免责条款</span></u></b></div>
<div style="text-justify: inter-ideograph; text-indent: 17.7pt; line-height: 15pt"><b><u><span style="font-size: 9pt; color: #404040">江苏卓易信息科技有限公司对直接、间接、偶然、特殊及继起的损害不负责任，这些损害来自：不正当使用产品服务，在网上购买商品或类似服务，在网上进行交易，非法使用服务或用户传送的信息有所变动。这些损害会导致江苏卓易信息科技有限公司形象受损，所以江苏卓易信息科技有限公司早已提出这种损害的可能性。</span></u></b><b><u><span style="font-size: 9pt; color: #404040"> <br />
</span></u></b><span style="font-size: 9pt; color: #404040"><br />
</span><span style="font-size: 9pt; color: #404040">　　<b><u>江苏卓易信息科技有限公司对本项服务下涉及的境内外基础电信运营商的移动通信网络的故障、技术缺陷、覆盖范围限制、不可抗力、计算机病毒、黑客攻击、用户所在位置、用户关机或其他非卓易科技技术能力范围内的事因等造成的服务中断、用户发送的短信息的内容丢失、出现乱码、错误接收、无法接收、迟延接收不承担责任。</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　8</span><span style="font-size: 9pt; color: #404040">、保障</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　用户同意保障和维护江苏卓易信息科技有限公司全体成员的利益，负责支付由用户使用超出服务范围引起的律师费用，违反服务条款的损害补偿费用，其它人使用用户的电脑、帐号而产生的费用。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　9</span><span style="font-size: 9pt; color: #404040">、通知</span></div>
<div style="text-justify: inter-ideograph; text-indent: 18pt; line-height: 15pt"><span style="font-size: 9pt; color: #404040">所有发给用户的通知都可通过电子邮件、常规的信件方式进行传送。江苏卓易信息科技有限公司将通过上述方法之一将消息传递给用户，告知他们服务条款的修改、服务变更、或其它重要事情。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　10</span><span style="font-size: 9pt; color: #404040">、内容的所有权</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　内容的定义包括：文字、软件、声音、相片、视频、图表；电子邮件系统的全部内容；卓易科技服务为用户提供的商业信息。所有这些内容均属于江苏卓易信息科技有限公司，并受版权、商标、专利和其它财产所有权法律的保护。所以，用户只能在江苏卓易信息科技有限公司授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　11</span><span style="font-size: 9pt; color: #404040">、<b><u>法律</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<b><u>本条款适用中华人民共和国的法律，并且排除一切冲突法规定的适用。</u></b></span><span style="font-size: 9pt; color: #404040"><br />
</span><span style="font-size: 9pt; color: #404040">　　<b><u>如出现纠纷，用户和江苏卓易信息科技有限公司一致同意将纠纷交由人民法院管辖。</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><b><span style="font-size: 9pt; color: #404040">　　12</span></b><b><u><span style="font-size: 9pt; color: #404040">、信息储存及相关知识产权</span></u></b></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<b><u>江苏卓易信息科技有限公司对通行证上所有服务将尽力维护其安全性及方便性，但对服务中出现的信息（包括但不限于用户发布的信息）删除或储存失败不承担任何责任。另外江苏卓易信息科技有限公司保留判定用户的行为是否符合本服务条款的要求的权利，如果用户违背了本服务条款的规定，江苏卓易信息科技有限公司有权中止或者终止对其卓易科技帐号的服务。</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><b><span style="font-size: 9pt; color: #404040">　　13</span></b><b><u><span style="font-size: 9pt; color: #404040">、卓易科技通行证帐号的有效期</span></u></b></div>
<div style="text-justify: inter-ideograph; margin-bottom: 12pt; text-indent: 17.7pt; line-height: 15pt"><b><u><span style="font-size: 9pt; color: #404040">用户的帐号密码使用时限和购买江苏卓易信息科技有限公司相关服务一致。</span></u></b><b><u><span style="font-size: 9pt; color: #404040"><br />
</span></u></b><span style="font-size: 9pt; color: #404040"><br />
</span><span style="font-size: 9pt; color: #404040">　　<b><u>用户同意，与帐号相关的一切资料、数据和记录以江苏卓易信息科技有限公司的系统数据为准。</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　14</span><span style="font-size: 9pt; color: #404040">、权利声明</span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　江苏卓易信息科技有限公司不行使、未能及时行使或者未充分行使本条款或者按照法律规定所享有的权利，不应被视为放弃该权利，也不影响江苏卓易信息科技有限公司在将来行使该权利。</span><span style="font-size: 9pt; color: #404040"><br />
<br />
</span><span style="font-size: 9pt; color: #404040">　　<b><u>在法律允许的最大范围内，江苏卓易信息科技有限公司保留对本服务条款的最终解释权。</u></b></span></div>
<div style="text-justify: inter-ideograph; line-height: 15pt"><span style="font-size: 9pt; color: #404040">　　<b><u>如用户对本条款内容有任何疑问，可拨打客服电话（</u></b></span><b><u><span style="font-size: 9pt; color: #404040">0510-80322888</span></u></b><b><u><span style="font-size: 9pt; color: #404040">）或登录帮助中心（</span></u></b><b><u><span style="font-size: 9pt; color: #404040"><a target="_blank" href="http://www.eazytec.com"><u><span style="color: red">http://www.eazytec.com</span></u><u><span style="color: windowtext">）</span></u></a></span></u></b><b><u><span style="font-size: 9pt; color: #404040">进行查询。</span></u></b></div>
	</div>
</div>
</td>
</tr>
</table>
<br/>
	<center>
	<input type="button" onclick="window.close();" value="关 闭"/>
	</center>
</body>
</html>