<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Job</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <style>
        /* Simple styling for the application form */
        .application-form {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            text-align: left;
        }
        .application-form h2 {
            margin-bottom: 20px;
            color: #00c6ff;
        }
        .application-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 16px;
        }
        .application-form button {
            padding: 10px 20px;
            background: #28a745;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .application-form button:hover {
            background: #218838;
        }
    </style>
</head>
<body>
<%
    // Check if the user is logged in and is a freelancer
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equalsIgnoreCase("Freelancer")) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get jobId from request parameter
    int jobId = Integer.parseInt(request.getParameter("jobId"));
%>
<div class="application-form">
    <h2>Apply for Job</h2>
    <form action="ApplyJobServlet" method="post">
        <!-- Pass the jobId using a hidden field -->
        <input type="hidden" name="jobId" value="<%= jobId %>">
        <label for="proposal">Your Proposal:</label><br>
        <textarea id="proposal" name="proposal" rows="6" required placeholder="Write a brief proposal..."></textarea>
        <button type="submit">Submit Application</button>
    </form>
</div>
</body>
</html>
