<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - SmartCart</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }

        /* 🎬 Premium Background */
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;

            background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)),
                        url('https://images.unsplash.com/photo-1551288049-bebda4e38f71')
                        no-repeat center center/cover;
        }

        /* ✨ Glass Card */
        .login-card {
            width: 400px;
            border-radius: 20px;
            backdrop-filter: blur(20px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
            color: white;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .card-header {
            background: transparent;
            border-bottom: none;
        }

        .form-control {
            border-radius: 10px;
            background: rgba(255,255,255,0.9);
            border: none;
        }

        /* 🔥 Button */
        .btn-dark {
            border-radius: 10px;
            background: linear-gradient(45deg, #343a40, #000);
            border: none;
            font-weight: 600;
        }

        .btn-dark:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(0,0,0,0.6);
        }

        .card-footer {
            background: transparent;
            border-top: none;
        }

        h4 {
            font-weight: 600;
        }

    </style>
</head>

<body>

<div class="card shadow login-card">

    <div class="card-header text-center">
        <h4>Admin Panel 🔐</h4>
        <p>Login to manage SmartCart</p>
    </div>

    <div class="card-body">

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
        <form action="<%=request.getContextPath()%>/admin" method="post">

            <input type="hidden" name="action" value="login">

            <!-- Username -->
            <div class="mb-3">
                <label>Username</label>
                <input type="text" name="username" class="form-control" placeholder="Enter admin username" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter password" required>
            </div>

            <!-- Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-dark">
                    Login
                </button>
            </div>

        </form>

    </div>

    <div class="card-footer text-center">
        <small>SmartCart Admin Panel</small>
    </div>

</div>

</body>
</html>