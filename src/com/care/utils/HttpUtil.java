package com.care.utils;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class HttpUtil {

	public static URI buildURI(String baseURI, Map<String, String> args) throws URISyntaxException {
		URIBuilder builder = new URIBuilder(baseURI);
		if(args != null){
			for (Map.Entry<String, String> entry : args.entrySet()) {
				builder.setParameter(entry.getKey(), entry.getValue());
			}
		}
		return builder.build();
	}

	/**
	 * 请求URI GET
	 * 
	 * @param uri
	 * @param timeout
	 * @return String[] 0:StatusCode 1:Msg
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public static String[] requestGet(URI uri, int timeout) throws ClientProtocolException, IOException {
		HttpGet httpget = new HttpGet(uri);
		RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(timeout).setConnectTimeout(timeout).setConnectionRequestTimeout(timeout).build();
		httpget.setConfig(requestConfig);
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpClientContext context = HttpClientContext.create();
		CloseableHttpResponse response = httpclient.execute(httpget, context);
		String[] ret = new String[] { response.getStatusLine().getStatusCode() + "", EntityUtils.toString(response.getEntity()) };
		return ret;
	}
}
