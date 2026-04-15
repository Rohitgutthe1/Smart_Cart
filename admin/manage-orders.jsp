<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders - SmartCart</title>

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

        /* Status badges */
        .badge {
            padding: 8px 12px;
            font-size: 13px;
        }

        /* Buttons */
        .btn {
            border-radius: 10px;
            font-weight: 500;
        }

        .btn-success:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(0,255,100,0.5);
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
        <h3>📦 Manage Orders</h3>

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
                        <th>User ID</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Update</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (orders != null && !orders.isEmpty()) {
                        for (Order o : orders) {
                %>

                    <tr>
                        <td><%= o.getId() %></td>
                        <td><%= o.getUserId() %></td>
                        <td>₹ <%= o.getTotalPrice() %></td>

                        <!-- STATUS -->
                        <td>
                            <%
                                String status = o.getStatus();
                                String color = "secondary";

                                if ("Pending".equals(status)) color = "warning";
                                else if ("Shipped".equals(status)) color = "primary";
                                else if ("Delivered".equals(status)) color = "success";
                            %>

                            <span class="badge bg-<%=color%>">
                                <%= status %>
                            </span>
                        </td>

                        <td><%= o.getDate() %></td>

                        <!-- UPDATE STATUS -->
                        <td>
                            <form action="<%=request.getContextPath()%>/admin" method="get">
                                <input type="hidden" name="action" value="updateOrderStatus">
                                <input type="hidden" name="id" value="<%=o.getId()%>">

                                <div class="d-flex gap-2">

                                    <select name="status" class="form-select form-select-sm">
                                        <option value="Pending" <%= "Pending".equals(o.getStatus()) ? "selected" : "" %>>Pending</option>
                                        <option value="Shipped" <%= "Shipped".equals(o.getStatus()) ? "selected" : "" %>>Shipped</option>
                                        <option value="Delivered" <%= "Delivered".equals(o.getStatus()) ? "selected" : "" %>>Delivered</option>
                                    </select>

                                    <button type="submit" class="btn btn-sm btn-success">
                                        <i class="fa fa-sync"></i>
                                    </button>

                                </div>
                            </form>
                        </td>
                    </tr>

                <%
                        }
                    } else {
                %>

                    <tr>
                        <td colspan="6">No Orders Found</td>
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