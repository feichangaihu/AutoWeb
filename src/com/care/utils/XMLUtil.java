package com.care.utils;

import java.io.File;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

public class XMLUtil {
	@SuppressWarnings("unchecked")
	public static <T> T parseXml(File file, Class<T> clazz) throws JAXBException {
		JAXBContext context = JAXBContext.newInstance(clazz);
		Unmarshaller shaller = context.createUnmarshaller();
		return (T) shaller.unmarshal(file);
	}
}
