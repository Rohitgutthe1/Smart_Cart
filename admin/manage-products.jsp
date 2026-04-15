<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Product" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products - SmartCart</title>

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

        /* ✨ Glass Card */
        .glass-card {
            margin-top: 30px;
            border-radius: 20px;
            backdrop-filter: blur(20px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
        }

        /* Table */
        .table {
            color: white;
        }

        .table thead {
            background: rgba(0,0,0,0.6);
        }

        /* Image */
        img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 10px;
            transition: 0.3s;
        }

        img:hover {
            transform: scale(1.1);
        }

        /* Buttons */
        .btn {
            border-radius: 10px;
            font-weight: 500;
        }

        .btn-success {
            background: linear-gradient(45deg, #00c853, #64dd17);
            border: none;
        }

        .btn-success:hover {
            transform: scale(1.05);
        }

        .btn-warning:hover,
        .btn-danger:hover {
            transform: scale(1.05);
        }

        h3 {
            font-weight: 600;
        }

    </style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mt-4">
        <h3>📦 Manage Products</h3>

        <div>
            <a href="<%=request.getContextPath()%>/product?action=addPage" 
               class="btn btn-success">
                <i class="fa fa-plus"></i> Add Product
            </a>

            <a href="<%=request.getContextPath()%>/admin?action=dashboard" 
               class="btn btn-secondary">
                Dashboard
            </a>
        </div>
    </div>

    <!-- TABLE -->
    <div class="card glass-card shadow">
        <div class="card-body">

            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Category ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                %>

                    <tr>
                        <td><%= p.getId() %></td>

                        <td>
                            <img src="<%=request.getContextPath()%>/uploads/<%=p.getImage()%>">
                        </td>

                        <td><%= p.getName() %></td>

                        <td>₹ <%= p.getPrice() %></td>

                        <td><%= p.getCategoryId() %></td>

                        <td>
                            <a href="<%=request.getContextPath()%>/product?action=editPage&id=<%=p.getId()%>" 
                               class="btn btn-warning btn-sm">
                                <i class="fa fa-edit"></i>
                            </a>

                            <a href="<%=request.getContextPath()%>/product?action=delete&id=<%=p.getId()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Delete this product?')">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>

                <%
                        }
                    } else {
                %>

                    <tr>
                        <td colspan="6">No Products Found</td>
                    </tr>

                <%
                    }
                %>

                </tbody>
            </table>

        </div>
    </div>

    <!-- 🔢 PAGINATION -->
    <div class="mt-3 text-center">
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