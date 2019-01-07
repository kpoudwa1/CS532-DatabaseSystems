package com.pojo;

import java.util.Date;

/**
 *	POJO Class representing the Students table in database 
 *
 */
public class Student implements ListDisplayI
{
	private String bNo;
	private String firsName;
	private String lastName;
	private String status;
	private double gpa;
	private String email;
	private Date bdate;
	private String deptName;
	
	public String getbNo()
	{
		return bNo;
	}
	
	public void setbNo(String bNo)
	{
		this.bNo = bNo;
	}
	
	public String getFirsName()
	{
		return firsName;
	}
	
	public void setFirsName(String firsName) 
	{
		this.firsName = firsName;
	}
	
	public String getLastName()
	{
		return lastName;
	}
	
	public void setLastName(String lastName) 
	{
		this.lastName = lastName;
	}
	
	public String getStatus() 
	{
		return status;
	}
	
	public void setStatus(String status) 
	{
		this.status = status;
	}
	
	public double getGpa() 
	{
		return gpa;
	}
	
	public void setGpa(double gpa) 
	{
		this.gpa = gpa;
	}
	
	public String getEmail() 
	{
		return email;
	}
	
	public void setEmail(String email) 
	{
		this.email = email;
	}
	
	public Date getBdate()
	{
		return bdate;
	}

	public void setBdate(Date bdate)
	{
		this.bdate = bdate;
	}

	public String getDeptName() 
	{
		return deptName;
	}
	
	public void setDeptName(String deptName) 
	{
		this.deptName = deptName;
	}

	@Override
	public String toString()
	{
		return "Student [bNo=" + bNo + ", firsName=" + firsName + ", lastName="
				+ lastName + ", status=" + status + ", gpa=" + gpa + ", email="
				+ email + ", bdate=" + bdate + ", deptName=" + deptName + "]";
	}
}