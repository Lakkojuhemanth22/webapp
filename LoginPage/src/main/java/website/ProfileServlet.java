package website;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root")) {
            // Fetch user ID and role
            PreparedStatement userStmt = con.prepareStatement("SELECT user_id, role FROM users WHERE username = ?");
            userStmt.setString(1, username);
            ResultSet userRs = userStmt.executeQuery();
            
            int userId = -1;
            String role = null;

            if (userRs.next()) {
                userId = userRs.getInt("user_id");
                role = userRs.getString("role");
            }

            if (userId == -1 || role == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            if (role.equalsIgnoreCase("Freelancer")) {
                // Fetch Freelancer Projects
                PreparedStatement psProjects = con.prepareStatement("SELECT * FROM projects WHERE user_id = ?");
                psProjects.setInt(1, userId);
                ResultSet rsProjects = psProjects.executeQuery();

                List<Project> projectList = new ArrayList<>();
                while (rsProjects.next()) {
                    projectList.add(new Project(
                        rsProjects.getInt("project_id"),
                        rsProjects.getString("project_name"),
                        rsProjects.getString("project_description")
                    ));
                }
                request.setAttribute("projectList", projectList);
                request.getRequestDispatcher("profile.jsp").forward(request, response);

            } else if (role.equalsIgnoreCase("Client")) {
                // Fetch Jobs Posted by Client
                PreparedStatement psJobs = con.prepareStatement("SELECT * FROM jobs WHERE client_id = ?");
                psJobs.setInt(1, userId);
                ResultSet rsJobs = psJobs.executeQuery();

                List<Job> jobList = new ArrayList<>();
                while (rsJobs.next()) {
                    jobList.add(new Job(
                        rsJobs.getInt("job_id"),
                        rsJobs.getString("job_title"),
                        rsJobs.getString("job_description")
                    ));
                }
                request.setAttribute("jobList", jobList);
                request.getRequestDispatcher("clientProfile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
