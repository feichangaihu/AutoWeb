package com.care.config;

import java.io.File;
import java.util.List;

import javax.xml.bind.JAXBException;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.care.utils.XMLUtil;

/**
 * 
 * @author gaojie/joy gaojie314@gmail.com http://my.oschina.net/u/139611
 */
@XmlRootElement
public class Config {
	@XmlElement
	private static Config config;

	private static String path;
	private static String log4jConfig;
	private static String xmlConfig;

	@XmlElement(name = "oauth")
	private List<Oauth> oauths;
	private static Logger log = LoggerFactory.getLogger(Config.class);

	static {
		try {
			path = System.getProperty("configPath");
			if (path != null) {
				
				log4jConfig = path + "/log4j.properties";
				xmlConfig = path + "/config.xml";
				
				log.info("configPath:{}", path);
				log.info("log4jConfig:{}", log4jConfig);
				log.info("xmlConfig:{}", xmlConfig);

				config = XMLUtil.parseXml(new File(xmlConfig), Config.class);
			} else {
				log.error("Setting Runtime Arguments -DconfigPath Please");
				System.exit(100);
			}
		} catch (JAXBException e) {
			e.printStackTrace();
			log.error("Config init: {}", e.getLocalizedMessage());
			System.exit(100);
		}
	}

	public static Config getInstance() {
		return config;

	}

	public String getLog4jConfig() {
		return log4jConfig;
	}

	public String getXmlConfig() {
		return xmlConfig;
	}

	public String getPath() {
		return path;
	}

	public Oauth getOauth(String name) {
		for(Oauth auth : oauths){
			if(auth.getName().equals(name)){
				return auth;
			}
		}
		return  null;
	}

}
