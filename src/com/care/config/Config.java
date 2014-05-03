package com.care.config;

import java.io.File;
import java.io.Serializable;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import javax.xml.bind.JAXBException;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.logging.log4j.core.helpers.FileUtils;

import com.care.utils.HttpUtil;
import com.care.utils.XMLUtil;

/**
 * 
 * @author gaojie/joy gaojie314@gmail.com http://my.oschina.net/u/139611
 */
@XmlRootElement
public class Config {
	public static final String FILE_NAME = "config.xml";
	private static Config instance;
	public List<Oauth> getOauths() {
		return oauths;
	}

	@XmlElement(name = "oauth")
	private List<Oauth> oauths;

	public static void refresh(URI confBaseURI) {
		File xmlFile = null;
		try {
			xmlFile = FileUtils.fileFromURI(confBaseURI);
			instance = XMLUtil.parseXml(xmlFile, Config.class);
		} catch (JAXBException e) {
			System.err.printf("%s: 解析出错!\n", xmlFile.toString());
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(100);
		} finally {
			if (instance == null)
				System.exit(1);
		}
	}

	public static Config getInstance(URI confURI) throws URISyntaxException {
		refresh(confURI);
		return instance;
	}

	public static Config getInstance() {
		return instance;
	}

	public Oauth getOauth(String name) {
		for (Oauth auth : oauths) {
			if (auth.getName().equals(name)) {
				return auth;
			}
		}
		return null;
	}

}
