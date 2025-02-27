<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Applications</title>
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7fa;
            color: #333;
            text-align: center;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        .application {
            border-bottom: 1px solid #ddd;
            padding: 10px;
        }
        .application:last-child {
            border-bottom: none;
        }
        .btn {
            padding: 8px 15px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
        }
    </style>
</head>
<body>
<%
    // Retrieve jobId from request parameter
    int jobId = Integer.parseInt(request.getParameter("jobId"));

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");

    // Retrieve all applications for this job with freelancer details
    String sql = "SELECT ja.application_id, ja.proposal, u.username, u.role " +
                 "FROM job_applications ja " +
                 "JOIN users u ON ja.freelancer_id = u.user_id " +
                 "WHERE ja.job_id = ?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, jobId);
    ResultSet rs = ps.executeQuery();
%>
<div class="container">
    <h1>Applications for Job ID: <%= jobId %></h1>
    <%
        while(rs.next()){
    %>
        <div class="application">
            <p><strong>Freelancer:</strong> <%= rs.getString("username") %> (<%= rs.getString("role") %>)</p>
            <p><strong>Proposal:</strong> <%= rs.getString("proposal") %></p>
            <!-- Optionally, you can add Accept/Reject buttons here -->
            <a href="AcceptApplicationServlet?applicationId=<%= rs.getInt("application_id") %>" class="btn">Accept</a>
            <a href="RejectApplicationServlet?applicationId=<%= rs.getInt("application_id") %>" class="btn">Reject</a>
        </div>
    <%
        }
        rs.close();
        ps.close();
        con.close();
    %>
</div>
</body>
</html>
