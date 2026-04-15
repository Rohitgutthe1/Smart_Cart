<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Category" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Product - SmartCart</title>

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
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;

            background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)),
                        url('https://images.unsplash.com/photo-1515169067868-5387ec356754')
                        no-repeat center center/cover;
        }

        /* ✨ Glass Card */
        .form-card {
            width: 500px;
            border-radius: 20px;
            backdrop-filter: blur(25px);
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
            color: white;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .form-control, .form-select {
            border-radius: 10px;
            background: rgba(255,255,255,0.9);
            border: none;
        }

        /* Image Preview */
        .preview-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            margin-top: 10px;
            display: none;
            border-radius: 10px;
            border: 2px solid white;
        }

        /* Buttons */
        .btn-success {
            border-radius: 12px;
            background: linear-gradient(45deg, #00c853, #64dd17);
            border: none;
            font-weight: 600;
        }

        .btn-success:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(0,255,100,0.6);
        }

        h4 {
            font-weight: 600;
        }

    </style>
</head>

<body>

<div class="form-card shadow p-4">

    <div class="text-center mb-3">
        <h4>➕ Add Product</h4>
        <p>Add new product to SmartCart</p>
    </div>

    <!-- FORM -->
    <form action="<%=request.getContextPath()%>/product" 
          method="post" 
          enctype="multipart/form-data">

        <input type="hidden" name="action" value="add">

        <!-- Product Name -->
        <div class="mb-3">
            <label>Product Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" rows="3" required></textarea>
        </div>

        <!-- Price -->
        <div class="mb-3">
            <label>Price</label>
            <input type="number" name="price" step="0.01" class="form-control" required>
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label>Category</label>
            <select name="categoryId" class="form-select" required>
                <option value="">-- Select Category --</option>

                <%
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    if(categories != null){
                        for(Category c : categories){
                %>
                    <option value="<%=c.getId()%>">
                        <%=c.getName()%>
                    </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <!-- Image Upload -->
        <div class="mb-3">
            <label>Product Image</label>
            <input type="file" name="image" class="form-control" accept="image/*" onchange="previewImage(event)" required>

            <img id="preview" class="preview-img"/>
        </div>

        <!-- Button -->
        <div class="d-grid">
            <button type="submit" class="btn btn-success">
                <i class="fa fa-plus"></i> Add Product
            </button>
        </div>

    </form>

</div>

<!-- JS Preview -->
<script>
    function previewImage(event) {
        const input = event.target;
        const preview = document.getElementById('preview');

        if (input.files && input.files[0]) {
            preview.src = URL.createObjectURL(input.files[0]);
            preview.style.display = "block";
        }
    }
</script>

</body>
</html>