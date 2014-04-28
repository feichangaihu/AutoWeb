package com.care.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.mybatis.bean.UserOpenId;
import com.care.mybatis.bean.UserOpenIdExample;
import com.care.mybatis.bean.UserOpenIdExample.Criteria;
import com.care.mybatis.dao.UserOpenIdMapper;

@Service
public class UserOpenIdServiceImpl implements UserOpenIDService {
	
	@Autowired
	private UserOpenIdMapper openIDMapper;

	@Override
	public int addUpdateUserOpenId(UserOpenId openID) {
		UserOpenIdExample example = new UserOpenIdExample();
		Criteria criteria = example.createCriteria().andOpenIdEqualTo(openID.getOpenId());
		List<UserOpenId> list = openIDMapper.selectByExample(example);
		if (CollectionUtils.isEmpty(list)) {
			return openIDMapper.insertSelective(openID);
		} else {
			//criteria.andIdEqualTo(list.get(0).getId());
			return openIDMapper.updateByExampleSelective(openID, example);
		}
	}
	
	@Override
	public UserOpenId getUserOpenId(int id){
		return openIDMapper.selectByPrimaryKey(id);
	}

	@Override
	public UserOpenId getUserOpenId(String openid) {
		UserOpenIdExample example = new UserOpenIdExample();
		example.createCriteria().andOpenIdEqualTo(openid);
		List<UserOpenId> list = openIDMapper.selectByExample(example);
		if(CollectionUtils.isEmpty(list)){
			return null;
		}else{
			return list.get(0);
		}
	}
}
