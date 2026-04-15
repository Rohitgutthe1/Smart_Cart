<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Login - SmartCart</title>

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

            /* Background Image + Overlay */
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                        url('https://images.unsplash.com/photo-1607083206968-13611e3d76db') 
                        no-repeat center center/cover;
        }

        /* Glass Card */
        .login-card {
            width: 380px;
            padding: 20px;
            border-radius: 20px;
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 30px rgba(0,0,0,0.3);
            color: white;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .form-control {
            border-radius: 12px;
            background: rgba(255,255,255,0.9);
            border: none;
        }

        /* Floating Labels */
        .form-floating label {
            color: #555;
        }

        .btn-primary {
            border-radius: 12px;
            background: linear-gradient(45deg, #00c6ff, #0072ff);
            border: none;
            transition: 0.3s;
            font-weight: 600;
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(0, 114, 255, 0.5);
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
        }

        .subtitle {
            font-size: 14px;
            opacity: 0.8;
        }
    </style>
</head>

<body>

<div class="login-card">

    <div class="text-center mb-4">
        <h3 class="title">SmartCart 🛒</h3>
        <p class="subtitle">Login to continue shopping</p>
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

    <!-- LOGIN FORM -->
    <form action="<%=request.getContextPath()%>/login" method="post">

        <!-- Email -->
        <div class="form-floating mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email" required>
            <label>Email address</label>
        </div>

        <!-- Password -->
        <div class="form-floating mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <label>Password</label>
        </div>

        <!-- Button -->
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">
                Login
            </button>
        </div>

    </form>

    <!-- REGISTER LINK -->
    <div class="text-center mt-3">
        <p>
            Don’t have an account? 
            <a href="<%=request.getContextPath()%>/register">Register</a>
        </p>
    </div>

</div>

</body>
</html>