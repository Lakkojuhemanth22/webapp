<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Job Applications</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <style>
        body {
            background: linear-gradient(to right, #064c6f, #060404f2);
            color: white;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            backdrop-filter: blur(10px);
            text-align: center;
        }
        h1 {
            font-size: 32px;
            margin-bottom: 20px;
        }
        .job-card {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            position: relative;
        }
        .delete-btn {
            position: absolute;
            top: 10px;
            right: 15px;
            background: #ff0033;
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            padding: 5px 10px;
            font-size: 16px;
        }
        .delete-btn:hover {
            background-color: #cc0022;
        }
        .no-jobs {
            font-size: 18px;
            color: #ddd;
            margin-top: 20px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #00c6ff;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-size: 18px;
        }
        .back-btn:hover {
            background-color: #0072ff;
        }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT ja.application_id, j.job_title, j.job_description FROM job_applications ja " +
        "JOIN jobs j ON ja.job_id = j.job_id WHERE ja.username = ?"
    );
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
%>

<div class="container">
    <h1>My Job Applications</h1>

    <%
        boolean hasApplications = false;
        while (rs.next()) {
            hasApplications = true;
    %>
        <div class="job-card">
            <h3><%= rs.getString("job_title") %></h3>
            <p><%= rs.getString("job_description") %></p>
            <form action="DeleteJobApplicationServlet" method="post" style="display:inline;">
                <input type="hidden" name="application_id" value="<%= rs.getInt("application_id") %>">
                <button type="submit" class="delete-btn">X</button>
            </form>
        </div>
    <%
        }
        if (!hasApplications) {
    %>
        <p class="no-jobs">You haven't applied for any jobs yet.</p>
    <%
        }
    %>
    <a href="home.jsp" class="back-btn">Go Back</a>
</div>

</body>
</html>
