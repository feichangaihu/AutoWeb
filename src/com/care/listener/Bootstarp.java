package com.care.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.care.config.Config;
import com.care.utils.JSONUtil;

/**
 * Application Lifecycle Listener implementation class Bootstarp
 * 
 */
@WebListener
public class Bootstarp implements ServletContextListener {
	private Logger log = LoggerFactory.getLogger(getClass());
	private static ApplicationContext ctx;
	private static Config config;

	public void contextInitialized(ServletContextEvent event) {
		try {
			// -DconfigPath
			Thread.currentThread().setPriority(Thread.MAX_PRIORITY);
			String confBaseURI = System.getProperty("confURI", event.getServletContext().getInitParameter("confURI"));
			if (StringUtils.isEmpty(confBaseURI)) {
				confBaseURI = System.getProperty("user.dir") + "/config";
			}
			log.info("Loading conf:{}", confBaseURI);
			// 初始化配置
			config = Config.getInstance(confBaseURI);
			log.info("Config:{}", JSONUtil.toJson(config));
			String springXml = "file:" + confBaseURI + "/spring.xml";
			// 初始化spring容器
			ctx = new FileSystemXmlApplicationContext(springXml);
			log.info("ApplicationContext:{}", JSONUtil.toJson(ctx.getBeanDefinitionNames()));
		} catch (Exception e) {
			log.error("contextInitialized", e);
			System.exit(-1);
		}
	}

	public void contextDestroyed(ServletContextEvent arg0) {
	}

	public static ApplicationContext getCtx() {
		return ctx;
	}

	public static Config getConfig() {
		return config;
	}
}
