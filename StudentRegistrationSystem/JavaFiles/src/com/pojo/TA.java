package com.pojo;

/**
 *	POJO Class representing the TA table in database 
 *
 */
public class TA implements ListDisplayI
{
	private String bNo;
	private String taLevel;
	private String office;
	
	public String getbNo() 
	{
		return bNo;
	}
	
	public void setbNo(String bNo) 
	{
		this.bNo = bNo;
	}
	
	public String getTaLevel()
	{
		return taLevel;
	}
	
	public void setTaLevel(String taLevel) 
	{
		this.taLevel = taLevel;
	}
	
	public String getOffice() 
	{
		return office;
	}
	
	public void setOffice(String office) 
	{
		this.office = office;
	}

	@Override
	public String toString() 
	{
		return "TAS [bNo=" + bNo + ", taLevel=" + taLevel + ", office="
				+ office + "]";
	}
}