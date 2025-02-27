package website;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddSkillServlet")
public class AddSkillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String skillName = request.getParameter("skill_name");
        String username = (String) request.getSession().getAttribute("username");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
            PreparedStatement ps = con.prepareStatement("INSERT INTO skills (user_id, skill_name) SELECT user_id, ? FROM users WHERE username = ?");
            ps.setString(1, skillName);
            ps.setString(2, username);
            ps.executeUpdate();
            response.sendRedirect("profile.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
