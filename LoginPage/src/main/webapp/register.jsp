<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="icon" href="https://static-00.iconduck.com/assets.00/freelancer-icon-2048x1523-oh0h1scd.png" type="image/icon type">
<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

* {
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
    margin: 0;
    padding: 0;
}

body {
    height: 100%;
    background: linear-gradient(135deg, #f5f7fa, #b9c8e1);
    display: flex;
    justify-content: center;
    align-items: center;
}

    h2, h3{
    	color: black;
    }
    
    
    .form-container {
		width: 50%;
        margin: 50px auto;
        padding: 20px;
        background: rgb(255 255 255);
        border-radius: 10px;
        box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        backdrop-filter: blur(10px);
    }
    input, button {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
       	border: 1px solid #ddd;
        border-radius: 5px;
        background: rgb(14 14 14 / 0%);
        color: #000000;
        font-size: 16px;
    }
    button {
        background: #00c6ff;
        color: white;
        width: 20%;
        font-size: 18px;
        cursor: pointer;
    }
    button:hover {
        background: #0072ff;
    }
    .skill-container {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;
        margin-top: 10px;
    }
    .skill-tag {
        background: #0072ff00;
        color:  #000000;
        border: 1px solid #00c6ff;
        padding: 6px;
        height: 20px;
        border-radius: 15px;
        display: flex;
        align-items: center;
    }
    .skill-tag button {
        background: none;
        border: none;
        color:  #000000;
        font-weight: bold;
        cursor: pointer;
        margin-left: 5px;
    }
    select {
        background-color: #fbfeff;
	    color: #000000;
	    cursor: pointer;
	    border-radius: 20px;
	    padding: 5px;
	    border: 1px solid #00c6ff;
	    font-size: 16px;
	    margin-bottom: 20px;
    }
    select:focus {
        outline: none;
        border: 1px solid #0072ff;
        border-radius: 20px;
    }
    select option {
        background-color: #fbfeff;
        color: #000000;
    }
    select::-ms-expand {
        display: none;
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
</style>
<script>
    function addSkill() {
        let skillInput = document.getElementById("skillInput");
        let skill = skillInput.value.trim();
        if (skill === "") return;

        let skillContainer = document.getElementById("skillContainer");

        // Check for duplicate skills
        let existingSkills = document.querySelectorAll(".skill-tag span");
        for (let s of existingSkills) {
            if (s.textContent === skill) {
                skillInput.value = "";
                return;
            }
        }

        // Create skill tag
        let skillTag = document.createElement("div");
        skillTag.classList.add("skill-tag");

        let skillSpan = document.createElement("span");
        skillSpan.textContent = skill;
        skillTag.appendChild(skillSpan);

        let removeBtn = document.createElement("button");
        removeBtn.textContent = "×";
        removeBtn.onclick = function() {
            skillContainer.removeChild(skillTag);
        };
        skillTag.appendChild(removeBtn);

        skillContainer.appendChild(skillTag);

        // Add hidden input for backend submission
        let hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "skills";
        hiddenInput.value = skill;
        skillTag.appendChild(hiddenInput);

        // Clear input field
        skillInput.value = "";
    }
    
    function toggleSkillsVisibility() {
        const role = document.getElementById("roleSelect").value;
        const skillContainer = document.getElementById("skillsSection");
        
        if (role === "Client") {
            skillContainer.style.display = "none";
        } else {
            skillContainer.style.display = "block";
        }
    }
</script>
</head>
<body>

<div class="form-container">
    <h2>Register</h2>
    <form action="RegisterServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        
         <select name="role" id="roleSelect" required onchange="toggleSkillsVisibility()">
            <option value="Freelancer">Freelancer</option>
            <option value="Client">Client</option>
        </select>
        
        <div id="skillsSection">
            <h3>Skills</h3>
            <input type="text" id="skillInput" placeholder="Enter skill">
            <button type="button" onclick="addSkill()">Add</button>

            <div id="skillContainer" class="skill-container"></div>
        </div>

        <br><br>
        <div class="butn"><button type="submit" class="btn">Register</button>
        <button type="reset" class="btn btn-reset">Reset</button></div>
    </form>
    <p>Already have account? <a href="login.jsp" style="color: #00c6ff;">login</a></p>
</div>

</body>
</html>
