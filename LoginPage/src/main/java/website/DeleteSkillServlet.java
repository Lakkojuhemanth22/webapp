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

@WebServlet("/DeleteSkillServlet")
public class DeleteSkillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int skillId = Integer.parseInt(request.getParameter("skill_id"));

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
            PreparedStatement ps = con.prepareStatement("DELETE FROM skills WHERE skill_id = ?");
            ps.setInt(1, skillId);
            ps.executeUpdate();
            response.sendRedirect("profile.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
