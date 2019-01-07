<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display List</title>
</head>
<body style="background-color:#005A43;">
<center>
	<h2>Please select a table</h2>
	<form action="TableListAction" method="post">
		<select name="displayoption" >
			<option value="Students">Students</option>
			<option value="TAs">TAs</option>
			<option value="Courses">Courses</option>
			<option value="Classes">Classes</option>
			<option value="Enrollments">Enrollments</option>
			<option value="Prerequisites">Prerequisites</option>
			<option value="Logs">Logs</option>
		</select>
		<input type="submit" value="Submit">
	</form>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</body>
</html>