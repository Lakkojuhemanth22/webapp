<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Jobs</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
        body {
            font-family: "Poppins", sans-serif;
            background: #ffffff00;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 32px rgba(65 123 157 / 37%);
    		backdrop-filter: blur(10px);
            width: 100%;
            max-width: 800px;
        }
        .container h1 {
            font-size: 32px;
            color: black;
            margin-bottom: 20px;
            text-align: center;
        }
        .search-bar {
            display: flex;
            margin-bottom: 20px;
            gap: 10px;
        }
        .search-bar input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            outline: none;
        }
        .search-bar button {
            padding: 12px 20px;
            background-color: #007bff;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }
        .search-bar button:hover {
            background-color: #0056b3;
        }
        .job-card {
            background-color: #ffffff00;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 8px 32px rgb(173 161 161 / 37%) ;
    		backdrop-filter: blur(10px);
            margin-bottom: 20px;
        }
        .job-card h3 {
            color: black;
            font-size: 22px;
            margin-bottom: 10px;
        }
        .job-card p {
            color: black;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .job-card small {
            color: #787878;
            font-size: 14px;
            display: block;
            margin-bottom: 10px;
        }
        .apply-btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .apply-btn:hover {
            background-color: #218838;
        }
        .no-jobs {
            text-align: center;
            font-size: 18px;
            color: #555;
            margin-top: 20px;
        }
    </style>
    <script>
    function fetchJobSuggestions() {
        let query = document.getElementById("jobSearch").value;
        if (query.length < 2) return;

        fetch("JobSuggestionServlet?query=" + query)
            .then(response => response.json())
            .then(data => {
                let suggestionList = document.getElementById("suggestions");
                suggestionList.innerHTML = "";
                data.forEach(job => {
                    let item = document.createElement("li");
                    item.innerText = job;
                    item.onclick = () => document.getElementById("jobSearch").value = job;
                    suggestionList.appendChild(item);
                });
            });
    }
    </script>
</head>
<body>

<%
    // Ensure the user is a freelancer
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Freelancer")) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
    
    // Fetch search parameters
    String jobSearchQuery = request.getParameter("jobSearchQuery");
    String clientSearchQuery = request.getParameter("clientSearchQuery");

    // Base SQL query
    String sql = "SELECT j.job_id, j.job_title, j.job_description, u.username AS client_name " +
                 "FROM jobs j " +
                 "JOIN users u ON j.client_id = u.user_id";

    // Dynamically modify SQL query if search terms exist
    boolean hasJobSearch = (jobSearchQuery != null && !jobSearchQuery.isEmpty());
    boolean hasClientSearch = (clientSearchQuery != null && !clientSearchQuery.isEmpty());

    if (hasJobSearch || hasClientSearch) {
        sql += " WHERE";
        if (hasJobSearch) {
            sql += " j.job_title LIKE ? OR j.job_description LIKE ?";
        }
        if (hasClientSearch) {
            if (hasJobSearch) sql += " OR"; // Add OR if both are present
            sql += " u.username LIKE ?";
        }
    }

    PreparedStatement ps = con.prepareStatement(sql);

    // Set parameters dynamically
    int paramIndex = 1;
    if (hasJobSearch) {
        ps.setString(paramIndex++, "%" + jobSearchQuery + "%");
        ps.setString(paramIndex++, "%" + jobSearchQuery + "%");
    }
    if (hasClientSearch) {
        ps.setString(paramIndex++, "%" + clientSearchQuery + "%");
    }

    ResultSet rs = ps.executeQuery();
%>

<div class="container">
    <h1>Search Jobs</h1>

    <!-- Job & Client Search Bar -->
    <form class="search-bar" method="get">
    	<input type="text" id="jobSearch" onkeyup="fetchJobSuggestions()" placeholder="Search jobs by title..." autocomplete="off">
        <ul id="suggestions"></ul>
        <input type="text" name="clientSearchQuery" placeholder="Search by client name..." value="<%= (clientSearchQuery != null) ? clientSearchQuery : "" %>">
        <button type="submit">Search</button>
    </form>

    <!-- Job Listings -->
    <%
        boolean jobsAvailable = false;
        while (rs.next()) {
            jobsAvailable = true;
    %>
        <div class="job-card">
            <h3><%= rs.getString("job_title") %></h3>
            <p><%= rs.getString("job_description") %></p>
            <small>Posted by: <strong><%= rs.getString("client_name") %></strong></small>
            <a href="applyJob.jsp?jobId=<%= rs.getInt("job_id") %>" class="apply-btn">Apply Now</a>
        </div>
    <%
        }
        if (!jobsAvailable) {
    %>
        <p class="no-jobs">No jobs found. Try searching again.</p>
    <%
        }
    %>
</div>

</body>
</html>
