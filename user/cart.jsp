<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Cart" %>

<%
    List<Cart> cartList = (List<Cart>) request.getAttribute("cartList");
    Double total = (Double) request.getAttribute("total");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Cart - SmartCart</title>

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
            background: linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.75)),
                        url('https://images.unsplash.com/photo-1607082349566-187342175e2f')
                        no-repeat center center/cover;
            color: white;
        }

        /* ✨ Glass Card */
        .cart-card {
            margin-top: 40px;
            border-radius: 20px;
            backdrop-filter: blur(25px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
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
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
            transition: 0.3s;
        }

        img:hover {
            transform: scale(1.1);
        }

        /* Buttons */
        .btn-primary {
            border-radius: 10px;
        }

        .btn-danger {
            border-radius: 10px;
        }

        .btn-success {
            border-radius: 12px;
            background: linear-gradient(45deg, #00c853, #64dd17);
            border: none;
            font-weight: 600;
        }

        .btn-success:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 25px rgba(0,255,100,0.6);
        }

        .btn-secondary {
            border-radius: 10px;
        }

        h3, h4 {
            font-weight: 600;
        }

    </style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mt-4">
        <h3>🛒 My Cart</h3>

        <a href="<%=request.getContextPath()%>/product?action=list" 
           class="btn btn-secondary">
            Continue Shopping
        </a>
    </div>

    <!-- CART TABLE -->
    <div class="card cart-card shadow mt-3">
        <div class="card-body">

            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (cartList != null && !cartList.isEmpty()) {
                        for (Cart c : cartList) {
                %>

                    <tr>
                        <td>
                            <img src="<%=request.getContextPath()%>/uploads/<%=c.getImage()%>">
                        </td>

                        <td><%= c.getProductName() %></td>

                        <td>₹ <%= c.getPrice() %></td>

                        <!-- QUANTITY UPDATE -->
                        <td>
                            <form action="<%=request.getContextPath()%>/cart" method="post" class="d-flex justify-content-center">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="cartId" value="<%=c.getId()%>">

                                <input type="number" name="quantity" 
                                       value="<%=c.getQuantity()%>" 
                                       min="1"
                                       class="form-control w-50 me-2">

                                <button class="btn btn-sm btn-primary">
                                    <i class="fa fa-sync"></i>
                                </button>
                            </form>
                        </td>

                        <td>₹ <%= c.getTotalPrice() %></td>

                        <!-- REMOVE -->
                        <td>
                            <a href="<%=request.getContextPath()%>/cart?action=remove&id=<%=c.getId()%>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Remove item?')">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>

                <%
                        }
                    } else {
                %>

                    <tr>
                        <td colspan="6">Your cart is empty</td>
                    </tr>

                <%
                    }
                %>

                </tbody>
            </table>

        </div>
    </div>

    <!-- TOTAL + CHECKOUT -->
    <div class="mt-4 d-flex justify-content-between align-items-center">

        <h4>
            Total: ₹ <%= (total != null) ? total : 0 %>
        </h4>

        <form action="<%=request.getContextPath()%>/order" method="post">
            <input type="hidden" name="action" value="place">

            <button class="btn btn-success"
                <%= (cartList == null || cartList.isEmpty()) ? "disabled" : "" %>>
                Place Order
            </button>
        </form>

    </div>

</div>

</body>
</html>