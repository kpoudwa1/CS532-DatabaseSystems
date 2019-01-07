<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pojo.Logs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logs List</title>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 4px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
</head>
<body style="background-color:#005A43;">
<%! List<Logs> logs;%>
<center>
	<h2>List of Logs</h2>
	<table border="1">
		<tr>
    		<th>Log No</th>
    		<th>Op Name</th>
	    	<th>Op Time</th>
	    	<th>Table Name</th>
		    <th>Operation</th>
	    	<th>Key-Value</th>
  		</tr>
	<%
	logs = (List<Logs>) request.getAttribute("displayList");
	for(int i = 0; i < logs.size(); i++)
	{
	%>
		<tr>
			<td><%= logs.get(i).getLogNo()%></td>
			<td><%= logs.get(i).getOpName()%></td>
			<td><%= logs.get(i).getOpTime()%></td>
			<td><%= logs.get(i).getTableName()%></td>
			<td><%= logs.get(i).getOperation()%></td>
			<td><%= logs.get(i).getKeyValue()%></td>
		</tr>
	<%} %>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>