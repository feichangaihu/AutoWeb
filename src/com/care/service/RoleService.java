package com.care.service;

import java.util.List;

import com.care.mybatis.bean.UserRole;

public interface RoleService {

	public abstract List<UserRole> getAllRoles();

	public abstract UserRole getRole(int id);

}