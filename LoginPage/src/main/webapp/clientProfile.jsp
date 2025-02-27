<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Check for logged in user
    String username = (String) session.getAttribute("username");
    if(username == null){
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Establish database connection
    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    // Retrieve user's email
    String email = "";
    try {
        PreparedStatement psEmail = con.prepareStatement("SELECT email FROM users WHERE username = ?");
        psEmail.setString(1, username);
        ResultSet rsEmail = psEmail.executeQuery();
        if(rsEmail.next()){
            email = rsEmail.getString("email");
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Boxicons -->
	<link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet">
	<!-- My CSS -->
	<link rel="stylesheet" href="styles/client.css">
	<title>Client Profile</title>
	<style>
	    /* Basic styling for content sections */
	    .content-section { display: none; }
	    .content-section.active { display: block; }
	    .logo img{
              width: 50px;
		}
		        
		.logo{
		     display: flex;
		     padding: 20px;
		}
		
		.logo span{
			width: 50px;
			font-size: 23px;
		}
	</style>
</head>
<body>

	<!-- SIDEBAR -->
	<section id="sidebar">
		<div class="logo">
          	<a href="home.jsp"><img alt="" src="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png"></a>
         	<span>FreeLax</span>
        </div>
		<ul class="side-menu top">
			<li class="active">
				<a href="javascript:void(0)" onclick="showSection('dashboard')">
					<i class='bx bxs-dashboard'></i>
					<span class="text">Dashboard</span>
				</a>
			</li>
			<li>
				<a href="javascript:void(0)" onclick="showSection('projects')">
					<i class='bx bxs-shopping-bag-alt'></i>
					<span class="text">Jobs Posted</span>
				</a>
			</li>
			<li>
				<a href="javascript:void(0)" onclick="showSection('portfolio')">
					<i class='bx bxs-doughnut-chart'></i>
					<span class="text">Job Application</span>
				</a>
			</li>
			<li>
				<a href="javascript:void(0)" onclick="showSection('messages')">
					<i class='bx bxs-message-dots'></i>
					<span class="text">Messages</span>
				</a>
			</li>
		</ul>
		<ul class="side-menu">
			<li>
				<a href="home.jsp">
					<i class='bx bx-home' ></i>
					<span class="text">Home</span>
				</a>
			</li>
			<li>
				<a href="LogoutServlet" class="logout">
					<i class='bx bx-log-out'></i>
					<span class="text">Logout</span>
				</a>
			</li>
		</ul>
	</section>
	<!-- SIDEBAR -->

	<!-- CONTENT -->
	<section id="content">
		<!-- NAVBAR -->
		<nav>
			<i class='bx bx-menu'></i>
			<a href="#" class="nav-link">Categories</a>
			<form action="#">
				<div class="form-input">
					<input type="search" placeholder="Search...">
					<button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
				</div>
			</form>
			<a href="notification.jsp" class="notification">
				<i class='bx bxs-bell'></i>
			</a>
			<a href="#" class="profile">
				<img src="https://static.vecteezy.com/system/resources/thumbnails/020/911/740/small_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png"  alt="profile pic" alt="profile">
			</a>
		</nav>
		<!-- NAVBAR -->

		<!-- MAIN CONTENT -->
		<main>
			<!-- Dashboard Section -->
			<section id="dashboard" class="content-section active">
				<div class="head-title">
					<div class="left">
						<h1>Client Profile</h1>
					</div>
				</div>

				<div class="profile-section">
					<h2>Profile Details</h2>
					<div id="profile-info">
						<p><strong>Username:</strong> <span id="username"><%= username %></span></p>
						<p><strong>Email:</strong> <span id="email"><%= email %></span></p>
					</div>

					<h2>Update Profile</h2>
					<form id="updateProfileForm" action="UpdateProfileServlet" method="post">
						<label for="updateEmail">Email: </label>
						<input type="email" id="updateEmail" name="email" placeholder="Update Email" value="<%= email %>">
						<button type="submit">Update Profile</button>
					</form>
					
				</div>
			</section>

			<!-- My Projects Section -->
			<section id="projects" class="content-section">
				<div class="head-title">
					<div class="left">
						<h1>Jobs</h1>
					</div>
				</div>
				
				        <h2>Post a Job</h2>
					    <form action="JobPostServlet" method="post" class="form-container">
					        <input type="text" name="jobTitle" placeholder="Job Title" required>
					        <textarea name="jobDescription" placeholder="Job Description" rows="4" required></textarea>
					        <button type="submit" class="btn">Post Job</button>
					    </form>
				    
				<h2>Your Posted Jobs</h2>
    <ul>
        <%
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
            PreparedStatement psProjects = con.prepareStatement("SELECT job_title, job_description, job_id FROM jobs WHERE client_id = (SELECT user_id FROM users WHERE username = ?)");
            psProjects.setString(1, username);
            ResultSet rsProjects = psProjects.executeQuery();
            while (rsProjects.next()) {
                String projectName = rsProjects.getString("job_title");
                String projectDesc = rsProjects.getString("job_description");
                int projectId = rsProjects.getInt("job_id");
        %>
            <li class="item">
                <b><%= projectName %></b><br>
                <%= projectDesc %>
                <form action="DeleteJobServlet" method="post" style="display:inline;">
                    <input type="hidden" name="job_id" value="<%= projectId %>">
                    <button type="submit" class="btn logout-btn">Delete</button>
                </form>
            </li>
        <% 
            }
            rsProjects.close();
            psProjects.close();
        %>
    </ul>
				<!-- You can also include a form here to add new projects if needed -->
			</section>

			<!-- Portfolio Section (Placeholder) -->
			<section id="portfolio" class="content-section">
				<div class="head-title">
					<div class="left">
						<h1>Portfolio</h1>
					</div>
				</div>
				<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    // Retrieve all job applications for jobs posted by the logged-in client.
    String sql = "SELECT ja.application_id, ja.proposal, j.job_title, j.job_description, u.username " +
                 "FROM job_applications ja " +
                 "JOIN jobs j ON ja.job_id = j.job_id " +
                 "JOIN users u ON ja.freelancer_id = u.user_id " +
                 "WHERE j.client_id = (SELECT user_id FROM users WHERE username = ?)";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
%>

<div class="container">
    <h1>Applications for Your Jobs</h1>
    <%
        boolean hasApplications = false;
        while(rs.next()){
            hasApplications = true;
    %>
        <div class="application">
            <div class="details">
            <p><strong>Freelancer:</strong> <%= rs.getString("username") %></p>
            <p><strong>Job Title:</strong> <%= rs.getString("job_title") %></p>
            <p><strong>Job Description:</strong> <%= rs.getString("job_description") %></p>
            <p><strong>Proposal:</strong> <%= rs.getString("proposal") %></p>
            </div>
            <div>
            <a href="AcceptApplicationServlet?applicationId=<%= rs.getInt("application_id") %>" class="btn">Accept</a>
			<a href="RejectApplicationServlet?applicationId=<%= rs.getInt("application_id") %>" class="reject_btn">Reject</a>
            </div>

        </div>
    <%
        }
        if(!hasApplications){
    %>
        <p>No applications received yet.</p>
    <%
        }
        rs.close();
        ps.close();
        con.close();
    %>
 </div>
			</section>

			<!-- Messages Section (Placeholder) -->
			<section id="messages" class="content-section">
				<div class="head-title">
					<div class="left">
						<h1>Messages</h1>
					</div>
				</div>
				<p>Messages content goes here...</p>
			</section>

		</main>
		<!-- MAIN CONTENT -->
	</section>
	<!-- CONTENT -->

	<script>
	    // JavaScript to toggle between sections
	    function showSection(sectionId) {
	        // Hide all content sections
	        var sections = document.querySelectorAll('.content-section');
	        sections.forEach(function(sec){
	            sec.classList.remove('active');
	        });
	        // Show the selected section
	        document.getElementById(sectionId).classList.add('active');
	    }
	</script>
	
	<script src="freelance.js"></script>
</body>
</html>
<%
    // Close connection if open
    if(con != null) {
        try { con.close(); } catch(Exception e) { e.printStackTrace(); }
    }
%>
