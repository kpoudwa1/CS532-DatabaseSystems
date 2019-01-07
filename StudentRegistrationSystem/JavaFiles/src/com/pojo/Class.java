package com.pojo;

/**
 *	POJO Class representing the Classes table in database 
 *
 */
public class Class implements ListDisplayI
{
	private String classId;
	private String deptCode;
	private int courseNo;
	private int sectNo;
	private int year;
	private String semester;
	private int limit;
	private int classSize;
	private String room;
	private String taBNo;
	
	public String getClassId()
	{
		return classId;
	}
	
	public void setClassId(String classId) 
	{
		this.classId = classId;
	}
	
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
	
	public int getSectNo() 
	{
		return sectNo;
	}
	
	public void setSectNo(int sectNo) 
	{
		this.sectNo = sectNo;
	}
	
	public int getYear() 
	{
		return year;
	}
	
	public void setYear(int year) 
	{
		this.year = year;
	}
	
	public String getSemester() 
	{
		return semester;
	}
	
	public void setSemester(String semester) 
	{
		this.semester = semester;
	}
	
	public int getLimit() 
	{
		return limit;
	}
	
	public void setLimit(int limit) 
	{
		this.limit = limit;
	}
	
	public int getClassSize() 
	{
		return classSize;
	}
	
	public void setClassSize(int classSize) 
	{
		this.classSize = classSize;
	}
	
	public String getRoom() 
	{
		return room;
	}
	
	public void setRoom(String room) 
	{
		this.room = room;
	}
	
	public String getTaBNo() 
	{
		return taBNo;
	}
	
	public void setTaBNo(String taBNo) 
	{
		this.taBNo = taBNo;
	}

	@Override
	public String toString() 
	{
		return "Class [classId=" + classId + ", deptCode=" + deptCode
				+ ", courseNo=" + courseNo + ", sectNo=" + sectNo + ", year="
				+ year + ", semester=" + semester + ", limit=" + limit
				+ ", classSize=" + classSize + ", room=" + room + ", taBNo="
				+ taBNo + "]";
	}
}