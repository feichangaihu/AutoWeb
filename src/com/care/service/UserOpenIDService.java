package com.care.service;

import com.care.mybatis.bean.UserOpenId;

public interface UserOpenIDService {


	int addUpdateUserOpenId(UserOpenId openID);

	UserOpenId getUserOpenId(int id);

	UserOpenId getUserOpenId(String openid);

}