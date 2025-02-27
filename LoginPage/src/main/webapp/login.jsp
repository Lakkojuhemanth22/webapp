<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
<link rel="stylesheet" href="styles/login.css">
<style>
    .container {
        background: rgb(255 255 255);
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        backdrop-filter: blur(10px);
        text-align: center;
        width: 40%;
        color: white;
        animation: fadeIn 0.8s ease-in-out;
    }
    h1 {
        font-size: 26px;
        color: black;
        margin-bottom: 20px;
        text-transform: uppercase;
    }
    
    p{
    	color: black;
    }
    
    .error-message {
        color: #ff4b5c;
        margin-bottom: 15px;
        font-size: 14px;
    }
    
    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
       	border: 1px solid #ddd;
        border-radius: 5px;
        background: rgb(14 14 14 / 0%);
        color: #000000;
        font-size: 16px;
    }
    input::placeholder {
        color: #000000;
    }
    input:focus {
        outline: none;
        background: rgba(255, 255, 255, 0.3);
    }
    .btn {
        width: 100px;
        padding: 12px;
        background: #00c6ff;
        border: none;
        border-radius: 5px;
        color: white;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
        margin-bottom: 12px;

    }
    .btn:hover {
        background: #0072ff;
    }
    .btn-reset {
        background: #ff4b5c;
    }
    .btn-reset:hover {
        background: #d43f50;
    }
    .butn{
    	display: flex;
    	justify-content: space-between;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <%-- Display error message if login fails --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p class="error-message"><%= errorMessage %></p>
        <%
            }
        %>

        <form action="LoginServlet" method="post" >
        	<div class="input-group">
            <input type="text" name="txtName" placeholder="Enter Username" required>
            </div>
            <div class="input-group">
            <input type="password" name="txtPassword" placeholder="Enter Password" required>
            </div>
            <div class="butn"><button type="submit" class="btn">Login</button>
            <button type="reset" class="btn btn-reset">Reset</button></div>
        </form>
         <p>New account? <a href="register.jsp" style="color: #00c6ff;">register</a></p>
    </div>
</body>
</html>
