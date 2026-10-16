<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Credential & Certificate Verification - Cloud LMS" />
</jsp:include>

<div class="py-5 text-white" style="background: linear-gradient(135deg, #0a1c3d 0%, #0f2b5c 50%, #1d70b8 100%);">
    <div class="container text-center py-4">
        <span class="badge bg-warning bg-opacity-25 text-warning px-3 py-1.5 rounded-pill fw-bold mb-3 border border-warning border-opacity-25">
            <i class="fa-solid fa-shield-halved me-1"></i> OFFICIAL ACADEMIC REGISTRY
        </span>
        <h1 class="fw-extrabold mb-3 display-5">Public Certificate Verification</h1>
        <p class="lead text-slate-300 max-w-2xl mx-auto" style="color: #cbd5e1;">
            Instantly authenticate official credentials, course completion certificates, and verified degrees issued by Cloud LMS University.
        </p>
    </div>
</div>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Verification Search Card -->
            <div class="card portal-card p-4 p-md-5 mb-5 shadow-sm border-0">
                <div class="text-center mb-4">
                    <div class="rounded-circle bg-primary bg-opacity-10 d-inline-flex p-3 text-primary mb-3">
                        <i class="fa-solid fa-certificate fs-1"></i>
                    </div>
                    <h4 class="fw-bold text-navy mb-2" style="color: #0f2b5c;">Verify Credential Authenticity</h4>
                    <p class="text-muted small">Enter the unique Certificate ID found on the certificate, transcript, or graduate's resume.</p>
                </div>

                <form action="/verify-certificate" method="GET">
                    <div class="input-group input-group-lg mb-3 shadow-sm rounded-pill overflow-hidden border">
                        <span class="input-group-text bg-white border-0 ps-4 text-muted"><i class="fa-solid fa-qrcode fs-5 text-primary"></i></span>
                        <input type="text" name="certId" class="form-control border-0 shadow-none px-3 fs-6" placeholder="e.g. CERT-STU-1-3" required autocomplete="off">
                        <button type="submit" class="btn btn-portal-primary px-4 fw-bold">
                            <i class="fa-solid fa-magnifying-glass me-1"></i> Verify Now
                        </button>
                    </div>
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 px-2 text-muted fs-8">
                        <span>Format: <code>CERT-STU-[CourseID]-[StudentID]</code></span>
                        <span>Official Cloud LMS Verification Protocol v3.2</span>
                    </div>
                </form>
            </div>

            <!-- Features Grid -->
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card portal-card p-4 h-100 text-center">
                        <i class="fa-solid fa-fingerprint text-primary fs-2 mb-3"></i>
                        <h6 class="fw-bold mb-2" style="color: #0f2b5c;">Tamper-Proof</h6>
                        <p class="text-muted fs-8 mb-0">Every certificate is tied to authenticated student enrollment, exam scores, and faculty signatures.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card portal-card p-4 h-100 text-center">
                        <i class="fa-solid fa-bolt text-warning fs-2 mb-3"></i>
                        <h6 class="fw-bold mb-2" style="color: #0f2b5c;">Instant Verification</h6>
                        <p class="text-muted fs-8 mb-0">Hiring managers and university admissions deans can verify qualifications in real time.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card portal-card p-4 h-100 text-center">
                        <i class="fa-solid fa-share-nodes text-success fs-2 mb-3"></i>
                        <h6 class="fw-bold mb-2" style="color: #0f2b5c;">Shareable URL</h6>
                        <p class="text-muted fs-8 mb-0">Graduates receive a persistent, verifiable URL to attach to LinkedIn profiles and portfolios.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
