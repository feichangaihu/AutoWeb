package com.care.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.mybatis.bean.OpenID;
import com.care.mybatis.bean.OpenIDExample;
import com.care.mybatis.bean.OpenIDExample.Criteria;
import com.care.mybatis.dao.OpenIDMapper;

@Service
public class OpenIDServiceImpl implements OpenIDService {
	
	@Autowired
	private OpenIDMapper openIDMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.care.service.OpenIDService#addOpenID(com.care.mybatis.bean.OpenID)
	 */
	@Override
	public int addUpdateOpenID(OpenID openID) {
		OpenIDExample example = new OpenIDExample();
		Criteria criteria = example.createCriteria().andOpenidEqualTo(openID.getOpenid());
		List<OpenID> list = openIDMapper.selectByExample(example);
		if (CollectionUtils.isEmpty(list)) {
			return openIDMapper.insertSelective(openID);
		} else {
			//criteria.andIdEqualTo(list.get(0).getId());
			return openIDMapper.updateByExampleSelective(openID, example);
		}
	}
	
	@Override
	public OpenID getOpenID(int id){
		return openIDMapper.selectByPrimaryKey(id);
	}

	@Override
	public OpenID getOpenID(String openid) {
		OpenIDExample example = new OpenIDExample();
		example.createCriteria().andOpenidEqualTo(openid);
		List<OpenID> list = openIDMapper.selectByExample(example);
		if(CollectionUtils.isEmpty(list)){
			return null;
		}else{
			return list.get(0);
		}
	}
}
