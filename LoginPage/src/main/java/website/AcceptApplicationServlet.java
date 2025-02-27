package website;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/AcceptApplicationServlet")
public class AcceptApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve application id from request
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));

        Connection con = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");

            // Update the job application status to 'Accepted'
            String updateQuery = "UPDATE job_applications SET status = 'Accepted' WHERE application_id = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setInt(1, applicationId);
            ps.executeUpdate();
            ps.close();

            // Retrieve freelancer_id and job_id for the application
            String getAppQuery = "SELECT freelancer_id, job_id FROM job_applications WHERE application_id = ?";
            ps = con.prepareStatement(getAppQuery);
            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();
            int freelancerId = -1;
            int jobId = -1;
            if (rs.next()) {
                freelancerId = rs.getInt("freelancer_id");
                jobId = rs.getInt("job_id");
            }
            rs.close();
            ps.close();

            // Retrieve job title from jobs table
            String jobTitle = "";
            String getJobQuery = "SELECT job_title FROM jobs WHERE job_id = ?";
            ps = con.prepareStatement(getJobQuery);
            ps.setInt(1, jobId);
            rs = ps.executeQuery();
            if (rs.next()) {
                jobTitle = rs.getString("job_title");
            }
            rs.close();
            ps.close();

            // Insert a notification for the freelancer
            String message = "Your application for the job '" + jobTitle + "' has been accepted.";
            String insertNoti = "INSERT INTO notifications (freelancer_id, message) VALUES (?, ?)";
            ps = con.prepareStatement(insertNoti);
            ps.setInt(1, freelancerId);
            ps.setString(2, message);
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("clientProfile.jsp?msg=Application Accepted and Notified");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Error Accepting Application");
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
