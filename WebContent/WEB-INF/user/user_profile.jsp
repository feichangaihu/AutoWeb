<%@page import="com.care.mybatis.bean.Role"%>
<%@page import="java.util.List"%>
<%@page import="com.care.config.Constant"%>
<%@page import="com.care.mybatis.bean.OpenID"%>
<%@page import="com.care.mybatis.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
<jsp:include page="/WEB-INF/head.jsp"></jsp:include>
<script type="text/javascript">
	$(function(){
		$("#btn_home").click(function (){
			location.href = "<%= request.getContextPath() %>";
		});
		
		$("#btn_save").click(function(){
			var fd = getParams($("#user_profile_form")[0]);
			var uri = "<%=request.getContextPath()%>/jaxrs/user/saveUserProfile";
			$.post(uri, fd, function(ret, status){
				console.log(ret, status);
				if(ret == 1){
					tip($("#user_profile_form_tip"), "保存成功", 1);
				}else{
					tip($("#user_profile_form_tip"), "保存失败", 0);
				}
			}, "JSON");
		});
	});
</script>
<%
	User user = (User) session.getAttribute(Constant.SESSION_USER);
	OpenID openid = (OpenID) session.getAttribute(Constant.SESSION_openID);
%>
</head>
<body>
	<div id="mainDiv">
		<form id="user_profile_form">
		<% if (openid != null){%>			
			<div>目前开放ID:<%= openid.getOpenid() %></div>
		<%}%>
			<div>完善您的资料</div>
			<div>
			 	姓名:<input type="text" name = "name" value="<%= user == null ? "" : user.getName() %>">
			</div>
			<div>
				角色: <select name="roleId">
					<%
						List<Role> allRole = (List<Role>)request.getAttribute("roles");
						for(Role role : allRole){
					%>
						<option value="<%= role.getId() %>" selected="<%= role.getId() == 15 ? "selected" : "" %>"> <%= role.getName() %> </option>
					<%
						}
					%>
				</select>
			</div>
			<div>
				邮箱:<input type="text" name="email"  value="<%=  user == null ? "" : user.getEmail() %>">
			</div>
			<%if (user == null) {%>
				<div>
					密码:<input type="password" name="password">
				</div>
			<% }%>
			<div>
				手机:<input type="text" name="phone" value="<%=  user == null ? "" : user.getPhone() %>">
			</div>
			<div>
				<input type="hidden" name="userId" value="<%= user == null ? 0 : user.getId() %>">
				<button id="btn_save" type="button">保存</button>
				<button id="btn_home" type="button">首页</button>
			</div>
		</form>
		<span id="user_profile_form_tip"></span>
	</div>
</body>
</html>