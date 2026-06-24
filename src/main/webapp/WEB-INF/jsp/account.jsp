<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="title" value="My Account - Online Store" scope="request" />
<c:set var="activePage" value="account" scope="request" />
<%@ include file="header.jsp" %>

<h1 style="font-size: 2.25rem; font-weight: 700; margin-bottom: 2rem; letter-spacing: -0.02em;">My Account</h1>

<div class="cart-layout">

    <!-- Account Details Section -->
    <div class="account-section">
        <h2 class="section-header">Account Details</h2>
        <div class="account-details-grid">
            <div class="account-detail-item">
                <span class="account-detail-label">Username</span>
                <span class="account-detail-value">${username}</span>
            </div>
            <div class="account-detail-item">
                <span class="account-detail-label">Email</span>
                <span class="account-detail-value">${userEmail}</span>
            </div>
            <div class="account-detail-item">
                <span class="account-detail-label">Role</span>
                <span class="account-detail-value">${userRole}</span>
            </div>
            <div class="account-detail-item">
                <span class="account-detail-label">Member Since</span>
                <span class="account-detail-value">June 2026</span>
            </div>
        </div>
    </div>

    <!-- My Orders Section -->
    <div class="account-section">
        <h2 class="section-header">Order History</h2>
        
        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-state">
                    You have not placed any orders yet.
                    <br/><br/>
                    <a href="${pageContext.request.contextPath}/index" class="btn-primary" style="text-decoration:none; padding: 0.6rem 1.5rem;">Start Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="order-list">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-card-header">
                                <div class="order-card-meta">
                                    <span class="order-id-label">Order #${order.id}</span>
                                    <span class="order-date">
                                        Ordered on <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                    </span>
                                </div>
                                <div>
                                    <span class="order-status ${order.status.toLowerCase()}">${order.status}</span>
                                    <span class="order-total">$${order.totalPrice}</span>
                                </div>
                            </div>
                            <div class="order-items-list">
                                <c:forEach var="item" items="${order.items}">
                                    <div class="order-row">
                                        <div class="order-info">
                                            <div class="order-img-mini ${not empty item.product.imageUrl ? 'has-img' : ''}">
                                                <c:choose>
                                                    <c:when test="${not empty item.product.imageUrl}">
                                                        <img src="${pageContext.request.contextPath}${item.product.imageUrl}" alt="${item.product.name}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                                                            <rect x="2" y="3" width="20" height="14" rx="2" />
                                                        </svg>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="order-meta">
                                                <div class="order-meta-text">
                                                    <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" style="color: inherit; text-decoration: none;">
                                                        ${item.product.name}
                                                    </a>
                                                </div>
                                                <div class="order-date">Price: $${item.price} &times; ${item.quantity}</div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Logout Button on Account Page -->
    <div style="display: flex; justify-content: flex-end; margin-top: 1.5rem;">
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn-large btn-danger" style="background: rgba(239, 68, 68, 0.08); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.25); box-shadow: 0 0 10px rgba(239, 68, 68, 0.05); transition: all 0.2s ease; border-radius: 8px; display: inline-flex; align-items: center; cursor: pointer;" onmouseover="this.style.background='rgba(239, 68, 68, 0.15)'; this.style.borderColor='rgba(239, 68, 68, 0.45)';" onmouseout="this.style.background='rgba(239, 68, 68, 0.08)'; this.style.borderColor='rgba(239, 68, 68, 0.25)';">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 8px; vertical-align: middle;">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                    <polyline points="16 17 21 12 16 7"/>
                    <line x1="21" y1="12" x2="9" y2="12"/>
                </svg>
                Log Out
            </button>
        </form>
    </div>

</div>

<%@ include file="footer.jsp" %>
