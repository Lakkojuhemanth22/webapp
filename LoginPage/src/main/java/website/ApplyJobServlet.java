package website;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Retrieve jobId and proposal from the form
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        String proposal = request.getParameter("proposal");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
            
            // Get freelancer_id from users table based on the username
            String userQuery = "SELECT user_id FROM users WHERE username=?";
            PreparedStatement psUser = con.prepareStatement(userQuery);
            psUser.setString(1, username);
            ResultSet rsUser = psUser.executeQuery();
            int freelancerId = -1;
            if (rsUser.next()) {
                freelancerId = rsUser.getInt("user_id");
            }
            rsUser.close();
            psUser.close();
            
            if (freelancerId == -1) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Insert new application
            String insertQuery = "INSERT INTO job_applications (job_id, freelancer_id, proposal) VALUES (?, ?, ?)";
            PreparedStatement psInsert = con.prepareStatement(insertQuery);
            psInsert.setInt(1, jobId);
            psInsert.setInt(2, freelancerId);
            psInsert.setString(3, proposal);
            psInsert.executeUpdate();
            psInsert.close();
            con.close();
            
            // Redirect back with success message
            response.sendRedirect("applicationSuccess.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Application+Submission+Failed");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
