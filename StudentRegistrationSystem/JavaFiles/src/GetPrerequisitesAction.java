
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.db.DatabaseProcessor;

/**
 * Servlet implementation class GetPrerequisitesAction
 */
public class GetPrerequisitesAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPrerequisitesAction() {
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
		System.out.println("************************ GetPrerequisitesAction Servlet DO POST STARTED  ************************");
		System.out.println("Dept Code: " + request.getParameter("deptCode"));
		System.out.println("Course No: " + request.getParameter("courseNo"));
		
		try
		{
			DatabaseProcessor c = new DatabaseProcessor();
			List<String> prerequisiteCourses = c.getPrereqisiteInformation(request.getParameter("deptCode"), request.getParameter("courseNo"));
			request.setAttribute("prerequisiteCourses", prerequisiteCourses);
			RequestDispatcher rd = request.getRequestDispatcher("PrerequisitesInfo.jsp");
			rd.forward(request, response);
		}
		catch(SQLException e)
		{
			request.setAttribute("errorMessage", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("PrerequisitesInformation.jsp");
			rd.forward(request, response);
		}
		System.out.println("************************ GetPrerequisitesAction Servlet DO POST COMPLETED ************************");
	}
}
