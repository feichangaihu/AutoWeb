<%@page import="java.lang.Thread.State"%>
<%@page import="java.lang.management.ThreadMXBean"%>
<%@page language="java" import="java.text.*, java.util.* , java.util.*, java.lang.management.*" pageEncoding="gbk"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="refresh" content="30">
<title> Session </title>
</head>
<body>
	<%!
		RuntimeMXBean runtime =  ManagementFactory.getRuntimeMXBean() ;
		// ManagementFactory.getThreadMXBean() 方法或从平台 MBeanServer 方法获得它。
	 	ThreadMXBean mb = ManagementFactory.getThreadMXBean();
	 	//
		MemoryMXBean mbean = ManagementFactory.getMemoryMXBean();
		 List<GarbageCollectorMXBean> gcBeans = ManagementFactory.getGarbageCollectorMXBeans() ;
		
		public List<Thread> list_threads(){
		    int tc = Thread.activeCount();
		    Thread[] ts = new Thread[tc];
		    Thread.enumerate(ts);
		    return java.util.Arrays.asList(ts);
		}
		public ThreadInfo[] threadInfos(){
		 	ThreadInfo[] infos = mb.dumpAllThreads(true, true);
		 	return infos;
		}
	%>
	<% 
 		ServletContext context = getServletContext();
	%>
	<strong>Session :<%=request.getSession() %></strong>
	<hr>
	<%
		Enumeration enums = request.getSession().getAttributeNames();
		while (enums.hasMoreElements()) {
			Object next = enums.nextElement();
			Object value = request.getSession().getAttribute(next + "");
			%>
			<span style="color: green"><%= next %>
			<% 
				if(value instanceof java.util.Collection){
					Collection colls = (Collection)value;
			%>(<%= colls.size() %>)<%}%>  
			</span> :<b style="color: red"><%= value%> </b><br />
			<%}%>
	<hr />

	<strong>java.io.tmpdir:</strong>
	<ul>
		<li><%=System.getProperty("java.io.tmpdir")%></li>
	</ul>
	<br />

	<strong>Memory:</strong>
	<ol>
		<li><span style="color: green"> freeMemory</span> =<%=Runtime.getRuntime().freeMemory()/(1024*1024)%>M</li>
		<li><span style="color: green"> totalMemory</span> =<%=Runtime.getRuntime().totalMemory()/(1024*1024)%>M</li>
		<li><span style="color: green"> maxMemory</span> =<%=Runtime.getRuntime().maxMemory()/(1024*1024)%>M</li>
		<li><span style="color: green"> HeapMemoryUsage</span> =<%=mbean.getHeapMemoryUsage()%></li>
		<li><span style="color: green"> NonHeapMemoryUsage</span> =<%=mbean.getNonHeapMemoryUsage()%></li>
	</ol>

	<strong>GarbageCollector</strong>
	<ol>
		<% for(int i = 0; i < gcBeans.size(); i++) {%>
			<li><span style="color: green"> GC count</span> =<%=gcBeans.get(i).getCollectionCount()%></li>
			<li><span style="color: green"> GC Time</span> =<%=gcBeans.get(i).getCollectionTime()%></li>
			<li><span style="color: green"> MemoryPoolNames:</span> =
			
			<%for(int j = 0; j <gcBeans.get(i).getMemoryPoolNames().length;j++ ){%>
				<%= gcBeans.get(i).getMemoryPoolNames()[j] %>
			<%}%></li>
		
		<%}%>
	</ol>
	
	<strong>Runtime:</strong>
	<ol>
		<li>StartTime(s):<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(runtime.getStartTime()))%></li>
	</ol>	

	<strong>Thread: (<%= list_threads().size() %>)</strong>
	<ol>
		<%for(Thread t : list_threads()){%>
		<li>
			<span style="color: blue"> <%=t.getName()%></span> 
			(<b style="color: red"><%=t.getState()%></b>)
			[ID:<%= t.getId() %>;时间(s):<%=mb.getThreadCpuTime(t.getId())/1000000/60 %>] 
			
			<% if(t.getState().equals(State.BLOCKED)) {
			%>
				<button onclick="stopThread(<%=t.getId() %>)">Kill</button>
			<%} %>
		</li>
		<%}%>
	</ol>
	
	<strong>Thread Infos: (<%= threadInfos().length %>)</strong>
	<%for(ThreadInfo t : threadInfos()){%>
		<li>
			<span style="color: blue"> <%=t.getThreadName()%></span> 
			(<b style="color: red"> <%=t.getThreadId()%> : <%=t.getThreadState()%></b>) : 
			
			<span style="margin-left:40px">StackTrace:(<%= t.getStackTrace().length %>)</span>
			<br/>
			<%for(StackTraceElement ste : t.getStackTrace() ) {%>
				<span style="margin-left:50px; color: green">
				<%= ste.getClassName() %>.<%= ste.getMethodName() %>(<%= ste.getLineNumber() %>)
				</span>
				<br/>
			<%} %>
		</li>
	<%}%>
	
	
	<strong>System properties:</strong>
	<ol>
		<%
			Properties properties = System.getProperties();
			Enumeration names = properties.propertyNames();
			while(names.hasMoreElements()){
				String name =	(String) names.nextElement();
				String value =	(String) properties.get(name);
				%>
					<span style="color:green"> <%= name %> </span>:<b style="color:red"> <%= value %></b>
					<br/>
				<%
			}
			 %>
	</ol>
</body>
</html>