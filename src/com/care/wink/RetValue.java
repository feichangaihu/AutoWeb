package com.care.wink;


/**
 * 自定义MessageBodyWriter
 * @autho00r gaojie
 *
 */
public class RetValue {
	private int code;
	private String action;
	private Object msg;
	public RetValue(String action) {
		super();
		this.action = action;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public Object getMsg() {
		return msg;
	}
	public void setMsg(Object msg) {
		this.msg = msg;
	}
}
