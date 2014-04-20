package com.care.wink;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Context;

import org.springframework.context.ApplicationContext;

import com.care.config.Config;
import com.care.listener.Bootstarp;
import com.care.utils.JSONUtil;

public class BaseAction {
	protected Config config;
	protected ApplicationContext ctx;

	@Context
	protected HttpServletResponse response;
	@Context
	protected HttpServletRequest request;

	public BaseAction() {
		config = Config.getInstance();
		ctx = Bootstarp.getCtx();
	}

	public Config getConfig() {
		return config;
	}

	public void setConfig(Config config) {
		this.config = config;
	}

	public ApplicationContext getCtx() {
		return ctx;
	}

	public void setCtx(ApplicationContext ctx) {
		this.ctx = ctx;
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
