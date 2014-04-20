package com.care.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.mybatis.bean.Role;
import com.care.mybatis.bean.RoleExample;
import com.care.mybatis.dao.RoleMapper;

@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	private RoleMapper roleMapper;
	
	/* (non-Javadoc)
	 * @see com.care.service.RoleService#getAllRoles()
	 */
	@Override
	public List<Role> getAllRoles(){
		RoleExample example = new RoleExample();
		return roleMapper.selectByExample(example);
	}
	
	/* (non-Javadoc)
	 * @see com.care.service.RoleService#getRole(int)
	 */
	@Override
	public Role getRole(int id){
		return roleMapper.selectByPrimaryKey(id);
	}
}
