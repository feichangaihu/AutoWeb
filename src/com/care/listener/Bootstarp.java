package com.care.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

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
    /**
     * Default constructor. 
     */
    public Bootstarp() {
    	try {
			//初始化配置
			config = Config.getInstance();
			log.info("Config:{}", JSONUtil.toJson(config));
			String springXml = "file:" + config.getPath() + "/spring.xml";
			//初始化spring容器
			ctx = new FileSystemXmlApplicationContext(springXml);
			log.info("ApplicationContext:{}", ctx);
		} catch (Exception e) {
			log.error("", e);
			//System.exit(-1);
		}
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0) {
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
    }

	public static ApplicationContext getCtx() {
		return ctx;
	}

	public static Config getConfig() {
		return config;
	}
}
