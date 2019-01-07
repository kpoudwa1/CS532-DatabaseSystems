<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pojo.TA" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TAs List</title>
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
<%! List<TA> tas;%>
<center>
	<h2>List of Students</h2>
	<table border="1">
		<tr>
    		<th>B#</th>
    		<th>TA Level</th>
	    	<th>Office</th>
  		</tr>
	<%
	tas = (List<TA>) request.getAttribute("displayList");
	for(int i = 0; i < tas.size(); i++)
	{
	%>
		<tr>
			<td><%= tas.get(i).getbNo()%></td>
			<td><%= tas.get(i).getTaLevel()%></td>
			<td><%= tas.get(i).getOffice()%></td>
		</tr>
	<%} %>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>