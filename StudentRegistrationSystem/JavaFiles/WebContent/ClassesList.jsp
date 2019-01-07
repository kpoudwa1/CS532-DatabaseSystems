<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pojo.Class" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Classes List</title>
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
<%! List<Class> classes;%>
<center>
	<table border="1">
		<tr>
    		<th>Class Id</th>
    		<th>Dept Code</th>
	    	<th>Course No</th>
	    	<th>Sect No</th>
	    	<th>year</th>
	    	<th>Semester</th>
	    	<th>Limit</th>
	    	<th>Class Size</th>
	    	<th>Room</th>
	    	<th>TA BNo</th>
  		</tr>
	<%
	classes = (List<Class>) request.getAttribute("displayList");
	for(int i = 0; i < classes.size(); i++)
	{
	%>
		<tr>
			<td><%= classes.get(i).getClassId()%></td>
			<td><%= classes.get(i).getDeptCode()%></td>
			<td><%= classes.get(i).getCourseNo()%></td>
			<td><%= classes.get(i).getSectNo()%></td>
			<td><%= classes.get(i).getYear()%></td>
			<td><%= classes.get(i).getSemester()%></td>
			<td><%= classes.get(i).getLimit()%></td>
			<td><%= classes.get(i).getClassSize()%></td>
			<td><%= classes.get(i).getRoom()%></td>
			<td><%= classes.get(i).getTaBNo()%></td>
		</tr>
	<%} %>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>