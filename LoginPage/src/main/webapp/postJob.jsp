<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a Job</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }
        .container h1 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-size: 16px;
            color: #333333;
            margin-bottom: 8px;
            display: block;
        }
        .form-group input,
        .form-group textarea {
            width: 570px;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #007bff;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }
        .btn-submit {
            display: block;
            width: 100%;
            padding: 14px;
            font-size: 18px;
            font-weight: 500;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            font-size: 16px;
            color: #007bff;
            text-decoration: none;
        }
        .back-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<% 
    // Check if the user is logged in and is a client
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Client")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="container">
    <h1>Post a New Job</h1>

    <form action="JobPostServlet" method="post">
        <div class="form-group">
            <label for="jobTitle">Job Title:</label>
            <input type="text" id="jobTitle" name="jobTitle" required placeholder="Enter job title">
        </div>

        <div class="form-group">
            <label for="jobDescription">Job Description:</label>
            <textarea id="jobDescription" name="jobDescription" required placeholder="Enter job description"></textarea>
        </div>

        <button type="submit" class="btn-submit">Post Job</button>
    </form>

    <a href="home.jsp" class="back-btn">Back to Home</a>
</div>

</body>
</html>
