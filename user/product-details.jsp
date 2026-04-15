<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Product" %>

<%
    Product p = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Product Details - SmartCart</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }

        /* 🎬 Background */
        body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;

            background: linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.75)),
                        url('https://images.unsplash.com/photo-1523275335684-37898b6baf30')
                        no-repeat center center/cover;
        }

        /* ✨ Glass Card */
        .product-card {
            width: 950px;
            padding: 30px;
            border-radius: 25px;
            backdrop-filter: blur(30px);
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 60px rgba(0,0,0,0.6);
            color: white;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: scale(0.9);}
            to {opacity: 1; transform: scale(1);}
        }

        /* 🖼 Image */
        .product-img {
            max-height: 320px;
            object-fit: contain;
            transition: 0.4s ease;
        }

        .product-img:hover {
            transform: scale(1.1) rotate(1deg);
        }

        /* 💰 Price */
        .price {
            color: #00e676;
            font-size: 24px;
            font-weight: 600;
        }

        /* ⭐ Fake Rating */
        .rating i {
            color: gold;
        }

        /* 🚚 Info */
        .info {
            font-size: 14px;
            opacity: 0.9;
        }

        /* 🔥 Buttons */
        .btn-warning {
            background: linear-gradient(45deg, #ff9800, #ffc107);
            border: none;
            font-weight: 600;
            border-radius: 12px;
            transition: 0.3s;
        }

        .btn-warning:hover {
            transform: scale(1.07);
            box-shadow: 0 5px 25px rgba(255,193,7,0.7);
        }

        .btn-secondary {
            border-radius: 12px;
        }

        h3 {
            font-weight: 600;
        }
    </style>
</head>

<body>

<div class="product-card">

    <div class="row align-items-center">

        <!-- IMAGE -->
        <div class="col-md-5 text-center">
            <img src="<%=request.getContextPath()%>/uploads/<%=p.getImage()%>" 
                 class="img-fluid product-img">
        </div>

        <!-- DETAILS -->
        <div class="col-md-7">

            <h3><%= p.getName() %></h3>

            <!-- ⭐ Rating -->
            <div class="rating mb-2">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star-half-alt"></i>
                <span class="ms-2">(4.5)</span>
            </div>

            <p class="text-light"><%= p.getDescription() %></p>

            <h4 class="price">₹ <%= p.getPrice() %></h4>

            <!-- 🚚 Extra Info -->
            <p class="info">
                <i class="fa fa-truck"></i> Free Delivery | 
                <i class="fa fa-undo"></i> 7 Days Return
            </p>

            <!-- ADD TO CART -->
            <form action="<%=request.getContextPath()%>/cart" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="<%=p.getId()%>">
                <input type="hidden" name="quantity" value="1">

                <button class="btn btn-warning mt-3">
                    <i class="fa fa-cart-plus"></i> Add to Cart
                </button>
            </form>

            <br>

            <a href="<%=request.getContextPath()%>/product?action=list" class="btn btn-secondary">
                <i class="fa fa-arrow-left"></i> Back
            </a>

        </div>

    </div>

</div>

</body>
</html>