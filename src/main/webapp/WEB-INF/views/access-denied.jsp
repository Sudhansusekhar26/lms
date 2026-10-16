<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Access Denied - 403 Forbidden" />
</jsp:include>

<div class="py-5 bg-light d-flex align-items-center flex-grow-1">
    <div class="container py-5 text-center">
        <div class="card border-0 shadow-lg rounded-4 p-5 mx-auto bg-white" style="max-width: 600px;">
            <div class="bg-danger bg-opacity-10 text-danger rounded-circle p-4 d-inline-flex mx-auto mb-3" style="width: 80px; height: 80px; align-items: center; justify-content: center;">
                <i class="fa-solid fa-hand-holding-hand fs-1 text-danger"></i>
            </div>
            <span class="badge bg-danger bg-opacity-10 text-danger fw-bold text-uppercase px-3 py-1 mb-2 align-self-center">HTTP 403 &bull; Access Boundary</span>
            <h2 class="fw-bold text-dark mb-2">Unauthorized Role Access</h2>
            <p class="text-muted small mb-4 leading-relaxed">
                Your current authenticated role does not have the security privileges to access this system module. Please switch to an account with adequate RBAC clearance.
            </p>
            <div class="d-flex justify-content-center gap-3">
                <a href="/dashboard" class="btn btn-primary px-4 fw-semibold"><i class="fa-solid fa-gauge-high me-1"></i> Return to My Dashboard</a>
                <a href="/logout" class="btn btn-outline-danger px-4 fw-semibold"><i class="fa-solid fa-right-from-bracket me-1"></i> Switch Account</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />