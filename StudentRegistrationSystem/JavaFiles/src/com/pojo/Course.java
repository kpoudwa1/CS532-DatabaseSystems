package com.pojo;

/**
 *	POJO Class representing the Courses table in database 
 *
 */
public class Course implements ListDisplayI
{
	private String deptCode;
	private int courseNo;
	private String title;
	
	public String getDeptCode() 
	{
		return deptCode;
	}

	public void setDeptCode(String deptCode) 
	{
		this.deptCode = deptCode;
	}

	public int getCourseNo() 
	{
		return courseNo;
	}

	public void setCourseNo(int courseNo) 
	{
		this.courseNo = courseNo;
	}

	public String getTitle() 
	{
		return title;
	}

	public void setTitle(String title) 
	{
		this.title = title;
	}

	@Override
	public String toString() 
	{
		return "Course [deptCode=" + deptCode + ", courseNo=" + courseNo
				+ ", title=" + title + "]";
	}
}