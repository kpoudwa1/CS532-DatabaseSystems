<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pojo.Student" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Students List</title>
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
<%! List<Student> students;%>
<center>
	<h2>List of Students</h2>
	<table border="1">
		<tr>
    		<th>B#</th>
    		<th>First Name</th>
	    	<th>Last Name</th>
	    	<th>Status</th>
	    	<th>GPA</th>
	    	<th>Email</th>
	    	<th>Birth Date</th>
	    	<th>Department Name</th>
	  	</tr>
	<%
	students = (List<Student>) request.getAttribute("displayList");
	for(int i = 0; i < students.size(); i++)
	{
	%>
		<tr>
			<td><%= students.get(i).getbNo()%></td>
			<td><%= students.get(i).getFirsName()%></td>
			<td><%= students.get(i).getLastName()%></td>
			<td><%= students.get(i).getStatus()%></td>
			<td><%= students.get(i).getGpa()%></td>
			<td><%= students.get(i).getEmail()%></td>
			<td><%= students.get(i).getBdate().toString()%></td>
			<td><%= students.get(i).getDeptName()%></td>
		</tr>
	<%} %>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>