<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${title != null ? title : 'Online Store'}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css?v=1.0.3" />
    <!-- Apply theme before rendering body to avoid flash of dark/light theme -->
    <script>
        (function() {
            const savedTheme = localStorage.getItem("theme");
            if (savedTheme === "light") {
                document.documentElement.classList.add("light");
            }
        })();
    </script>
</head>
<body>
    <!-- Global Alert Notifications/Toasts -->
    <ul class="faces-messages">
        <c:if test="${not empty successMessage}">
            <li class="faces-messages-info">${successMessage}</li>
        </c:if>
        <c:if test="${not empty infoMessage}">
            <li class="faces-messages-info">${infoMessage}</li>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <li class="faces-messages-error">${errorMessage}</li>
        </c:if>
    </ul>

    <header>
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/index" class="logo-link">
                <span class="logo">Online Store</span>
            </a>
            
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/index" class="nav-item ${activePage == 'browse' ? 'active' : ''}">Browse</a>
                
                <a href="${pageContext.request.contextPath}/cart" class="nav-item cart-icon-container ${activePage == 'cart' ? 'active' : ''}">
                    My Cart
                    <c:if test="${cartCount > 0}">
                        <span class="cart-badge">${cartCount}</span>
                    </c:if>
                </a>
                
                <a href="${pageContext.request.contextPath}/account" class="nav-item ${activePage == 'account' ? 'active' : ''}">My Account</a>

                <!-- Theme Toggle Button -->
                <button id="themeToggle" class="theme-toggle-btn" title="Toggle Theme" type="button">
                    <!-- Sun SVG (Dark Mode active) -->
                    <svg class="sun-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="5"></circle>
                        <line x1="12" y1="1" x2="12" y2="3"></line>
                        <line x1="12" y1="21" x2="12" y2="23"></line>
                        <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                        <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                        <line x1="1" y1="12" x2="3" y2="12"></line>
                        <line x1="21" y1="12" x2="23" y2="12"></line>
                        <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                        <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                    </svg>
                    <!-- Moon SVG (Light Mode active) -->
                    <svg class="moon-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                    </svg>
                </button>

                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <a href="${pageContext.request.contextPath}/account" style="color: var(--text-secondary); font-size: 0.9rem; text-decoration: none; transition: color 0.2s ease;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text-secondary)'">Hi, ${username}!</a>
                        <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline; margin-left: 0.5rem;">
                            <button type="submit" class="nav-item">Logout</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn-auth-outline">Log In</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
    
    <main class="main-content">
