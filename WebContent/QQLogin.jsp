<%@page import="org.json.JSONObject"%>
<%@page import="org.codehaus.jackson.map.util.JSONPObject"%>
<%@page import="com.care.mybatis.bean.OpenID"%>
<%@page import="com.care.mybatis.bean.User"%>
<%@page import="com.care.config.Constant"%>
<%@page import="com.care.bean.qq.QQBasicUserInfo"%>
<%@page import="com.care.utils.QQUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.care.utils.JSONUtil"%>
<%@page import="com.care.listener.Bootstarp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta property="qc:admins" content="45657257476515572145637577311" />
<title><%=application.getServletContextName()%></title>

<jsp:include page="/WEB-INF/head.jsp"></jsp:include>

<script type="text/javascript">
	
	function p_login(p) {
		var url;
		if (p == 'qq') {
			url = '<%=QQUtil.getLoginURI(request).toString()%>';
		}
		//login
		var p_open = window
				.open(url,
						"TencentLogin",
						"width=550,height=450,menubar=0,scrollbars=1,resizable=1,status=1,titlebar=0,toolbar=0,location=1");
		console.dir(p_open);
	}
	$(function (){ 
		$("#btn_user_profile").click( function(e){
			location.href = "<%= request.getContextPath()+"/jaxrs/user/toUserProfile"%>";
		});
		
		$("#btn_login").click(function (){
			var fd = getParams($("#loginForm")[0]);
			
			$.post("jaxrs/user/login", fd, function (ret, status){
				console.log("Ret:", ret, status);
				if(ret.code == 1){
					//进入个人中心
					location.href="<%=request.getContextPath()+"/jaxrs/user/toUserProfile"%>";
				}else{
					//失败提示
					$("#loginForm_tip").text("登陆失败").css({ color: "#ff0011", background: "yellow" }).show().fadeOut( 2000 );
				}
			},"JSON");
		});
		
		$("#btn_logout").click(function(){
			var fd = getParams($("#loginForm")[0]);
			$.post("jaxrs/user/logout", fd, function (ret, status){
				console.log("Ret:", ret, status);
				if(ret.code == 1){
					//进入个人中心
					window.location.reload(false);
				}else{
					//失败提示
					$("#loginForm_tip").text("退出失败").css({ color: "#ff0011", background: "yellow" }).show().fadeOut( 2000 );
				}
			},"JSON");
		});
	});
</script>

</head>
<%
	User user = (User) session.getAttribute(Constant.SESSION_USER);
	OpenID openid = (OpenID) session.getAttribute(Constant.SESSION_openID);
%>
<body>
	<div id="mainDiv">
		<form id = "loginForm" action="jaxrs/user/login" method="POST">
			<div>
				<%
					if (openid != null && openid.getMeta() != null) {
						JSONObject jsonMeta = JSONUtil.formJson(openid.getMeta());
				%>
				帐号:<%=openid.getOpenid()%><br/>
				名字:<%=jsonMeta.get("nickname")%>
				<img alt="QQ头像" src="<%=jsonMeta.get("figureurl_2")%>">
				<%
					}
				%>
			</div>
			<div>
				邮 箱:<input name="email" id="email" type="text" /> <br>
			</div>
			<div>
				密 码:<input name="password" id="password" type="password" /> <br>
			</div>
			<div>
				<button type="button" id="btn_login">登陆</button>
				<button type="button" id="btn_user_profile">个人中心</button>
				<button type="button" id="btn_logout">退出</button>
			</div>
			<div>
				<img alt="QQ登陆" onclick="javascript: p_login('qq')"
					src="http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_4.png">
			</div>
		</form>
		<span id="loginForm_tip"></span>
	</div>
</body>

</html>
