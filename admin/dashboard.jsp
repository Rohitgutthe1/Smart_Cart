<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - SmartCart</title>

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

        /* 🎬 Background */
        body {
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1551288049-bebda4e38f71')
                        no-repeat center center/cover;
            color: white;
        }

        /* Navbar */
        .navbar {
            backdrop-filter: blur(10px);
            background: rgba(0,0,0,0.6);
        }

        /* ✨ Glass Cards */
        .dashboard-card {
            border-radius: 20px;
            backdrop-filter: blur(20px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 30px rgba(0,0,0,0.5);
            transition: 0.3s;
        }

        .dashboard-card:hover {
            transform: translateY(-5px) scale(1.03);
        }

        .dashboard-card i {
            font-size: 28px;
        }

        /* Buttons */
        .btn {
            border-radius: 12px;
            font-weight: 500;
        }

        .btn-outline-primary:hover,
        .btn-outline-success:hover,
        .btn-outline-warning:hover,
        .btn-outline-danger:hover {
            transform: scale(1.05);
        }

        h3, h4, h5 {
            font-weight: 600;
        }

    </style>
</head>

<body>

<!-- 🔝 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark px-4 shadow">
    <a class="navbar-brand" href="#">SmartCart Admin ⚙️</a>

    <div class="ms-auto">
        <a href="<%=request.getContextPath()%>/admin?action=logout" class="btn btn-danger btn-sm">
            Logout
        </a>
    </div>
</nav>

<!-- 📊 DASHBOARD -->
<div class="container mt-4">

    <h3 class="mb-4">Dashboard Overview</h3>

    <div class="row g-4">

        <!-- USERS -->
        <div class="col-md-3">
            <div class="card dashboard-card text-white shadow">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6>Total Users</h6>
                        <h3><%= request.getAttribute("totalUsers") %></h3>
                    </div>
                    <i class="fa fa-users text-primary"></i>
                </div>
            </div>
        </div>

        <!-- PRODUCTS -->
        <div class="col-md-3">
            <div class="card dashboard-card text-white shadow">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6>Total Products</h6>
                        <h3><%= request.getAttribute("totalProducts") %></h3>
                    </div>
                    <i class="fa fa-box text-success"></i>
                </div>
            </div>
        </div>

        <!-- ORDERS -->
        <div class="col-md-3">
            <div class="card dashboard-card text-white shadow">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6>Total Orders</h6>
                        <h3><%= request.getAttribute("totalOrders") %></h3>
                    </div>
                    <i class="fa fa-shopping-cart text-warning"></i>
                </div>
            </div>
        </div>

        <!-- REVENUE -->
        <div class="col-md-3">
            <div class="card dashboard-card text-white shadow">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6>Total Revenue</h6>
                        <h3>₹ <%= request.getAttribute("revenue") %></h3>
                    </div>
                    <i class="fa fa-indian-rupee-sign text-danger"></i>
                </div>
            </div>
        </div>

    </div>

    <!-- 🔧 QUICK ACTIONS -->
    <div class="mt-5">
        <h4>Quick Actions</h4>

        <div class="row g-3 mt-2">

            <div class="col-md-3">
                <a href="<%=request.getContextPath()%>/admin?action=products" class="btn btn-outline-primary w-100">
                    <i class="fa fa-box"></i> Manage Products
                </a>
            </div>

            <div class="col-md-3">
                <a href="<%=request.getContextPath()%>/admin?action=categories" class="btn btn-outline-success w-100">
                    <i class="fa fa-list"></i> Manage Categories
                </a>
            </div>

            <div class="col-md-3">
                <a href="<%=request.getContextPath()%>/admin?action=users" class="btn btn-outline-warning w-100">
                    <i class="fa fa-users"></i> Manage Users
                </a>
            </div>

            <div class="col-md-3">
                <a href="<%=request.getContextPath()%>/admin?action=orders" class="btn btn-outline-danger w-100">
                    <i class="fa fa-shopping-cart"></i> Manage Orders
                </a>
            </div>

        </div>
    </div>

</div>

</body>
</html>