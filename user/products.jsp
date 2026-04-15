<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Product" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Products - SmartCart</title>

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

        /* 🔥 Background */
        body {
            background: linear-gradient(to right, #eef2f3, #dfe9f3);
        }

        /* ✨ Glass Navbar */
        .navbar {
            background: rgba(40, 116, 240, 0.9);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 600;
            letter-spacing: 1px;
        }

        /* 🔥 Product Card */
        .product-card {
            border: none;
            border-radius: 15px;
            transition: 0.3s;
            background: #fff;
        }

        .product-card:hover {
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .product-img {
            height: 180px;
            object-fit: contain;
            padding: 10px;
        }

        .price {
            font-size: 18px;
            font-weight: 600;
            color: #28a745;
        }

        /* Buttons */
        .btn-warning {
            background: linear-gradient(45deg, #ff9800, #ffc107);
            border: none;
        }

        .btn-warning:hover {
            transform: scale(1.05);
        }

        .btn-outline-primary:hover {
            background-color: #2874f0;
            color: #fff;
        }

        /* Search */
        .form-control {
            border-radius: 10px;
        }

        /* Pagination */
        .btn-outline-primary {
            border-radius: 8px;
        }

    </style>
</head>

<body>

<!-- 🔝 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark px-4 shadow">
    <a class="navbar-brand text-white" href="#">SmartCart 🛒</a>

    <!-- SEARCH -->
    <form class="d-flex ms-4" action="<%=request.getContextPath()%>/product">
        <input type="hidden" name="action" value="search">

        <input class="form-control me-2" type="search" name="keyword" placeholder="Search products...">
        <button class="btn btn-light">
            <i class="fa fa-search"></i>
        </button>
    </form>

    <div class="ms-auto">
        <a href="<%=request.getContextPath()%>/cart?action=view" class="btn btn-light me-2">
            <i class="fa fa-shopping-cart"></i>
        </a>

        <a href="<%=request.getContextPath()%>/order?action=list" class="btn btn-light me-2">
            Orders
        </a>

        <a href="<%=request.getContextPath()%>/logout" class="btn btn-danger">
            Logout
        </a>
    </div>
</nav>

<!-- 🛍️ PRODUCTS -->
<div class="container mt-4">

    <div class="row">

        <%
            if (products != null && !products.isEmpty()) {
                for (Product p : products) {
        %>

        <div class="col-md-3 mb-4">
            <div class="card product-card shadow-sm text-center p-2">

                <!-- IMAGE -->
                <img src="<%=request.getContextPath()%>/uploads/<%=p.getImage()%>" 
                     class="product-img">

                <!-- NAME -->
                <h6 class="mt-2"><%= p.getName() %></h6>

                <!-- PRICE -->
                <p class="price">₹ <%= p.getPrice() %></p>

                <!-- ACTIONS -->
                <div class="d-grid gap-2">

                    <!-- ADD TO CART -->
                    <form action="<%=request.getContextPath()%>/cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%=p.getId()%>">
                        <input type="hidden" name="quantity" value="1">

                        <button class="btn btn-warning btn-sm">
                            <i class="fa fa-cart-plus"></i> Add to Cart
                        </button>
                    </form>

                    <!-- VIEW DETAILS -->
                    <a href="<%=request.getContextPath()%>/product?action=view&id=<%=p.getId()%>" 
                       class="btn btn-outline-primary btn-sm">
                        View Details
                    </a>

                </div>

            </div>
        </div>

        <%
                }
            } else {
        %>

        <div class="text-center mt-5">
            <h5>No Products Found</h5>
        </div>

        <%
            }
        %>

    </div>

    <!-- 🔢 PAGINATION -->
    <div class="text-center mt-3">
        <%
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");

            if (currentPage != null && totalPages != null) {
                for (int i = 1; i <= totalPages; i++) {
        %>

            <a href="<%=request.getContextPath()%>/product?action=list&page=<%=i%>" 
               class="btn btn-sm <%= (i == currentPage) ? "btn-primary" : "btn-outline-primary" %>">
                <%= i %>
            </a>

        <%
                }
            }
        %>
    </div>

</div>

</body>
</html>