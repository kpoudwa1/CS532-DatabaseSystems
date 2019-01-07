

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DatabaseProcessor;

/**
 * Servlet implementation class DeleteStudentAction
 */
public class DeleteStudentAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteStudentAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("************************ DeleteStudentAction Servlet DO POST STARTED  ************************");
		System.out.println("B#: " + request.getParameter("bNo"));
		
		try
		{
			DatabaseProcessor c = new DatabaseProcessor();
			String status = c.deleteStudent(request.getParameter("bNo"));
			request.setAttribute("errorMessage", status);
			RequestDispatcher rd = request.getRequestDispatcher("DeleteStudentForm.jsp");
			rd.forward(request, response);
		}
		catch(SQLException e)
		{
			//e.printStackTrace();
			request.setAttribute("errorMessage", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("DeleteStudentForm.jsp");
			rd.forward(request, response);
		}
		
		System.out.println("************************ DeleteStudentAction Servlet DO POST COMPLETED  ************************");
	}

}
