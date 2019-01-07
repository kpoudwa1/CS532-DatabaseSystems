package com.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;
import oracle.jdbc.pool.OracleDataSource;
import com.pojo.*;
import com.pojo.Class;

/**
 * Class for performing database procedure calls
 */
public class DatabaseProcessor
{
	private static String userName = "kpoudwa1";
	private static String password = "admin";
	
	/**
	 * Function for handling SHOW_XXXX procedures
	 * @param option The option to be displayed for instance Students, Classes etc
	 * @return The list to be displayed
	 */
	public List<ListDisplayI> executeshowListsProc(String option)
	{
		//Generic list
		List<ListDisplayI> displayLists = new ArrayList<ListDisplayI>();
		
		Connection conn =  null;
		CallableStatement cs = null;
		ResultSet rs = null;

		try
		{
			OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
			ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
			conn = ds.getConnection(userName, password);
			
			//For handling SHOW_STUDENTS
			if(option.equalsIgnoreCase("Students"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_STUDENTS(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createStudentsList(rs);
			}//For handling SHOW_TAS
			else if(option.equalsIgnoreCase("TAs"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_TAS(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createTAsList(rs);
			}//For handling SHOW_COURSES
			else if(option.equalsIgnoreCase("Courses"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_COURSES(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createCoursesList(rs);
			}//For handling SHOW_CLASSES
			else if(option.equalsIgnoreCase("Classes"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_CLASSES(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createClassesList(rs);
			}//For handling SHOW_ENROLLMENTS
			else if(option.equalsIgnoreCase("Enrollments"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_ENROLLMENTS(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createEnrollmentsList(rs);
			}//For handling SHOW_PREREQUISITES
			else if(option.equalsIgnoreCase("Prerequisites"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_PREREQUISITES(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createPrerequisitesList(rs);
			}//For handling SHOW_LOGS
			else if(option.equalsIgnoreCase("Logs"))
			{
				cs = conn.prepareCall("{call SRS.SHOW_LOGS(?)}");
				cs.registerOutParameter(1, OracleTypes.CURSOR);
				cs.execute();
				rs = (ResultSet)cs.getObject(1);
				
				displayLists = createLogsList(rs);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
				if(cs != null)
					cs.close();
				if(conn != null)
					conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		return displayLists;
	}
	
	private List<ListDisplayI> createStudentsList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> students = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
        	Student tempStudent = new Student();
        	
        	tempStudent.setbNo(rs.getString("B#"));
        	tempStudent.setFirsName(rs.getString("FIRST_NAME"));
        	tempStudent.setLastName(rs.getString("LAST_NAME"));
        	tempStudent.setStatus(rs.getString("STATUS") != null ? rs.getString("STATUS") : "-");
        	tempStudent.setGpa(rs.getDouble("GPA"));
        	tempStudent.setEmail(rs.getString("EMAIL") != null ? rs.getString("EMAIL") : "-");
        	tempStudent.setBdate(rs.getDate("BDATE"));
        	tempStudent.setDeptName(rs.getString("DEPTNAME"));
        	
        	students.add(tempStudent);
         }
		
		return students;
	}
	
	private List<ListDisplayI> createTAsList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> tas = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
        	TA tempTA = new TA();
        	
        	tempTA.setbNo(rs.getString("B#"));
        	tempTA.setTaLevel(rs.getString("TA_LEVEL"));
        	tempTA.setOffice(rs.getString("OFFICE") != null ? rs.getString("OFFICE") : "-");
        	
        	tas.add(tempTA);
         }
		
		return tas;
	}
	
	private List<ListDisplayI> createCoursesList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> courses = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
			Course tempCourse = new Course();
        	
			tempCourse.setDeptCode(rs.getString("DEPT_CODE"));
			tempCourse.setCourseNo(rs.getInt("COURSE#"));
			tempCourse.setTitle(rs.getString("TITLE"));
        	
        	courses.add(tempCourse);
         }
		
		return courses ;
	}
	
	private List<ListDisplayI> createClassesList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> classes = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
			Class tempClass = new Class();
        	
			tempClass.setClassId(rs.getString("CLASSID"));
			tempClass.setDeptCode(rs.getString("DEPT_CODE"));
			tempClass.setCourseNo(rs.getInt("COURSE#"));
			tempClass.setSectNo(rs.getInt("SECT#"));
			tempClass.setYear(rs.getInt("YEAR"));
			tempClass.setSemester(rs.getString("SEMESTER") != null ? rs.getString("SEMESTER") : "-");
			tempClass.setLimit(rs.getInt("LIMIT"));
			tempClass.setClassSize(rs.getInt("CLASS_SIZE") < 0 ? 0 : rs.getInt("CLASS_SIZE"));
			tempClass.setRoom(rs.getString("ROOM") != null ? rs.getString("ROOM") : "-");
			tempClass.setTaBNo(rs.getString("TA_B#") != null ? rs.getString("TA_B#") : "-");
			
			classes.add(tempClass);
         }
		
		return classes ;
	}
	
	private List<ListDisplayI> createEnrollmentsList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> enrollments = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
			Enrollment tempEnrollment = new Enrollment();
			
			tempEnrollment.setbNo(rs.getString("B#"));
			tempEnrollment.setClassId(rs.getString("CLASSID"));
			tempEnrollment.setLgrade(rs.getString("LGRADE") != null ? rs.getString("LGRADE") : "-");
        	
			enrollments.add(tempEnrollment);
         }
		
		return enrollments ;
	}
	
	private List<ListDisplayI> createPrerequisitesList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> prerequisites = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
			Prerequisite tempPrerequisite = new Prerequisite();
			
			tempPrerequisite.setDeptCode(rs.getString("DEPT_CODE"));
			tempPrerequisite.setCourseNo(rs.getInt("COURSE#"));
			tempPrerequisite.setPreDeptCode(rs.getString("PRE_DEPT_CODE"));
			tempPrerequisite.setPreCourseNo(rs.getInt("PRE_COURSE#"));
			
			prerequisites.add(tempPrerequisite);
         }
		
		return prerequisites ;
	}
	
	private List<ListDisplayI> createLogsList(ResultSet rs) throws SQLException
	{
		List<ListDisplayI> logs = new ArrayList<ListDisplayI>();
		while (rs.next())
        {
			Logs tempLogs = new Logs();
			
			tempLogs.setLogNo(rs.getInt("LOG#"));
			tempLogs.setOpName(rs.getString("OP_NAME"));
			tempLogs.setOpTime(rs.getDate("OP_TIME"));
			tempLogs.setTableName(rs.getString("TABLE_NAME"));
			tempLogs.setOperation(rs.getString("OPERATION"));
			tempLogs.setKeyValue(rs.getString("KEY_VALUE") != null ? rs.getString("KEY_VALUE") : "-");
			
			logs.add(tempLogs);
         }
		
		return logs ;
	}
	
	/**
	 * Function for calling procedure GET_TA_FOR_CLASS for getting TA details
	 * @param classId The classid whose TA is to be obtained
	 * @return TA details
	 * @throws SQLException When the procedure throws an error
	 */
	public TAInfo getTAInformation(String classId) throws SQLException
	{
		TAInfo taInfo = null;
		Connection conn =  null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try
		{
			OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
			ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
			conn = ds.getConnection(userName, password);
			
			cs = conn.prepareCall("{call SRS.GET_TA_FOR_CLASS(?, ?)}");
			cs.setString(1, classId);
			cs.registerOutParameter(2, OracleTypes.CURSOR);
			
			cs.execute();
			rs = (ResultSet)cs.getObject(2);
			
			if(rs.next())
			{
				taInfo = new TAInfo();
				
				taInfo.setbNo(rs.getString("B#"));
				taInfo.setFirstName(rs.getString("FIRST_NAME"));
				taInfo.setLastName(rs.getString("LAST_NAME"));
			}
			return taInfo;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			String errorMessage = e.getMessage().substring(e.getMessage().indexOf(":") + 1, + e.getMessage().indexOf("\n") + 1).trim();
			SQLException e1 = new SQLException(errorMessage);
			throw e1;
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
				if(cs != null)
					cs.close();
				if(conn != null)
					conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		
	}
	
	/**
	 * Function for getting the lists of prerequisites for the course
	 * @param deptCode The department code
	 * @param courseNo The course no
	 * @return List of the prerequisites
	 * @throws SQLException When the procedure throws an error
	 */
	public List<String> getPrereqisiteInformation(String deptCode, String courseNo) throws SQLException
	{
		List<String> prerequisiteCourses = new ArrayList<String>();
		Connection conn =  null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try
		{
			OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
			ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
			conn = ds.getConnection(userName, password);
			
			cs = conn.prepareCall("{call SRS.GET_PREREQUISITE(?, ?, ?)}");
			cs.setString(1, deptCode);
			cs.setString(2, courseNo);
			cs.registerOutParameter(3, OracleTypes.CURSOR);
			
			cs.execute();
			rs = (ResultSet)cs.getObject(3);
			
			while(rs.next())
			{
				prerequisiteCourses.add(rs.getString(1));
			}
			return prerequisiteCourses;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			String errorMessage = e.getMessage().substring(e.getMessage().indexOf(":") + 1, + e.getMessage().indexOf("\n") + 1).trim();
			SQLException e1 = new SQLException(errorMessage);
			throw e1;
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
				if(cs != null)
					cs.close();
				if(conn != null)
					conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Function for calling the procedure to enroll the student in a class
	 * @param bNo The B no of the student
	 * @param classId The class id to which the student is to be registered 
	 * @return Status of the enrollment
	 * @throws SQLException When the procedure throws an error
	 */
	public String enrollStudent(String bNo, String classId) throws SQLException
	{
		Connection conn =  null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try
		{
			OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
			ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
			conn = ds.getConnection(userName, password);
			
			cs = conn.prepareCall("{call SRS.ENROLL_STUDENT(?, ?)}");
			cs.setString(1, bNo);
			cs.setString(2, classId);
			
			cs.execute();
			
			return "Student enrolled successfully!";
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			String errorMessage = e.getMessage().substring(e.getMessage().indexOf(":") + 1, + e.getMessage().indexOf("\n") + 1).trim();
			SQLException e1 = new SQLException(errorMessage);
			throw e1;
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
				if(cs != null)
					cs.close();
				if(conn != null)
					conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Function for dropping the student from a course
	 * @param bNo The B no for the student
	 * @param classId The class id for the class from which the student is to be dropped
	 * @return The status of the transaction
	 * @throws SQLException When the procedure throws an error
	 */
	public String dropStudent(String bNo, String classId) throws SQLException
	{
		Connection conn =  null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try
		{
			OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
			ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
			conn = ds.getConnection(userName, password);
			
			cs = conn.prepareCall("{call SRS.DROP_STUDENT(?, ?)}");
			cs.setString(1, bNo);
			cs.setString(2, classId);
			
			cs.execute();
			
			return "Student dropped successfully!";
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			String errorMessage = e.getMessage().substring(e.getMessage().indexOf(":") + 1, + e.getMessage().indexOf("\n") + 1).trim();
			SQLException e1 = new SQLException(errorMessage);
			throw e1;
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
				if(cs != null)
					cs.close();
				if(conn != null)
					conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Function for deleting the student
	 * @param bNo The B no of the student
	 * @return The status of the transaction
	 * @throws SQLException When the procedure throws an error
	 */
	public String deleteStudent(String bNo) throws SQLException
	{
		Connection conn =  null;
		CallableStatement cs = null;
		ResultSet rs = null;
		try
		{
			OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
			ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
			conn = ds.getConnection(userName, password);
			
			cs = conn.prepareCall("{call SRS.DELETE_STUDENT(?)}");
			cs.setString(1, bNo);
			
			cs.execute();
			
			return "Student deleted successfully!";
		}
		catch(SQLException e)
		{
			//e.printStackTrace();
			String errorMessage = e.getMessage().substring(e.getMessage().indexOf(":") + 1, + e.getMessage().indexOf("\n") + 1).trim();
			SQLException e1 = new SQLException(errorMessage);
			throw e1;
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
				if(cs != null)
					cs.close();
				if(conn != null)
					conn.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
}