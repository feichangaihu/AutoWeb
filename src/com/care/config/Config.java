package com.care.config;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import javax.xml.bind.JAXBException;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.care.utils.HttpUtil;
import com.care.utils.XMLUtil;

/**
 * 
 * @author gaojie/joy gaojie314@gmail.com http://my.oschina.net/u/139611
 */
@XmlRootElement
public class Config {
	private static final String name = "config.xml";
	private static Config instance;
	private static URI confBaseURI;
	
	@XmlElement
	private static Config config;

	@XmlElement(name = "oauth")
	private List<Oauth> oauths;

	
	

	public static void refresh(URI confBaseURI) {
		File xmlFile = null;
		try {
			xmlFile = new File(confBaseURI.toString(), name);
			instance = XMLUtil.parseXml(xmlFile, Config.class);
		} catch (JAXBException e) {
			System.err.printf("%s: 解析出错!\n", xmlFile.toURI());
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(100);
		} finally {
			if (instance == null)
				System.exit(1);
		}
	}

	public static Config getInstance(String baseURI) throws URISyntaxException {
		confBaseURI = HttpUtil.buildURI(baseURI, null);
		refresh(confBaseURI);
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
