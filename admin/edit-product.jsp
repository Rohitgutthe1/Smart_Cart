<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Product, model.Category" %>

<%
    Product p = (Product) request.getAttribute("product");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product - Admin</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f5f5;
        }
        .card {
            margin-top: 50px;
            border-radius: 10px;
        }
        .preview-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow">
                <div class="card-header text-center bg-warning">
                    <h4>Edit Product</h4>
                </div>

                <div class="card-body">

                    <form action="<%=request.getContextPath()%>/product" 
                          method="post" 
                          enctype="multipart/form-data">

                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%=p.getId()%>">
                        <input type="hidden" name="oldImage" value="<%=p.getImage()%>">

                        <!-- Product Name -->
                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control" 
                                   value="<%=p.getName()%>" required>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3" required>
<%=p.getDescription()%>
                            </textarea>
                        </div>

                        <!-- Price -->
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" name="price" step="0.01" 
                                   value="<%=p.getPrice()%>" class="form-control" required>
                        </div>

                        <!-- Category -->
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select name="categoryId" class="form-control" required>
                                <%
                                    for(Category c : categories){
                                %>
                                    <option value="<%=c.getId()%>"
                                        <%= (c.getId() == p.getCategoryId()) ? "selected" : "" %>>
                                        <%=c.getName()%>
                                    </option>
                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <!-- Current Image -->
                        <div class="mb-3">
                            <label class="form-label">Current Image</label><br>
                            <img src="<%=request.getContextPath()%>/uploads/<%=p.getImage()%>" 
                                 class="preview-img">
                        </div>

                        <!-- Upload New Image -->
                        <div class="mb-3">
                            <label class="form-label">Change Image</label>
                            <input type="file" name="image" class="form-control" 
                                   accept="image/*" onchange="previewImage(event)">

                            <img id="preview" class="preview-img" style="display:none;">
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-warning">
                                Update Product
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- JS Preview -->
<script>
    function previewImage(event) {
        const preview = document.getElementById('preview');
        preview.src = URL.createObjectURL(event.target.files[0]);
        preview.style.display = "block";
    }
</script>

</body>
</html>