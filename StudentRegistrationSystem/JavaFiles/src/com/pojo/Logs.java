package com.pojo;

import java.util.Date;

/**
 *	POJO Class representing the Logs table in database 
 *
 */
public class Logs implements ListDisplayI
{
	private int logNo;
	private String opName;
	private Date opTime;
	private String tableName;
	private String operation;
	private String keyValue;
	
	public int getLogNo()
	{
		return logNo;
	}
	
	public void setLogNo(int logNo) 
	{
		this.logNo = logNo;
	}
	
	public String getOpName() 
	{
		return opName;
	}
	
	public void setOpName(String opName) 
	{
		this.opName = opName;
	}
	
	public Date getOpTime() 
	{
		return opTime;
	}
	
	public void setOpTime(Date opTime) 
	{
		this.opTime = opTime;
	}
	
	public String getTableName() 
	{
		return tableName;
	}
	
	public void setTableName(String tableName)
	{
		this.tableName = tableName;
	}
	
	public String getOperation() 
	{
		return operation;
	}
	
	public void setOperation(String operation) 
	{
		this.operation = operation;
	}
	
	public String getKeyValue() 
	{
		return keyValue;
	}
	
	public void setKeyValue(String keyValue) 
	{
		this.keyValue = keyValue;
	}

	@Override
	public String toString() 
	{
		return "Logs [logNo=" + logNo + ", opName=" + opName + ", opTime="
				+ opTime + ", tableName=" + tableName + ", operation="
				+ operation + ", keyValue=" + keyValue + "]";
	}
}