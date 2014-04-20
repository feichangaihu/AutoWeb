package com.care.utils;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.care.bean.qq.QQBasicUserInfo;
import com.care.config.Config;
import com.care.config.Constant;
import com.care.config.Oauth;
import com.care.wink.UserAction;

public class QQUtil {
	private static Logger log = LoggerFactory.getLogger(UserAction.class);

	/**
	 * 获取QQ登陆的URI
	 * @param request
	 * @return	https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100534907&redirect_uri=<%=qqCallback%>&scope=
	 */
	public static URI getLoginURI(HttpServletRequest request) {

		/**
		 * href=
		 * "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100534907&redirect_uri=<%=qqCallback%>&scope="
		 * > <img alt="" src=
		 * "http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_4.png"
		 * >
		 */
		URI buildURI = null;
		try {
			String baseURI = "https://graph.qq.com/oauth2.0/authorize";
			Map<String, String> args = new HashMap<String, String>();
			Oauth oauth = Config.getInstance().getOauth(Constant.OAUTH_QQ_NAME);
			args.put("client_id", oauth.getAppid());
			args.put("response_type", "code");
			args.put("redirect_uri", oauth.getCallbackUrl());
			buildURI = HttpUtil.buildURI(baseURI, args);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return buildURI;

	}

	/**
	 * requestAccessToken
	 * 
	 * @url https://graph.qq.com/oauth2.0/token
	 * @grant_type 必须 授权类型，在本步骤中，此值为“authorization_code”。
	 * @client_id 必须 申请QQ登录成功后，分配给网站的appid。
	 * @client_secret 必须 申请QQ登录成功后，分配给网站的appkey。
	 * @code 必须 上一步返回的authorization code。
	 *       如果用户成功登录并授权，则会跳转到指定的回调地址，并在URL中带上Authorization Code。
	 *       例如，回调地址为www.qq.com/my.php，则跳转到：
	 *       http://www.qq.com/my.php?code=520DD95263C1CFEA087******
	 *       注意此code会在10分钟内过期。 redirect_uri 必须 与上面一步中传入的redirect_uri保持一致。
	 * 
	 * @param qqOauth
	 * @param authCode
	 * @return
	 */
	public static Map<String, String> requestAccessToken(Oauth qqOauth, String authCode) {
		Map<String, String> retMap = null;

		Map<String, String> args = new HashMap<String, String>();
		args.put("grant_type", "authorization_code");
		args.put("client_id", qqOauth.getAppid());
		args.put("client_secret", qqOauth.getAppkey());
		args.put("redirect_uri", qqOauth.getCallbackUrl());
		args.put("code", authCode);
		URI uri;
		try {
			uri = HttpUtil.buildURI("https://graph.qq.com/oauth2.0/token", args);
			retMap = requestQQGet(uri);
		} catch (URISyntaxException e) {
		}
		return retMap;
	}

	/**
	 * 获取3个月的token
	 * 
	 * @url https://graph.qq.com/oauth2.0/token
	 * @grant_type 必须 授权类型，在本步骤中，此值为“refresh_token”。
	 * @client_id 必须 申请QQ登录成功后，分配给网站的appid。
	 * @client_secret 必须 申请QQ登录成功后，分配给网站的appkey。
	 * @refresh_token 必须 在Step2中，返回的refres_token。
	 * @return
	 */
	public static Map<String, String> requestLongAccessToken(Oauth qqOauth, Map<String, String> accessToken) {
		Map<String, String> retMap = null;

		Map<String, String> args = new HashMap<String, String>();
		args.put("grant_type", "refresh_token");
		args.put("client_id", qqOauth.getAppid());
		args.put("client_secret", qqOauth.getAppkey());
		args.putAll(accessToken);

		try {
			URI uri = HttpUtil.buildURI("https://graph.qq.com/oauth2.0/token", args);
			retMap = requestQQGet(uri);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return retMap;
	}

	public static Map<String, String> requestQQGet(URI uri) {
		Map<String, String> retMap = new HashMap<String, String>();
		String[] ret;
		try {
			ret = HttpUtil.requestGet(uri, Constant.TIMEOUT);
			log.info("requestGet:{}=>{}", uri, JSONUtil.toJson(ret));
			retMap.put("httpCode", ret[0]);
			if (ret[0].equals("200")) {
				String[] itemArrays = ret[1].split("&");
				if (itemArrays.length > 0) {
					for (String item : itemArrays) {
						String[] kv = item.split("=");
						if (kv.length > 1) {
							retMap.put(kv[0], kv[1]);
						}
					}
				}
			} else {
				log.error(JSONUtil.toJson(ret));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}

	/**
	 * 获取openID
	 * 
	 * @param requestLongAccessToken
	 * @return
	 */
	public static Map<String, String> requestOpenID(Map<String, String> requestLongAccessToken) {
		// https://graph.qq.com/oauth2.0/me?{access_token}
		Map<String, String> retMap = new HashMap<String, String>();
		try {
			URI uri = HttpUtil.buildURI("https://graph.qq.com/oauth2.0/me", requestLongAccessToken);
			log.info("requestOpenID:{}", uri);
			String[] requestGet = HttpUtil.requestGet(uri, Constant.TIMEOUT);
			retMap.put("httpCode", requestGet[0]);
			if (requestGet[0].equals("200")) {
				// callback( {"client_id":"YOUR_APPID","openid":"YOUR_OPENID"}
				// );
				String _json = requestGet[1].replaceFirst("callback\\s*\\(", "").replace(");", "");
				JSONObject json = new JSONObject(_json);
				Iterator keys = json.keys();
				while (keys.hasNext()) {
					String key = keys.next().toString();
					retMap.put(key, json.get(key).toString());
				}
			} else {
				log.error(JSONUtil.toJson(requestGet));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}

	/**
	 * getUserInfo
	 * 
	 * @param openID
	 * @param requestLongAccessToken
	 * @param oauth
	 * @return
	 */
	public static QQBasicUserInfo getUserInfo(Map<String, String> openID, Map<String, String> requestLongAccessToken, Oauth oauth) {
		/**
		 * https://graph.qq.com/user/get_user_info?access_token=
		 * YOUR_ACCESS_TOKEN&oauth_consumer_key=YOUR_APP_ID&openid=YOUR_OPENID
		 */
		QQBasicUserInfo info = null;
		try {
			openID.put("oauth_consumer_key", oauth.getAppid());
			openID.putAll(requestLongAccessToken);
			URI uri = HttpUtil.buildURI("https://graph.qq.com/user/get_user_info", openID);
			String[] response = HttpUtil.requestGet(uri, Constant.TIMEOUT);
			log.info("getUserInfo:{}=>{}", uri, JSONUtil.toJson(response));
			if (response[0].equals("200")) {
				info = JSONUtil.fromJson(QQBasicUserInfo.class, response[1]);
			} else {
				log.error("getUserInfo:{}=>{}", uri, JSONUtil.toJson(response));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;

	}
}
