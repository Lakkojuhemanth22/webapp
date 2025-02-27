<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <title>Application Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background:#ffffff;
            padding: 50px;
        }
        .message-box {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
    		backdrop-filter: blur(10px);
            display: inline-block;
        }
        h1 {
            color: #2ee358;
        }
        p
        {
        	color: black;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="message-box">
        <h1>Application Submitted Successfully!</h1>
        <p>Your application for this job has been recorded.</p>
        <a href="home.jsp" class="btn">Back to Job Listings</a>
    </div>

</body>
</html>
