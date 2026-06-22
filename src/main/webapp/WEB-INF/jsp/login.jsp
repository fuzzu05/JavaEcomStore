<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="title" value="Login - Online Store" scope="request" />
<%@ include file="header.jsp" %>

<div class="auth-wrapper">
    <div class="auth-card">
        <h2 class="auth-title">Login</h2>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" required class="form-control" />
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" required class="form-control" />
            </div>
            
            <button type="submit" class="btn-auth-submit">Log In</button>
        </form>
        
        <div class="auth-footer">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign Up</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
