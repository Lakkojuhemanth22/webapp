<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.List, website.Job" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Home</title>
    <link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
    <link rel="stylesheet" href="styles/home.css">
    <style>
        .project-author, .job-card .created-by {
            font-size: 14px;
            color: #bbb;
            padding: 0 20px 20px;
        }
        
          .title{
  	padding: 20px;
  }
  
        
        .apply-btn {
            display: inline-block;
            padding: 10px 15px;
            background: linear-gradient(45deg, #28a745, #1e7e34);
            color: white;
            text-decoration: none;
            font-size: 16px;
            border-radius: 8px;
            transition: transform 0.3s, background 0.3s;
        }
        .apply-btn:hover {
            transform: scale(1.08);
            background: linear-gradient(45deg, #1e7e34, #28a745);
        }
        
        .seeMore_btn{
        	display: inline-block;
        	align-item: center;
            padding: 10px 15px;
            background: linear-gradient(45deg, #28a745, #1e7e34);
            color: white;
            text-decoration: none;
            font-size: 16px;
            border-radius: 8px;
            transition: transform 0.3s, background 0.3s;
        }
        
        .seeMore_btn:hover {
            transform: scale(1.08);
            background: linear-gradient(45deg, #1e7e34, #28a745);
        }
        
        .itemcontainer {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin: 15px 0;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 500px;
}

.itemcontainer:hover {
    transform: scale(1.03);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

.itemcontainer b {
    font-size: 18px;
    color: #333;
}

.itemcontainer p {
    font-size: 15px;
    color: #666;
    line-height: 1.5;
}

.itemcontainer .btn {
    background: linear-gradient(45deg, #ff4b2b, #ff416c);
    color: white;
    padding: 8px 12px;
    border-radius: 5px;
    text-align: center;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.2s ease;
    border: none;
}

.itemcontainer .btn:hover {
    background: linear-gradient(45deg, #ff416c, #ff4b2b);
    transform: scale(1.05);
}
        
        
    </style>
</head>
<body>

<% 
    String username = (String) session.getAttribute("username");
	String userRole = (String) session.getAttribute("role");
%>

<div class="navbar">
        <div class="logo">
          	<a href="home.jsp"><img alt="" src="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png"></a>
         	<span>FreeLax</span>
        </div>
        <div class="menu-toggle" onclick="toggleMenu();">
            <i class="fas fa-bars"></i> <!-- Hamburger icon from Font Awesome -->
        </div>
        <nav>
               <ul id="menu">
                <li><a href="index.html">Home</a></li>
                <li><a href="#">More</a></li>
              	<li><a href="#">Jobs</a></li>
              	<li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i></a></li>
              <li>
                	<%
		                // Determine the profile page based on the role
		                String profilePage = "profile.jsp"; // Default
		                if ("Freelancer".equalsIgnoreCase(userRole)) {
		                    profilePage = "profile.jsp";
		                } else if ("Client".equalsIgnoreCase(userRole)) {
		                    profilePage = "clientProfile.jsp";
		                }
		            %>
                    <div class="profile">
			          <a href="<%= profilePage %>" ><img src="https://static.vecteezy.com/system/resources/thumbnails/020/911/740/small_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png"  alt="profile pic"></a>
			        </div>
                </li>
            </ul>
        </nav>
    </div>

<div class="contents">
        <div class="showCase">
            <div class="right fade-in-left">
                <img src="https://png.pngtree.com/png-vector/20240805/ourmid/pngtree-freelancer-software-developer-programmer-coder-illustrator-png-image_13076689.png" alt="">
            </div>
            <div class="left fade-in-right">
                <h1>Welcome, <%= username %>!</h1>
        <p>You are now logged in and can browse projects and apply for jobs!</p>
        
        <% if ("Client".equalsIgnoreCase(userRole)) { %>
            <!-- Client role: Show "Post Job" button -->
            <button class="start_btn" onclick="window.location.href='postJob.jsp'">Post job</button>
        <% } else if ("Freelancer".equalsIgnoreCase(userRole)) { %>
            <!-- Freelancer role: Show "Search for Jobs" button -->
            <button class="start_btn" onclick="window.location.href='searchJobs.jsp'">Seacrh job</button>
        <% } %>
            </div>
        </div>
    </div>

<% 
    // Fetch all projects from all users
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
    String query = "SELECT p.project_id, p.project_name, p.project_description, u.username " + 
                   "FROM projects p " + 
                   "JOIN users u ON p.user_id = u.user_id";
    PreparedStatement ps = con.prepareStatement(query);
    ResultSet rs = ps.executeQuery();
%>

<div class="container">
    <div class="projects-container">
    </div>
</div>

<section class="explore-innovations">
      <h2>Explore Innovations</h2>
      <div class="innovations">
      		
      		<%
        while (rs.next()) {
            String projectName = rs.getString("project_name");
            String projectDescription = rs.getString("project_description");
            String userName = rs.getString("username");
    %>
        <div class="innovation" onclick="openModal('talent-pools')">
        	<img src="ProjectImageServlet?projectId=<%= rs.getInt("project_id") %>" alt="Project Image" style="width:100%; border-radius:8px;">
            <h3><%= projectName %></h3>
            <p><%= projectDescription %></p>
            <div class="project-author">Created by: <%= userName %></div>
        </div>
        
        
    <%
        }
    %>
      </div>
  </section>
<%
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
    String query1 = "SELECT job_id, job_title, job_description FROM jobs ORDER BY RAND() limit 4";
    ps = con.prepareStatement(query1);
    rs = ps.executeQuery();
%>

<% if ("Freelancer".equalsIgnoreCase(userRole)) { %>
            <!-- Client role: Show "Post Job" button -->
<section class="explore-innovations">
<h2 class="title">Available Jobs</h2>
      <div class="innovations">  
    <% while (rs.next()) { %>
        <div class="innovation">
            <h3><%= rs.getString("job_title") %></h3>
            <p><%= rs.getString("job_description") %></p>
            <div class="project-author"><a href="applyJob.jsp?jobId=<%= rs.getInt("job_id") %>" class="apply-btn">Apply Now</a></div>
        </div>
    <% } %>
    	
    	<button class="seeMore_btn" onclick="window.location.href='searchJobs.jsp'">See more</button>
      </div>
  </section>
        <% } else if ("Client".equalsIgnoreCase(userRole)) { %>
            <!-- Freelancer role: Show "Search for Jobs" button -->
            <h2 class="title">Your Posted Jobs</h2>
    <ul>
        <%
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/userdb", "root", "root");
            PreparedStatement psProjects = con.prepareStatement("SELECT job_title, job_description, job_id FROM jobs WHERE client_id = (SELECT user_id FROM users WHERE username = ?)ORDER BY RAND() limit 4");
            psProjects.setString(1, username);
            ResultSet rsProjects = psProjects.executeQuery();
            while (rsProjects.next()) {
                String projectName = rsProjects.getString("job_title");
                String projectDesc = rsProjects.getString("job_description");
                int projectId = rsProjects.getInt("job_id");
        %>
            <li class="item">
                <div class = "itemcontainer">
                <b><%= projectName %></b><br>
                <%= projectDesc %>
                <form action="DeleteJobServlet" method="post" style="display:inline;">
                    <input type="hidden" name="job_id" value="<%= projectId %>">
                    <button type="submit" class="btn logout-btn">Delete</button>
                </form>
                </div>
            </li>
        <% 
            }
            rsProjects.close();
            psProjects.close();
        %>
    </ul>
        <% } %>


<div class="testimonials-section">
    
<h2 class="title">Testimonials</h2>
    <!-- Display Random Testimonials -->
    
</div>

<section id="testimonials" class="testimonials-section">
    <div class="container">
      <div class="testimonial-list">
        <h2 class="section-title">What Our Users Say</h2>
        <%
            String testimonialQuery = "SELECT username, message FROM testimonials ORDER BY RAND() LIMIT 3";
            ps = con.prepareStatement(testimonialQuery);
            rs = ps.executeQuery();
            while (rs.next()) {
        %>
            <div class="testimonial">
            	<div class="testimonial-content">
          			<p>"<%= rs.getString("message") %>"</p>
          		</div>
          		<div class="author-info">
          			<span>- <%= rs.getString("username") %></span>
	                <div class="author-rating">
	                <i class="star-icon">&#9733;</i>
	                <i class="star-icon">&#9733;</i>
	                <i class="star-icon">&#9733;</i>
	                <i class="star-icon">&#9733;</i>
	                <i class="star-icon">&#9733;</i>
              	</div>
				</div>
            </div>
        <% } %>
    </div>
    </div>

    <div class="container-review">
      <div class="testimonial-form">
        <h2 class="section-title">Share Your Experience</h2>
        <form action="SubmitTestimonialServlet" method="post"  class="review-form">
            <div class="form-group">
              <label for="userName">Name</label>
              <input type="text" id="userName" name="username" required placeholder="Enter your name">
          </div>
          <div class="form-group">
              <label for="reviewContent">Review</label>
              <textarea id="reviewContent" name="message" rows="4" required placeholder="Write your review"></textarea>
          </div>
          <div class="form-group">
              <label for="userRating">Rating</label>
              <select id="userRating" name="userRating" required>
                  <option value="" disabled selected>Select rating</option>
                  <option value="1">1 Star</option>
                  <option value="2">2 Stars</option>
                  <option value="3">3 Stars</option>
                  <option value="4">4 Stars</option>
                  <option value="5">5 Stars</option>
              </select>
          </div>
          <button type="submit" class="submit-button">Submit</button>
            
        </form>
    </div>
  </div>
  </section>

<!-- Footer -->
  <footer class="footer">
    <div class="container">
      <div class="footer-links">
        <a href="#about-us">About Us</a>
        <a href="#contact-us">Contact Us</a>
        <a href="#privacy-policy">Privacy Policy</a>
        <a href="#terms-of-service">Terms of Service</a>
      </div>
      <div class="footer-social">
        <a href="https://facebook.com" class="social-icon" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
        <a href="https://twitter.com" class="social-icon" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
        <a href="https://linkedin.com" class="social-icon" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
        <a href="https://instagram.com" class="social-icon" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
      </div>
      <div class="footer-newsletter">
        <h4>Subscribe to Our Newsletter</h4>
        <form action="/subscribe" method="post">
          <input type="email" placeholder="Enter your email" required>
          <button type="submit">Subscribe</button>
        </form>
      </div>
    </div>
  </footer>

</body>
</html>
