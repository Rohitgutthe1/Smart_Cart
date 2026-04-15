<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>SmartCart - Home</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }

        /* 🎬 BACKGROUND (PARALLAX) */
        body {
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da')
                        no-repeat center center fixed;
            background-size: cover;
            color: white;
        }

        /* 🔝 NAVBAR */
        .navbar {
            backdrop-filter: blur(10px);
            background: rgba(0,0,0,0.6);
        }

        .navbar a:hover {
            color: #00c6ff !important;
        }

        /* 🎯 HERO */
        .hero {
            padding: 80px 20px;
            border-radius: 20px;
            text-align: center;
            backdrop-filter: blur(20px);
            background: rgba(255,255,255,0.1);
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
            animation: fadeIn 1s ease;
        }

        .hero h1 {
            text-shadow: 0 0 15px rgba(255,255,255,0.7);
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(30px);}
            to {opacity: 1; transform: translateY(0);}
        }

        /* ✨ FEATURE CARDS */
        .feature-card {
            border-radius: 15px;
            backdrop-filter: blur(15px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            transition: 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-8px) scale(1.05);
            box-shadow: 0 10px 30px rgba(255,255,255,0.2);
        }

        /* 🎨 BUTTONS */
        .btn {
            border-radius: 12px;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn:hover {
            transform: scale(1.07);
        }

        .btn-primary {
            background: linear-gradient(45deg, #007bff, #00c6ff);
            border: none;
        }

        .btn-success {
            background: linear-gradient(45deg, #00c853, #64dd17);
            border: none;
        }

        .btn-warning {
            background: linear-gradient(45deg, #ff9800, #ffc107);
            border: none;
        }

        .btn-dark {
            background: linear-gradient(45deg, #343a40, #000);
            border: none;
        }

        /* HERO BUTTON */
        .hero .btn {
            background: linear-gradient(45deg, #ffffff, #dfe9f3);
            color: black;
            font-weight: 600;
        }

        .hero .btn:hover {
            box-shadow: 0 5px 25px rgba(255,255,255,0.6);
        }

        h1, h3, h5 {
            font-weight: 600;
        }
        .feature-card h5,
.feature-card h5 {
    color: #ffffff;
    font-weight: 600;
}

.feature-card p {
    color: #dddddd;
}

    </style>
</head>

<body>

<!-- 🔝 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark px-4">
    <a class="navbar-brand" href="#">SmartCart 🛒</a>

    <div class="ms-auto">
        <a href="<%=request.getContextPath()%>/product?action=list" class="btn btn-outline-light me-2">
            Products
        </a>

        <a href="<%=request.getContextPath()%>/cart?action=view" class="btn btn-outline-light me-2">
            Cart
        </a>

        <a href="<%=request.getContextPath()%>/order?action=list" class="btn btn-outline-light me-2">
            Orders
        </a>

        <%
            if (user != null) {
        %>
            <span class="text-white me-3">
                Welcome, <%= user.getName() %>
            </span>

            <a href="<%=request.getContextPath()%>/logout" class="btn btn-danger btn-sm">
                Logout
            </a>
        <%
            } else {
        %>
            <a href="<%=request.getContextPath()%>/login" class="btn btn-success btn-sm">
                Login
            </a>
        <%
            }
        %>
    </div>
</nav>

<!-- 🎯 HERO -->
<div class="container mt-5">
    <div class="hero">
        <h1>Welcome to SmartCart 🛒</h1>
        <p>Your Smart Shopping Companion</p>

        <a href="<%=request.getContextPath()%>/product?action=list" 
           class="btn mt-3">
            Start Shopping
        </a>
    </div>
</div>

<!-- 🔥 FEATURES -->
<div class="container mt-5">
    <h3 class="mb-4">Why Choose Us?</h3>

    <div class="row g-4">

        <div class="col-md-4">
            <div class="card feature-card text-center p-3">
                <i class="fa fa-truck fa-2x text-primary"></i>
                <h5 class="mt-3">Fast Delivery</h5>
                <p>Get your products delivered quickly.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card feature-card text-center p-3">
                <i class="fa fa-lock fa-2x text-success"></i>
                <h5 class="mt-3">Secure Payment</h5>
                <p>100% safe transactions.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card feature-card text-center p-3">
                <i class="fa fa-tags fa-2x text-warning"></i>
                <h5 class="mt-3">Best Deals</h5>
                <p>Exciting offers & discounts.</p>
            </div>
        </div>

    </div>
</div>

<!-- 🛍️ QUICK ACTIONS -->
<div class="container mt-5 mb-5">
    <h3 class="mb-4">Quick Actions</h3>

    <div class="row g-3">

        <div class="col-md-3">
            <a href="<%=request.getContextPath()%>/product?action=list" 
               class="btn btn-primary w-100">
                Browse Products
            </a>
        </div>

        <div class="col-md-3">
            <a href="<%=request.getContextPath()%>/cart?action=view" 
               class="btn btn-success w-100">
                View Cart
            </a>
        </div>

        <div class="col-md-3">
            <a href="<%=request.getContextPath()%>/order?action=list" 
               class="btn btn-warning w-100">
                My Orders
            </a>
        </div>

        <div class="col-md-3">
            <a href="<%=request.getContextPath()%>/login" 
               class="btn btn-dark w-100">
                Login
            </a>
        </div>

    </div>
</div>

</body>
</html>