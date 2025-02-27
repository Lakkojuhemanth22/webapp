<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }
    body {
        background: linear-gradient(to right, #064c6f, #060404f2);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .welcome-container {
        background: rgba(255, 255, 255, 0.1);
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        backdrop-filter: blur(10px);
        text-align: center;
        width: 400px;
        color: white;
        animation: fadeIn 0.8s ease-in-out;
    }
    h1 {
        font-size: 26px;
        margin-bottom: 10px;
        text-transform: uppercase;
    }
    p {
        font-size: 18px;
        margin-bottom: 20px;
    }
    .logout-button {
        padding: 12px 20px;
        background-color: #ff4b5c;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        text-decoration: none;
        transition: 0.3s;
        display: inline-block;
    }
    .logout-button:hover {
        background-color: #d43f50;
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
    <div class="welcome-container">
        <h1>Welcome!</h1>
        <p>Login successful!</p>
        <p>Welcome, <%= request.getAttribute("username") != null ? request.getAttribute("username") : "User" %>!</p>
        <a href="login.jsp" class="logout-button">Logout</a>
        
    </div>
    
    <div class="card" style="width: 18rem;">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
</div>
</body>
</html>

