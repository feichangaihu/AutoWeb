package com.care.service;

import java.util.List;

import com.care.mybatis.bean.Role;

public interface RoleService {

	public abstract List<Role> getAllRoles();

	public abstract Role getRole(int id);

}