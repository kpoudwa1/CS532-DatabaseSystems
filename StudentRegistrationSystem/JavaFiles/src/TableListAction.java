

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DatabaseProcessor;
import com.pojo.ListDisplayI;

/**
 * Servlet implementation class TableListAction
 */
public class TableListAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TableListAction() {
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
		System.out.println("************************ TableListAction Servlet DO POST STARTED  ************************");
		System.out.println("Display option: " + request.getParameter("displayoption"));
		
		DatabaseProcessor c = new DatabaseProcessor();
		List<ListDisplayI> displayList = c.executeshowListsProc(request.getParameter("displayoption"));
		request.setAttribute("displayList", displayList);
		RequestDispatcher rd = null;
		
		if(request.getParameter("displayoption").equalsIgnoreCase("Students"))
		{
			rd = request.getRequestDispatcher("StudentsList.jsp");
		}
		else if(request.getParameter("displayoption").equalsIgnoreCase("TAs"))
		{
			rd = request.getRequestDispatcher("TAsList.jsp");
		}
		else if(request.getParameter("displayoption").equalsIgnoreCase("Courses"))
		{
			rd = request.getRequestDispatcher("CoursesList.jsp");
		}
		else if(request.getParameter("displayoption").equalsIgnoreCase("Classes"))
		{
			rd = request.getRequestDispatcher("ClassesList.jsp");
		}
		else if(request.getParameter("displayoption").equalsIgnoreCase("Enrollments"))
		{
			rd = request.getRequestDispatcher("EnrollmentsList.jsp");
		}
		else if(request.getParameter("displayoption").equalsIgnoreCase("Prerequisites"))
		{
			rd = request.getRequestDispatcher("PrerequisitesList.jsp");
		}
		else if(request.getParameter("displayoption").equalsIgnoreCase("Logs"))
		{
			rd = request.getRequestDispatcher("LogsList.jsp");
		}
		
		rd.forward(request, response);
		
		System.out.println("************************ TableListAction Servlet DO POST COMPLETED  ************************");
	}
}
