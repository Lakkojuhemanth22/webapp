package website;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ApplicationActionServlet")
public class ApplicationActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        String action = request.getParameter("action");

        String status = action.equals("accept") ? "Accepted" : "Rejected";
        boolean success = updateApplicationStatus(applicationId, status);

        response.getWriter().write(success ? "success" : "error");
    }

    private boolean updateApplicationStatus(int applicationId, String status) {
        boolean updated = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
            PreparedStatement ps = con.prepareStatement("UPDATE job_applications SET status = ? WHERE application_id = ?");
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            int rows = ps.executeUpdate();
            updated = rows > 0;
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }
}
