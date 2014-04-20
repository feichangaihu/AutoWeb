package com.care.wink;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Context;

import org.springframework.context.ApplicationContext;

import com.care.listener.Bootstarp;
import com.care.utils.JSONUtil;

public class BaseAction {

	@Context
	protected HttpServletResponse response;
	@Context
	protected HttpServletRequest request;

	public ApplicationContext getCtx() {
		return Bootstarp.getCtx();
	}

	 

	protected RetValue getRetValue(String action) {
		return new RetValue(action);
	}

	protected String getRetValueJson(RetValue rv) {
		return JSONUtil.toJson(rv);
	}

	protected void saveToSession(String k, Object v) {
		request.getSession().setAttribute(k, v);
	}

	protected void saveToRequest(String k, Object v) {
		request.setAttribute(k, v);
	}

	protected Object getFromSession(String k) {
		return request.getSession().getAttribute(k);
	}

	protected void deleteFromSession(String k) {
		request.getSession().removeAttribute(k);
	}

	protected void forward(String uri) throws ServletException, IOException {
		request.getRequestDispatcher(uri).forward(request, response);
	}
}
