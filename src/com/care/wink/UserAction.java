package com.care.wink;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.care.bean.qq.QQBasicUserInfo;
import com.care.config.Config;
import com.care.config.Constant;
import com.care.config.Oauth;
import com.care.mybatis.bean.User;
import com.care.mybatis.bean.UserOpenId;
import com.care.service.RoleService;
import com.care.service.RoleServiceImpl;
import com.care.service.UserOpenIDService;
import com.care.service.UserOpenIdServiceImpl;
import com.care.service.UserService;
import com.care.service.UserServiceImpl;
import com.care.utils.JSONUtil;
import com.care.utils.QQUtil;

@Path("/user")
public class UserAction extends BaseAction {

	private Logger log = LoggerFactory.getLogger(UserAction.class);
	private UserService userService = getCtx().getBean(UserServiceImpl.class);
	private UserOpenIDService openIDService = getCtx().getBean(UserOpenIdServiceImpl.class);
	private RoleService roleService = getCtx().getBean(RoleServiceImpl.class);

	/**
	 * qqcallback 1: 接受QQ登陆回调 2:
	 * 请求:https://graph.qq.com/oauth2.0/token{grant_type, client_id,
	 * client_secret, code, redirect_uri} 3: 获取accessToken
	 * 
	 * @see http 
	 *      ://wiki.connect.qq.com/%E5%BC%80%E5%8F%91%E6%94%BB%E7%95%A5_server
	 *      -side#Step2.EF.BC.9A.E8.8E.B7.E5.8F.96AuthorizationCode
	 * @param code
	 * @return RetValue(JSON)
	 */
	@GET
	@Path("qq_callback")
	// @Produces(MediaType.APPLICATION_JSON)
	public void qqCallback(@QueryParam("code") String code) {
		RetValue rv = getRetValue("QQCallback");
		try {
			Oauth qqOauth = Config.getInstance().getOauth(Constant.OAUTH_QQ_NAME);
			// 请求token
			Map<String, String> accessToken = QQUtil.requestAccessToken(qqOauth, code);
			log.info("{}:requestAccessToken=>{}", rv.getAction(), accessToken);

			// 请求长时间token
			Map<String, String> longAccessToken = QQUtil.requestLongAccessToken(qqOauth, accessToken);
			log.info("{}:requestLongAccessToken=>{}", rv.getAction(), longAccessToken);

			if (longAccessToken.get("access_token") == null) {
				longAccessToken.putAll(accessToken);
			}

			// 请求openID
			Map<String, String> openIDMap = QQUtil.requestOpenID(longAccessToken);
			log.info("{}:requestOpenID=>{}", rv.getAction(), openIDMap);

			// getUserInfo
			QQBasicUserInfo userInfo = QQUtil.getUserInfo(openIDMap, longAccessToken, qqOauth);
			if (userInfo != null && userInfo.getRet() == 0) {
				userInfo.setOpenID(openIDMap.get("openid"));
				// 将openID插入数据库
				UserOpenId openID = new UserOpenId();
				openID.setMeta(JSONUtil.toJson(userInfo));
				openID.setOpenId(openIDMap.get("openid"));
				openID.setVendor(Constant.OAUTH_QQ_NAME);
				openID.setTime(new Date());
				int add = openIDService.addUpdateUserOpenId(openID);

				log.info("Add openID:{} Table=>{}", openID, add);
				saveToSession(Constant.SESSION_openID, openID);

				// save userInfo to session
				saveToSession(Constant.OAUTH_QQ_SESSION_USERINFO, userInfo);

				// Cookie
				longAccessToken.put("nickname", userInfo.getNickname());
				longAccessToken.put("figureurl", userInfo.getFigureurl());
				longAccessToken.putAll(openIDMap);
				for (Map.Entry<String, String> entry : longAccessToken.entrySet()) {
					Cookie cookie = new Cookie(entry.getKey(), entry.getValue());
					cookie.setPath(request.getContextPath());
					// 设置cookie时间和qq token一样
					cookie.setMaxAge(Integer.parseInt(longAccessToken.get("expires_in") == null ? "60*24*3600" : longAccessToken
							.get("expires_in")));
					try {
						// 写入cookie
						response.addCookie(cookie);
					} catch (Exception e) {
						log.warn("addCookie({}:{}):{}", cookie.getName(), cookie.getValue(), e.getMessage());
					}
				}

				// role
				saveToRequest("roles", roleService.getAllRoles());
				forward("/WEB-INF/redirect.jsp");

				rv.setCode(1);
				rv.setMsg(userInfo);
			} else {
				rv.setCode(0);
				rv.setMsg("认证失败");
			}

		} catch (Exception e) {
			log.error("{}", rv.getAction(), e);
			rv.setCode(-1);
			rv.setMsg(e.fillInStackTrace().toString());
		}
		// return getRetValueJson(rv);
	}

	@POST
	@Path("redirectReg")
	@Produces(MediaType.APPLICATION_JSON)
	public String redirectReg(@FormParam("email") String email, @FormParam("password") String password, @FormParam("openid") String openid,
			@FormParam("role") int roleId) {
		RetValue rv = getRetValue("redirectReg");
		try {
			log.debug("{}:{}", rv.getAction(), email);
			User user = new User();
			user.setEmail(email);
			user.setPassword(password);
			user.setRoleId(roleId);
			// openid
			if (openid != null) {
				UserOpenId openID = openIDService.getUserOpenId(openid);
				if (openID == null) {
					openIDService.addUpdateUserOpenId(openID);
				} else {
					user.setOpenId(openid);
				}
			}

			int addUser = userService.addUser(user);
			if (addUser > 0) {
				log.info("Add User({})=>{}", user.getEmail(), addUser);
				rv.setCode(1);
				rv.setMsg("Add user sucess");
			} else {
				rv.setCode(0);
				rv.setMsg("Add user failed");
			}
		} catch (Exception e) {
			log.error("{}", rv.getAction(), e);
			rv.setCode(-1);
			rv.setMsg(e.getMessage());
		}
		return getRetValueJson(rv);
	}

	@POST
	@Path("login")
	@Produces(MediaType.APPLICATION_JSON)
	public String login(@FormParam("key") String key, @FormParam("password") String password) {
		RetValue rv = getRetValue("login");
		try {
			log.debug("{}:key:{} password:{}", rv.getAction(), key, password);
			User user = userService.login(key, password);
			if (user != null) {
				saveToSession(Constant.SESSION_USER, user);
				rv.setCode(1);
				rv.setMsg("login sucess");

				if (user.getOpenId() != null) {
					// openID
					UserOpenId openID = openIDService.getUserOpenId(user.getOpenId());
					if (openID != null) {
						saveToSession(Constant.SESSION_openID, openID);
					}
				}
				// response.sendRedirect("/wsyy");
			} else {
				rv.setCode(0);
				rv.setMsg("login failed");
			}
		} catch (Exception e) {
			rv.setCode(-1);
			rv.setMsg(e.getMessage());
			log.error("login", e);
		}
		return getRetValueJson(rv);
	}

	@POST
	@Path("logout")
	public String logout(@FormParam("email") String email, @FormParam("password") String password) {
		RetValue rv = getRetValue("logout");
		try {
			log.info("{}:email:{} password:{}", rv.getAction(), email, password);
			deleteFromSession(Constant.SESSION_openID);
			deleteFromSession(Constant.SESSION_USER);
			rv.setCode(1);
			rv.setMsg("success");
		} catch (Exception e) {
			rv.setCode(-1);
			rv.setMsg(e.getMessage());
		}
		return getRetValueJson(rv);
	}

	@GET
	@Path("toUserProfile")
	public void toUserProfile() {
		try {
			// 获取角色
			saveToRequest("roles", roleService.getAllRoles());
			forward("/WEB-INF/user/user_profile.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("toUserProfile", e);
		}
	}

	@POST
	@Path("saveUserProfile")
	public String saveUserProfile(@FormParam("userId") int id, @FormParam("email") String email, @FormParam("name") String name,
			@FormParam("phone") String phone, @FormParam("password") String password, @FormParam("roleId") int roleId) {
		RetValue rv = getRetValue("saveUserProfile");
		log.info("saveUserProfile:{} {}", email, name);
		try {
			User user = new User();
			user.setName(name);
			user.setPhone(phone);
			user.setRoleId(roleId);
			user.setEmail(email);
			user.setId(id);
			user.setPassword(password);
			int i = id == 0 ? userService.saveUser(user) : userService.updateUser(user);
			if (i == 1) {
				rv.setCode(1);
				rv.setMsg("success");
			} else {
				rv.setCode(0);
				rv.setMsg("failed");
			}
		} catch (Exception e) {
			rv.setCode(-1);
			rv.setMsg(e.getMessage());
			log.error(rv.getAction(), e);
		}
		return getRetValueJson(rv);

	}

}
