<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prerequisites Information</title>
</head>
<body style="background-color:#005A43;">
<form action="GetPrerequisitesAction" method="post">
<center>
	<h2>Prerequisites Information</h2>
	<%if(request.getAttribute("errorMessage") != null) 
	  {%>
		<h2><font color="red"><%=request.getAttribute("errorMessage") %></font></h2>
	<%}%>
	<table>
		<tr>
    		<td>Dept Code:</td>
    		<td><input type="text" name="deptCode"><br></td>
  		</tr>
  		<tr>
    		<td>Course No:</td>
    		<td><input type="text" name="courseNo"><br></td>
  		</tr>
  		<tr>
  			<td></td>
  			<td><input type="submit" value="Submit"></td>
  		</tr>
	</table>
</center>
<hr>
Back to <a href="index.jsp" style="color:white">home</a>
</form>
</body>
</html>