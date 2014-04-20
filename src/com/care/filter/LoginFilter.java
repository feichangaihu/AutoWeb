package com.care.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.care.config.Config;
import com.care.config.Constant;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(description = "登陆校验过滤器", urlPatterns = { "jaxrs/*" })
public class LoginFilter implements Filter {
	private static Logger log = LoggerFactory.getLogger(Config.class);
    /**
     * Default constructor. 
     */
    public LoginFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req , ServletResponse resp , FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
	
		//用户没有登陆, 并且访问的不是登陆页, 定向到首页
		Object user = request.getSession().getAttribute(Constant.SESSION_USER);
		Object qqUser = request.getSession().getAttribute(Constant.OAUTH_QQ_SESSION_USERINFO);
		if(user == null && qqUser == null && request.getRequestURI().contains("jaxrs") && !request.getRequestURI().contains("qq_callback")){
			log.info("{} Redirect To:{}", request.getRequestURI(), request.getContextPath());
			response.sendRedirect(request.getContextPath());
			return;
		}
		
		chain.doFilter(request , response );
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
