<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="title" value="My Cart - Online Store" scope="request" />
<c:set var="activePage" value="cart" scope="request" />
<%@ include file="header.jsp" %>

<h1 style="font-size: 2.25rem; font-weight: 700; margin-bottom: 2rem; letter-spacing: -0.02em;">My Cart</h1>

<div class="cart-layout">

    <!-- My Cart Section -->
    <div class="account-section">
        <h2 class="section-header">Shopping Cart</h2>
        
        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-state">
                    Your shopping cart is currently empty.
                    <br/><br/>
                    <a href="${pageContext.request.contextPath}/index" class="btn-primary" style="text-decoration:none; padding: 0.6rem 1.5rem;">Continue Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-list">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item-row">
                            <div class="cart-item-info">
                                <div class="cart-item-img ${not empty item.product.imageUrl ? 'has-img' : ''}">
                                    <c:choose>
                                        <c:when test="${not empty item.product.imageUrl}">
                                            <img src="${pageContext.request.contextPath}${item.product.imageUrl}" alt="${item.product.name}" />
                                        </c:when>
                                        <c:otherwise>
                                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                                                <rect x="2" y="3" width="20" height="14" rx="2" />
                                            </svg>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="cart-item-meta">
                                    <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" class="cart-item-name">
                                        ${item.product.name}
                                    </a>
                                    <span class="cart-item-price">$${item.product.price} (Qty: ${item.quantity})</span>
                                </div>
                            </div>
                            
                            <div class="cart-item-actions">
                                <form action="${pageContext.request.contextPath}/cart/remove" method="post" style="display:inline;">
                                    <input type="hidden" name="cartItemId" value="${item.id}" />
                                    <button type="submit" class="btn-item-action">Remove</button>
                                </form>
                                
                                <form action="${pageContext.request.contextPath}/cart/save-for-later" method="post" style="display:inline;">
                                    <input type="hidden" name="cartItemId" value="${item.id}" />
                                    <button type="submit" class="btn-item-action">Save for Later</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Cart Summary / Total & Checkout -->
                <div class="cart-footer">
                    <div class="cart-total-display">
                        Total: <span>$${cartTotal}</span>
                    </div>
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="post">
                        <button type="submit" class="btn-checkout">Proceed to Checkout</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<%@ include file="footer.jsp" %>
