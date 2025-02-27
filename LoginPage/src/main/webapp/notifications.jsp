<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Notifications</title>
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7fa;
            color: #333;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .notification {
            background: rgba(0, 0, 0, 0.05);
            padding: 10px;
            margin: 10px 0;
            border-left: 4px solid #007bff;
            text-align: left;
        }
        .notification small {
            color: #777;
        }
    </style>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");

    // Get freelancer_id from username
    String userQuery = "SELECT user_id FROM users WHERE username = ?";
    PreparedStatement ps = con.prepareStatement(userQuery);
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    int freelancerId = -1;
    if(rs.next()){
        freelancerId = rs.getInt("user_id");
    }
    rs.close();
    ps.close();

    String notiQuery = "SELECT message, created_at FROM notifications WHERE freelancer_id = ? ORDER BY created_at DESC";
    ps = con.prepareStatement(notiQuery);
    ps.setInt(1, freelancerId);
    rs = ps.executeQuery();
%>
<div class="container">
    <h1>Your Notifications</h1>
    <%
        while(rs.next()){
    %>
        <div class="notification">
            <p><%= rs.getString("message") %></p>
            <small><%= rs.getTimestamp("created_at") %></small>
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
