package utils;

import java.sql.*;
import java.util.List;

public class JobService {
    private JobTrie jobTrie = new JobTrie();

    public JobService() {
        loadJobsFromDatabase();
    }

    // Load job titles from MySQL and insert into Trie
    private void loadJobsFromDatabase() {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root")) {
            String query = "SELECT job_title FROM jobs";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                jobTrie.insert(rs.getString("job_title"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get job suggestions based on input
    public List<String> getJobSuggestions(String prefix) {
        return jobTrie.searchSuggestions(prefix);
    }
}
