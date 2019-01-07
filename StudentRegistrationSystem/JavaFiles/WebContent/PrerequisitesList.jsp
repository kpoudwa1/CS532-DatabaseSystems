<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pojo.Prerequisite" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prerequisites List</title>
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
<%! List<Prerequisite> prerequisites;%>
<center>
	<h2>List of Prerequisites</h2>
	<table border="1">
		<tr>
    		<th>Dept Code</th>
	    	<th>Course No</th>
	    	<th>Pre Dept Code</th>
	    	<th>Pre Course No</th>
  		</tr>
	<%
	prerequisites = (List<Prerequisite>) request.getAttribute("displayList");
	for(int i = 0; i < prerequisites.size(); i++)
	{
	%>
		<tr>
			<td><%= prerequisites.get(i).getDeptCode()%></td>
			<td><%= prerequisites.get(i).getCourseNo()%></td>
			<td><%= prerequisites.get(i).getPreDeptCode()%></td>
			<td><%= prerequisites.get(i).getPreCourseNo()%></td>
		</tr>
	<%} %>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>