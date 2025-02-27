package website;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JobTrie;

@WebServlet("/JobSuggestionServlet")
public class JobSuggestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static JobTrie jobTrie = new JobTrie();
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        List<String> suggestions = jobTrie.searchSuggestions(query);
        
        // Convert list to JSON format
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(suggestions);

        // Ensure proper JSON response headers
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        response.getWriter().write(jsonResponse);
    }

}
