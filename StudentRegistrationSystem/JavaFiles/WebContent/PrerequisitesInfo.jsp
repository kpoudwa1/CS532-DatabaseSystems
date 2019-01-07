<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prerequisites Information</title>
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
<%! List<String> prerequisiteCourses;%>
<center>
	<table border="1">
		<tr>
    		<th>Prerequisites Courses</th>
  		</tr>
	<%
	prerequisiteCourses = (List<String>) request.getAttribute("prerequisiteCourses");
	for(int i = 0; i < prerequisiteCourses.size(); i++)
	{
	%>
		<tr>
			<td><%= prerequisiteCourses.get(i)%></td>
		</tr>
	<%} %>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>