package com.care.wink;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

import org.apache.wink.common.annotations.Scope;
import org.apache.wink.common.annotations.Scope.ScopeType;

import com.care.mybatis.bean.UICorpDesc;
import com.care.mybatis.dao.UICorpDescMapper;
import com.care.utils.JSONUtil;

@Path("/ui")
@Scope(ScopeType.SINGLETON)
public class UIAction extends BaseAction {
	@GET
	@Path("corpDesc")
	public String corpDesc() {
		UICorpDescMapper uiCorpDescMapper = getCtx().getBean(UICorpDescMapper.class);
		List<UICorpDesc> list = uiCorpDescMapper.selectByExample(null);
		return JSONUtil.toJson(list);

	}
}
