package website;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddProjectServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AddProjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get project details and username from session
        String projectName = request.getParameter("project_name");
        String projectDescription = request.getParameter("project_description");
        String username = (String) request.getSession().getAttribute("username");

        // Get file part for project image
        Part filePart = request.getPart("project_image");
        InputStream inputStream = null;
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");

            // Directly insert using username in the WHERE clause of the SELECT statement
            String sql = "INSERT INTO projects (user_id, project_name, project_description, image) " +
                         "SELECT user_id, ?, ?, ? FROM users WHERE username = ?";
            PreparedStatement p = con.prepareStatement(sql);
            p.setString(1, projectName);
            p.setString(2, projectDescription);
            
            if (inputStream != null) {
                p.setBlob(3, inputStream);
            } else {
                p.setNull(3, java.sql.Types.BLOB);
            }
            // Set the username (not userId) as parameter 4
            p.setString(4, username);
            
            p.executeUpdate();
            response.sendRedirect("profile.jsp");
            p.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
