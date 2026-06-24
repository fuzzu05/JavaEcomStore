<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="title" value="${product.name} - Details" scope="request" />
<c:set var="activePage" value="browse" scope="request" />
<%@ include file="header.jsp" %>

<c:choose>
    <c:when test="${empty product}">
        <div class="empty-state" style="margin-top: 5rem;">
            Product not found. <a href="${pageContext.request.contextPath}/index">Back to Browse</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="detail-container">
            <!-- Top Grid: Image | Product Info -->
            <div class="detail-main-grid">
                <c:choose>
                    <c:when test="${not empty product.imageUrl}">
                        <div class="detail-img-container">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}" />
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="detail-img-placeholder">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                                <rect x="2" y="3" width="20" height="14" rx="2" />
                                <line x1="8" y1="21" x2="16" y2="21" />
                                <line x1="12" y1="17" x2="12" y2="21" />
                            </svg>
                            <span style="font-size:1.1rem; font-weight: 500;">${product.name} Image</span>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="detail-info">
                    <span class="detail-category">${product.category}</span>
                    <h1 class="detail-title">${product.name}</h1>
                    <p class="detail-desc-short">${product.description}</p>
                    <div class="detail-price">$${product.price}</div>

                    <div class="detail-actions">
                        <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display:inline;">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <button type="submit" class="btn-large btn-secondary">Add to Cart</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display:inline;">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <input type="hidden" name="buyNow" value="true" />
                            <button type="submit" class="btn-large btn-primary">Buy Now</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Full-width Description Section below the grid -->
            <div class="detail-description-section">
                <h3 class="detail-section-title">Product Description</h3>
                <p class="detail-desc-long">
                    This section provides a detailed description of ${product.name}, including its premium build quality,
                    modern specifications, and other relevant information designed to help you make an informed decision.
                    Experience maximum utility and premium design crafted for your everyday needs. Built with quality materials,
                    this product is designed to deliver exceptional performance and durability for daily use.
                </p>
            </div>

            <!-- Specs / Highlights -->
            <div class="detail-description-section">
                <h3 class="detail-section-title">Highlights</h3>
                <ul class="detail-highlights">
                    <li>Premium quality materials &amp; construction</li>
                    <li>Modern design with attention to detail</li>
                    <li>Reliable performance for everyday use</li>
                    <li>Free shipping on all orders</li>
                    <li>30-day return policy</li>
                </ul>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="footer.jsp" %>
