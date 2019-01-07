package com.pojo;

/**
 *	POJO Class representing the Prerequisites table in database 
 *
 */
public class Prerequisite implements ListDisplayI 
{
	private String deptCode;
	private int courseNo;
	private String preDeptCode;
	private int preCourseNo;
	
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
	
	public String getPreDeptCode() 
	{
		return preDeptCode;
	}
	
	public void setPreDeptCode(String preDeptCode) 
	{
		this.preDeptCode = preDeptCode;
	}
	
	public int getPreCourseNo() 
	{
		return preCourseNo;
	}
	
	public void setPreCourseNo(int preCourseNo) 
	{
		this.preCourseNo = preCourseNo;
	}

	@Override
	public String toString() 
	{
		return "Prerequisite [deptCode=" + deptCode + ", courseNo=" + courseNo
				+ ", preDeptCode=" + preDeptCode + ", preCourseNo="
				+ preCourseNo + "]";
	}
}