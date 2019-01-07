package com.pojo;

/**
 *	POJO Class representing the Enrollments table in database 
 *
 */
public class Enrollment implements ListDisplayI
{
	private String bNo;
	private String classId;
	private String lgrade;
	
	public String getbNo() 
	{
		return bNo;
	}

	public void setbNo(String bNo) 
	{
		this.bNo = bNo;
	}

	public String getClassId() 
	{
		return classId;
	}

	public void setClassId(String classId)
	{
		this.classId = classId;
	}

	public String getLgrade() 
	{
		return lgrade;
	}

	public void setLgrade(String lgrade) 
	{
		this.lgrade = lgrade;
	}

	@Override
	public String toString()
	{
		return "Enrollment [bNo=" + bNo + ", classId=" + classId + ", lgrade="
				+ lgrade + "]";
	}
}