<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="title" value="Welcome - Online Store" scope="request" />
<c:set var="activePage" value="browse" scope="request" />
<%@ include file="header.jsp" %>

<!-- Search bar Form -->
<form action="${pageContext.request.contextPath}/index" method="get">
    <div class="search-wrapper">
        <div class="search-box">
            <!-- Retain current category if searching -->
            <input type="hidden" name="category" value="${selectedCategory}" />
            <input type="text" name="query" value="${searchQuery}" class="search-input" placeholder="Search for products..." />
            <button type="submit" class="search-button">Search</button>
        </div>
    </div>
    
    <!-- Categories List -->
    <div class="categories-wrapper">
        <a href="${pageContext.request.contextPath}/index?category=${selectedCategory == 'Electronics' ? '' : 'Electronics'}&amp;query=${searchQuery}" 
           class="category-btn ${selectedCategory == 'Electronics' ? 'active' : ''}">Electronics</a>
        
        <a href="${pageContext.request.contextPath}/index?category=${selectedCategory == 'Clothing' ? '' : 'Clothing'}&amp;query=${searchQuery}" 
           class="category-btn ${selectedCategory == 'Clothing' ? 'active' : ''}">Clothing</a>
        
        <a href="${pageContext.request.contextPath}/index?category=${selectedCategory == 'Home & Kitchen' ? '' : 'Home+%26+Kitchen'}&amp;query=${searchQuery}" 
           class="category-btn ${selectedCategory == 'Home & Kitchen' ? 'active' : ''}">Home &amp; Kitchen</a>
        
        <a href="${pageContext.request.contextPath}/index?category=${selectedCategory == 'Sports' ? '' : 'Sports'}&amp;query=${searchQuery}" 
           class="category-btn ${selectedCategory == 'Sports' ? 'active' : ''}">Sports</a>
    </div>
</form>

<!-- Big Sale Banner -->
<div class="banner">
    <h2>Welcome to Our Online Store</h2>
    <p style="margin: 0.5rem 0 0.75rem 0; font-size: 1.15rem; color: var(--accent);">Big Sale! Up to 50% off on selected items!</p>
    <p>High-performance gears, fashion apparel, home appliances, and fitness items curated for you.</p>
</div>

<!-- Products Grid -->
<c:choose>
    <c:when test="${empty products}">
        <div class="empty-state">No products found matching your filters.</div>
    </c:when>
    <c:otherwise>
        <div class="products-grid">
            <c:forEach var="product" items="${products}">
                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/product?id=${product.id}">
                        <div class="product-img-placeholder">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                                <rect x="2" y="3" width="20" height="14" rx="2" />
                                <line x1="8" y1="21" x2="16" y2="21" />
                                <line x1="12" y1="17" x2="12" y2="21" />
                            </svg>
                            <span>${product.category}</span>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="product-title" style="text-decoration:none; color:inherit;">
                        ${product.name}
                    </a>
                    
                    <p class="product-desc-short">${product.description}</p>
                    
                    <div class="product-card-footer">
                        <span class="product-price">$${product.price}</span>
                        <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display:inline;">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <button type="submit" class="btn-primary">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="footer.jsp" %>
