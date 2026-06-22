<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="title" value="Register - Online Store" scope="request" />
<%@ include file="header.jsp" %>

<div class="auth-wrapper">
    <div class="auth-card">
        <h2 class="auth-title">Register</h2>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" required class="form-control" />
            </div>
            
            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" required class="form-control" />
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" required class="form-control" />
            </div>
            
            <div class="form-group">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required class="form-control" />
            </div>
            
            <button type="submit" class="btn-auth-submit">Sign Up</button>
        </form>
        
        <div class="auth-footer">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Log In</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
