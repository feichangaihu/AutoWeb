package com.care.service;

import com.care.mybatis.bean.User;

public interface UserService {

	public abstract User getUserById(int id);

	public abstract int addUser(User user);
	public abstract int saveUpdateUser(User user);
	User login(String email, String password);

	int saveUser(User user);

	int updateUser(User user);

}