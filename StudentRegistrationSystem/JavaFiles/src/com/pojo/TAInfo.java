package com.pojo;

/**
 *	POJO Class representing the TA information from database 
 *
 */
public class TAInfo
{
	private String bNo;
	private String firstName;
	private String lastName;
	
	public String getbNo()
	{
		return bNo;
	}
	
	public void setbNo(String bNo)
	{
		this.bNo = bNo;
	}
	
	public String getFirstName()
	{
		return firstName;
	}
	
	public void setFirstName(String firstName)
	{
		this.firstName = firstName;
	}
	
	public String getLastName()
	{
		return lastName;
	}
	
	public void setLastName(String lastName)
	{
		this.lastName = lastName;
	}

	@Override
	public String toString()
	{
		return "TAInfo [bNo=" + bNo + ", firstName=" + firstName
				+ ", lastName=" + lastName + "]";
	}
}