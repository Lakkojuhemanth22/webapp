package website;

import jakarta.servlet.RequestDispatcher;
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
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");

            String name = request.getParameter("txtName");
            String password = request.getParameter("txtPassword");

            PreparedStatement ps = con.prepareStatement("SELECT username, role FROM users WHERE username=? AND password=?");
            ps.setString(1, name);
            ps.setString(2, password);

            // Execute the query
            ResultSet rs = ps.executeQuery();

            // Check if the user exists
            if (rs.next()) {
                String role = rs.getString("role"); 

                // Store username and role in session
                HttpSession session = request.getSession();
                session.setAttribute("username", name);
                session.setAttribute("role", role); 

                // Redirect user to the home page
                response.sendRedirect("home.jsp");
            } else {
                // If username or password is incorrect, show error message
                request.setAttribute("errorMessage", "Invalid Username or Password!");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
