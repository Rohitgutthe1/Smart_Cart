<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.User" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - SmartCart</title>

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
                        url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f')
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
        <h3>👥 Manage Users</h3>

        <a href="<%=request.getContextPath()%>/admin?action=dashboard" 
           class="btn btn-secondary">
            Back to Dashboard
        </a>
    </div>

    <!-- TABLE -->
    <div class="card glass-card shadow">
        <div class="card-body">

            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (users != null && !users.isEmpty()) {
                        for (User u : users) {
                %>

                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getName() %></td>
                        <td><%= u.getEmail() %></td>

                        <td>
                            <a href="<%=request.getContextPath()%>/admin?action=deleteUser&id=<%=u.getId()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure to delete this user?')">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>

                <%
                        }
                    } else {
                %>

                    <tr>
                        <td colspan="4">No Users Found</td>
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