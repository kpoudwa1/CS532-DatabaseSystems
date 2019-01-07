<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.pojo.TAInfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TA Details</title>
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
<%! TAInfo ta;%>
<center>
	<h2>TA Details</h2>
	<table border="1">
		<tr>
    		<th>B#</th>
    		<th>First Name</th>
	    	<th>Last Name</th>
	  	</tr>
	<%
	ta = (TAInfo) request.getAttribute("ta");
	%>
		<tr>
			<td><%= ta.getbNo()%></td>
			<td><%= ta.getFirstName()%></td>
			<td><%= ta.getLastName()%></td>
		</tr>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>