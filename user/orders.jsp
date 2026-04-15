<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Order, model.OrderItem" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders - SmartCart</title>

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
            background: linear-gradient(rgba(255,255,255,0.85), rgba(255,255,255,0.85)),
            url('https://images.unsplash.com/photo-1523275335684-37898b6baf30')
            no-repeat center center/cover;
            color: white;
        }

        /* ✨ Glass Card */
        .order-card {
            margin-top: 20px;
            border-radius: 20px;
            backdrop-filter: blur(25px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
            animation: fadeIn 0.7s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }

        /* Table */
        .table {
            color: white;
        }

        .table thead {
            background: rgba(0,0,0,0.5);
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

        /* Status badges */
        .badge {
            padding: 8px 12px;
            font-size: 13px;
        }

        h3, h5 {
            font-weight: 600;
        }

        .btn-secondary {
            border-radius: 10px;
        }

        .btn-primary {
            border-radius: 10px;
        }
       

    </style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mt-4">
        <h3>📦 My Orders</h3>

        <a href="<%=request.getContextPath()%>/product?action=list" 
           class="btn btn-secondary">
            Continue Shopping
        </a>
    </div>

    <!-- ORDERS -->
    <%
        if (orders != null && !orders.isEmpty()) {
            for (Order o : orders) {
    %>

    <div class="card order-card shadow">
        <div class="card-body">

            <!-- ORDER INFO -->
            <div class="d-flex justify-content-between">
                <div>
                    <h5>Order ID: <%= o.getId() %></h5>
                    <p>Date: <%= o.getDate() %></p>
                </div>

                <div>
                    <h5>Total: ₹ <%= o.getTotalPrice() %></h5>

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
                </div>
            </div>

            <hr>

            <!-- ORDER ITEMS -->
            <table class="table text-center align-middle">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Total</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    List<OrderItem> items = o.getItems();
                    if (items != null) {
                        for (OrderItem item : items) {
                %>

                    <tr>
                        <td>
                            <img src="<%=request.getContextPath()%>/uploads/<%=item.getImage()%>">
                        </td>
                        <td><%= item.getProductName() %></td>
                        <td>₹ <%= item.getPrice() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>₹ <%= item.getTotalPrice() %></td>
                    </tr>

                <%
                        }
                    }
                %>

                </tbody>
            </table>

        </div>
    </div>

    <%
            }
        } else {
    %>

    <!-- NO ORDERS -->
    <div class="card order-card text-center">
        <div class="card-body">
            <h5>No Orders Found</h5>
            <a href="<%=request.getContextPath()%>/product?action=list" 
               class="btn btn-primary mt-2">
                Start Shopping
            </a>
        </div>
    </div>

    <%
        }
    %>

</div>

</body>
</html>