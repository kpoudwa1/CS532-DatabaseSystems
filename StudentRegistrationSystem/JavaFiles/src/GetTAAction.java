

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.DatabaseProcessor;
import com.pojo.TAInfo;

/**
 * Servlet implementation class GetTAAction
 */
public class GetTAAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetTAAction() {
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
		System.out.println("************************ GetTAAction Servlet DO POST STARTED  ************************");
		try
		{
			DatabaseProcessor c = new DatabaseProcessor();
			TAInfo ta = c.getTAInformation(request.getParameter("classId"));
			request.setAttribute("ta", ta);
			RequestDispatcher rd = request.getRequestDispatcher("TAInfo.jsp");
			rd.forward(request, response);
		}
		catch(SQLException e)
		{
			request.setAttribute("errorMessage", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("TAInformation.jsp");
			rd.forward(request, response);
		}
		System.out.println("************************ GetTAAction Servlet DO POST COMPLETED  ************************");
	}

}
