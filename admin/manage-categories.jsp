<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Category" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories - SmartCart</title>

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
                        url('https://images.unsplash.com/photo-1515169067868-5387ec356754')
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
        <h3>📂 Manage Categories</h3>

        <a href="<%=request.getContextPath()%>/admin?action=dashboard" 
           class="btn btn-secondary">
            Dashboard
        </a>
    </div>

    <!-- ADD CATEGORY -->
    <div class="card glass-card shadow">
        <div class="card-body">

            <form action="<%=request.getContextPath()%>/admin" method="post" class="d-flex">
                <input type="hidden" name="action" value="addCategory">

                <input type="text" name="name" class="form-control me-2" 
                       placeholder="Enter category name" required>

                <button class="btn btn-success">
                    <i class="fa fa-plus"></i> Add
                </button>
            </form>

        </div>
    </div>

    <!-- CATEGORY LIST -->
    <div class="card glass-card shadow">
        <div class="card-body">

            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (categories != null && !categories.isEmpty()) {
                        for (Category c : categories) {
                %>

                    <tr>
                        <td><%= c.getId() %></td>
                        <td><%= c.getName() %></td>

                        <td>
                            <a href="<%=request.getContextPath()%>/admin?action=deleteCategory&id=<%=c.getId()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Delete category?')">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>

                <%
                        }
                    } else {
                %>

                    <tr>
                        <td colspan="3">No Categories Found</td>
                    </tr>

                <%
                    }
                %>

                </tbody>
            </table>

        </div>
    </div>

</div>

</body>
</html>