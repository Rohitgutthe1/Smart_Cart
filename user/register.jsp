<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration - SmartCart</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }

        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;

            /* 🔥 BEST PREMIUM BACKGROUND */
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
                        url('https://images.unsplash.com/photo-1542291026-7eec264c27ff')
                        no-repeat center center/cover;
        }

        /* ✨ Glass Card */
        .register-card {
            width: 420px;
            padding: 25px;
            border-radius: 20px;
            backdrop-filter: blur(25px);
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 40px rgba(0,0,0,0.5);
            color: white;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(30px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .form-control {
            border-radius: 12px;
            background: rgba(255,255,255,0.9);
            border: none;
        }

        .form-floating label {
            color: #555;
        }

        /* 🔥 Button */
        .btn-success {
            border-radius: 12px;
            background: linear-gradient(45deg, #00c853, #64dd17);
            border: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-success:hover {
            transform: scale(1.07);
            box-shadow: 0 5px 25px rgba(0, 255, 100, 0.6);
        }

        a {
            color: #fff;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        .title {
            font-weight: 600;
            letter-spacing: 1px;
        }

        .subtitle {
            font-size: 14px;
            opacity: 0.85;
        }
    </style>
</head>

<body>

<div class="register-card">

    <div class="text-center mb-4">
        <h3 class="title">Join SmartCart 🛒</h3>
        <p class="subtitle">Create your account now</p>
    </div>

    <!-- ERROR MESSAGE -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger text-center">
            <%= error %>
        </div>
    <%
        }
    %>

    <!-- REGISTER FORM -->
    <form action="<%=request.getContextPath()%>/register" method="post">

        <!-- Name -->
        <div class="form-floating mb-3">
            <input type="text" name="name" class="form-control" placeholder="Name" required>
            <label>Full Name</label>
        </div>

        <!-- Email -->
        <div class="form-floating mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email" required>
            <label>Email Address</label>
        </div>

        <!-- Password -->
        <div class="form-floating mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <label>Password</label>
        </div>

        <!-- Confirm Password -->
        <div class="form-floating mb-3">
            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
            <label>Confirm Password</label>
        </div>

        <!-- Button -->
        <div class="d-grid">
            <button type="submit" class="btn btn-success">
                Create Account
            </button>
        </div>

    </form>

    <!-- LOGIN LINK -->
    <div class="text-center mt-3">
        <p>
            Already have an account? 
            <a href="<%=request.getContextPath()%>/login">Login</a>
        </p>
    </div>

</div>

<!-- 🔐 PASSWORD MATCH VALIDATION -->
<script>
    const form = document.querySelector("form");
    const password = document.querySelector("input[name='password']");
    const confirmPassword = document.getElementById("confirmPassword");

    form.addEventListener("submit", function(e) {
        if (password.value !== confirmPassword.value) {
            e.preventDefault();
            alert("Passwords do not match!");
        }
    });
</script>

</body>
</html>