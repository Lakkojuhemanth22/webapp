Freelance Job Portal

🚀 A web-based freelance job marketplace where clients can post jobs and freelancers can apply, search, and manage their work efficiently.

📌 Features
✅ User Authentication (Register/Login)
✅ Role-based Dashboard (Client & Freelancer)
✅ Job Posting & Management (Clients)
✅ Job Applications & Tracking (Freelancers)
✅ Search & Filter Jobs (Trie, Binary Search)
✅ Real-Time Notifications (Multi-threading, Queues)
✅ Reviews & Ratings System

📂 Project Structure
freelance-job-portal/
│── src/
│   ├── main/
│   │   ├── java/com/freelanceportal/
│   │   │   ├── controllers/       # Servlets for handling requests
│   │   │   ├── dao/               # Database operations
│   │   │   ├── models/            # Java objects representing entities
│   │   │   ├── utils/             # Utility classes (DB connection, hashing, etc.)
│   │   ├── webapp/
│   │   │   ├── assets/            # CSS, JS, images
│   │   │   ├── views/             # JSP pages for UI
│   │   │   ├── WEB-INF/           # Deployment descriptors
│   ├── test/                      # Unit tests
│── pom.xml                         # Maven dependencies
│── README.md                       # Project documentation
│── sql/                            # Database scripts
│── .gitignore                       # Files to ignore in Git

⚙️ Technologies Used
Frontend
HTML, CSS, Bootstrap → User interface
JavaScript, AJAX → Dynamic interactions
Backend
Java (JSP & Servlets) → Server-side logic
MySQL → Data storage
Session-based authentication
Tools & Libraries
JDBC (Database Connectivity)
Apache Tomcat (Server)
Maven (Dependency Management)
BCrypt (Password Hashing)

🚀 Installation & Setup
1️⃣ Clone the Repository
git clone https://github.com/your-username/freelance-job-portal.git
cd freelance-job-portal

2️⃣ Setup Database
Create a MySQL database:
CREATE DATABASE freelance_portal;
Import the SQL schema from sql/freelance_portal.sql

Update DBConnection.java with your database credentials:
private static final String URL = "jdbc:mysql://localhost:3306/freelance_portal";
private static final String USER = "root";
private static final String PASSWORD = "yourpassword";

3️⃣ Configure & Run the Server
Open the project in VS Code / Eclipse / IntelliJ
Ensure Apache Tomcat is installed and configured
Deploy the project using Tomcat

💡 Features Overview & API Routes
🔹 1. User Authentication
POST /register → User Signup
POST /login → User Login

🔹 2. Job Management
GET /jobs → Fetch all jobs
POST /jobs/create → Client posts a new job

🔹 3. Job Application
POST /apply → Freelancer applies for a job
GET /applications → View applications

🔹 4. Search & Filters
GET /search?query=keyword → Search for jobs
GET /filter?category=webdev → Filter jobs

🎯 Future Enhancements
🔹 Graph-based Smart Job Recommendation
🔹 Priority Queue for Resume Ranking
🔹 WebSocket-based Real-Time Notifications
🔹 OAuth2 Integration for Social Login

💬 Contributing
Want to contribute?
Fork the repo
Create a new branch: git checkout -b feature-branch
Commit your changes: git commit -m "Added new feature"
Push to the branch: git push origin feature-branch
Open a Pull Request 🚀

📜 License
This project is open-source under the MIT License.

📞 Contact
👨‍💻 Developed by Hemanth Lakkoju
📧 Email: hemanthlakkoju2212@gmail.com
🔗 LinkedIn: (https://www.linkedin.com/in/hemanth-lakkoju-827180270)

💙 If you liked this project, don't forget to ⭐ star the repo! 🚀
