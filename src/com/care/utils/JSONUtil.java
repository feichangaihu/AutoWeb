package com.care.utils;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.json.JSONObject;

/**
 * JsonUtils
 * 
 * @author gaojie/joy gaojie314@gmail.com http://my.oschina.net/u/139611
 */
public class JSONUtil {
	public static ObjectMapper mapper = new ObjectMapper();
	static {
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		//mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
	}

	/**
	 * toJson
	 * 
	 * @param obj
	 * @return
	 */
	public static String toJson(Object obj) {
		try {
			return mapper.writeValueAsString(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 将json字符串转换成对象.
	 * 
	 * @param clazz
	 * @param json
	 * @return T
	 */
	public static <T> T fromJson(Class<T> clazz, String json) {
		T obj = null;
		if (json != null) {
			try {
				obj = mapper.readValue(mapper.readTree(json), clazz);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return obj;
	}

	public static JSONObject formJson(String json) {
		try {
			return new JSONObject(json);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
