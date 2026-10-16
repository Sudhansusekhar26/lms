<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
</main>

<c:if test="${param.hideFooter != 'true'}">
<footer class="text-white pt-5 pb-4 mt-auto border-top" style="background-color: #0c1e36 !important;">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <div class="bg-primary text-white rounded-3 p-2 d-flex align-items-center justify-content-center" style="width: 38px; height: 38px; background-color: #1d70b8 !important;">
                        <i class="fa-solid fa-graduation-cap"></i>
                    </div>
                    <span class="fs-4 fw-bold text-white font-monospace" style="font-family: 'Outfit', sans-serif;">Cloud<span style="color: #60a5fa;">LMS</span></span>
                </div>
                <p class="text-slate-300 small leading-relaxed" style="color: #cbd5e1;">
                    Next-generation institutional Learning Management System engineered with real-time WebRTC live lectures, comprehensive syllabus viewers, automated timed quiz grading, and verified student registration roll number integration.
                </p>
                <div class="d-flex gap-3 mt-3">
                    <a href="#" class="text-white opacity-75 hover-opacity-100 fs-5"><i class="fa-brands fa-github"></i></a>
                    <a href="#" class="text-white opacity-75 hover-opacity-100 fs-5"><i class="fa-brands fa-linkedin"></i></a>
                    <a href="#" class="text-white opacity-75 hover-opacity-100 fs-5"><i class="fa-brands fa-x-twitter"></i></a>
                    <a href="#" class="text-white opacity-75 hover-opacity-100 fs-5"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>

            <div class="col-lg-2 col-md-6">
                <h6 class="text-white fw-bold mb-3 text-uppercase fs-7 tracking-wider" style="letter-spacing: 0.5px; font-family: 'Outfit', sans-serif;">Quick Navigation</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2" style="color: #cbd5e1;">
                    <li><a href="/" class="text-decoration-none text-white opacity-75">Home</a></li>
                    <li><a href="/#courses" class="text-decoration-none text-white opacity-75">All Courses</a></li>
                    <li><a href="/#services" class="text-decoration-none text-white opacity-75">Portal Services</a></li>
                    <li><a href="/#about" class="text-decoration-none text-white opacity-75">About Institution</a></li>
                    <li><a href="/contact" class="text-decoration-none text-white opacity-75">Contact & Support</a></li>
                    <li><a href="/verify-certificate" class="text-decoration-none text-white opacity-75"><i class="fa-solid fa-award me-1 text-warning"></i> Verify Certificate</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h6 class="text-white fw-bold mb-3 text-uppercase fs-7 tracking-wider" style="letter-spacing: 0.5px; font-family: 'Outfit', sans-serif;">Institutional Gateways</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2" style="color: #cbd5e1;">
                    <li><a href="/student/dashboard" class="text-decoration-none text-white opacity-75"><i class="fa-solid fa-user-graduate me-1 text-success"></i> Student Learning Hub</a></li>
                    <li><a href="/faculty/dashboard" class="text-decoration-none text-white opacity-75"><i class="fa-solid fa-chalkboard-user me-1 text-warning"></i> Faculty Studio</a></li>
                    <li><a href="/admin/dashboard" class="text-decoration-none text-white opacity-75"><i class="fa-solid fa-shield-halved me-1 text-danger"></i> Admin Governance</a></li>
                    <li><a href="/login" class="text-decoration-none text-white opacity-75"><i class="fa-solid fa-key me-1 text-info"></i> Portal Sign In</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h6 class="text-white fw-bold mb-3 text-uppercase fs-7 tracking-wider" style="letter-spacing: 0.5px; font-family: 'Outfit', sans-serif;">System Status</h6>
                <div class="p-3 rounded-3 bg-white bg-opacity-10 border border-white border-opacity-10 small">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="spinner-grow spinner-grow-sm text-success" role="status"></span>
                        <span class="text-white fw-bold">All Services Online</span>
                    </div>
                    <p class="mb-0 fs-8" style="color: #cbd5e1;">
                        WebRTC Live Rooms, RBAC Gate, and Auto-Grading Engine are fully operational.
                    </p>
                </div>
            </div>
        </div>

        <hr class="border-secondary border-opacity-25 my-4">

        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 small" style="color: #94a3b8;">
            <div>
                &copy; 2026 CloudLMS Academic Portal. All rights reserved. Zero Technical Debt.
            </div>
            <div class="d-flex gap-3">
                <a href="/#about" class="text-decoration-none text-slate-400" style="color: #94a3b8;">Privacy Policy</a>
                <a href="/#about" class="text-decoration-none text-slate-400" style="color: #94a3b8;">Terms of Service</a>
                <a href="/contact" class="text-decoration-none text-slate-400" style="color: #94a3b8;">Contact Admin</a>
            </div>
        </div>
    </div>
</footer>
</c:if>

</body>
</html>