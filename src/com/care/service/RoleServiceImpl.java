package com.care.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.mybatis.bean.UserRole;
import com.care.mybatis.dao.UserRoleMapper;

@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	private UserRoleMapper roleMapper;
	
	/* (non-Javadoc)
	 * @see com.care.service.RoleService#getAllRoles()
	 */
	@Override
	public List<UserRole> getAllRoles(){
		return roleMapper.selectByExample(null);
	}
	
	/* (non-Javadoc)
	 * @see com.care.service.RoleService#getRole(int)
	 */
	@Override
	public UserRole getRole(int id){
		return roleMapper.selectByPrimaryKey(id);
	}
}
