<%@page import="java.util.List"%>
<%@page import="com.care.mybatis.bean.Role"%>
<%@page import="com.care.bean.qq.QQBasicUserInfo"%>
<%@page import="com.care.config.Constant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
<jsp:include page="/WEB-INF/head.jsp"></jsp:include>

<style type="text/css">
#mainDiv {
	margin: 0 auto;
	width: 70%;
}
</style>

</head>
<%
	QQBasicUserInfo userInfo = (QQBasicUserInfo)session.getAttribute(Constant.OAUTH_QQ_SESSION_USERINFO);
%>
<body>
	<div id="mainDiv">
		<form id="redirectRegForm" action="redirectReg" method="POST">
			<span> <img alt="<%=userInfo.getNickname()%>"
				src="<%=userInfo.getFigureurl_1()%>">
			</span> <span> 您好:<%=userInfo.getNickname()%>, 请填写您的邮箱:
			</span>
			<div>
				邮箱:<input type="text" name="email" class="nn"> <span
					id="email_tip"></span>
			</div>
			<div>
				角色: <select name="roleId">
					<%
						List<Role> allRole = (List<Role>)request.getAttribute("roles");
						for(Role role : allRole ){
					%>
						<option value="<%= role.getId() %>" selected="<%= role.getId() == 15 ? "selected" : "" %>"> <%= role.getName() %> </option>
					<%
						}
					%>
				</select>
			</div>
			<div>
				<input type="hidden" name="openid" value="<%=userInfo.getOpenID()%>"> 
				密码:<input type="password" name="password" class="nn">
				<span id="password_tip"></span>
			</div>
			<div>
				<button id="btn_save" type="button">提交</button>
				<button id="btn_user_profile" type="button">继续, 稍后填写详细信息</button>
			</div>
		</form>
		<div id="form_tip"></div>
	</div>
</body>

<script type="text/javascript">
	//异步提交表单数据
	//刷新父窗口
	$("#btn_save").click(function(e) {
		//获取input,拼装成data
		var inputs = $(":input");
		var data = {};
		var valid = true;
		for (var i = 0; i < inputs.length; i++) {
			var jq_input = $(inputs[i]);
			var n = jq_input.attr("name");
			var v = jq_input.val();
			var nn = jq_input.attr("class");
			if (nn === 'nn' && $.trim(v) == '') {
				$("#" + n + "_tip").text("Not Empty").css({
					color : "#ff0011",
					background : "yellow"
				}).show().fadeOut(2000);
				valid = false;
			}
			data[n] = v;
		}

		if (valid) {
			//jQuery.post( url [, data ] [, success(data, textStatus, jqXHR) ] [, dataType ] )
			console.log("ajax:", data);
			$.post("redirectReg", data, function(ret, status) {
				console.log("Ret:", ret, status);
				if (ret.code == 1) {
					toParent();
				} else {
					$("#form_tip").text("注册失败或者用户已经存在").css({
						color : "#ff0011",
						background : "yellow"
					}).show().fadeOut(2000);
				}
			}, "JSON");
		}
	});

	$("#btn_user_profile").click(function() {
		//子窗口刷新父窗口
		window.opener.location = "toUserProfile";
		window.close();

	});
	//子窗口刷新父窗口
	function toParent() {
		window.opener.location.reload();
		window.close();
	}
</script>

</html>