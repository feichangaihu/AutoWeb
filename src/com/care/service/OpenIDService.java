package com.care.service;

import com.care.mybatis.bean.OpenID;

public interface OpenIDService {

	public abstract int addUpdateOpenID(OpenID openID);

	OpenID getOpenID(int id);

	OpenID getOpenID(String openid);

}