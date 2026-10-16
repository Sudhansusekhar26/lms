<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Platform Services - Cloud LMS" />
</jsp:include>

<div class="py-5 bg-dark text-white border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #0f172a, #1e293b);">
    <div class="container text-center py-4">
        <span class="badge bg-primary bg-opacity-25 text-cyan mb-2">ENTERPRISE CAPABILITIES</span>
        <h1 class="fw-extrabold mb-3">Modular Learning Services & Toolchains</h1>
        <p class="lead text-secondary max-w-2xl mx-auto">
            Comprehensive suite of pedagogical tools designed for instructors, academic institutions, and ambitious learners.
        </p>
    </div>
</div>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm rounded-4 p-4">
                <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-3 d-inline-flex mb-3" style="width: 54px; height: 54px; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-chalkboard-user fs-4"></i>
                </div>
                <h5 class="fw-bold mb-2">Faculty Studio & Syllabi</h5>
                <p class="text-muted small">Course authoring with sections, lessons, video lecture embedding, and presigned cloud storage asset links.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm rounded-4 p-4">
                <div class="bg-success bg-opacity-10 text-success rounded-3 p-3 d-inline-flex mb-3" style="width: 54px; height: 54px; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-stopwatch-20 fs-4"></i>
                </div>
                <h5 class="fw-bold mb-2">Automated Quiz Engine</h5>
                <p class="text-muted small">Timed MCQ question banks, client-side auto-submission on timeout, and instant score computation with explanations.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm rounded-4 p-4">
                <div class="bg-danger bg-opacity-10 text-danger rounded-3 p-3 d-inline-flex mb-3" style="width: 54px; height: 54px; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-video fs-4"></i>
                </div>
                <h5 class="fw-bold mb-2">WebRTC Live Classrooms</h5>
                <p class="text-muted small">HD real-time video classrooms, screen sharing, chat, and room token integration for live webinar broadcasts.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm rounded-4 p-4">
                <div class="bg-warning bg-opacity-10 text-warning rounded-3 p-3 d-inline-flex mb-3" style="width: 54px; height: 54px; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-chart-line fs-4"></i>
                </div>
                <h5 class="fw-bold mb-2">Student Analytics Tracker</h5>
                <p class="text-muted small">Granular progress tracking with lesson checkmarks, overall course completion percentage, and score breakdown.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm rounded-4 p-4">
                <div class="bg-info bg-opacity-10 text-info rounded-3 p-3 d-inline-flex mb-3" style="width: 54px; height: 54px; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-shield-halved fs-4"></i>
                </div>
                <h5 class="fw-bold mb-2">Role-Based Access Governance</h5>
                <p class="text-muted small">Spring Security 6 with custom authentication success handlers, BCrypt password hashing, and user suspension toggles.</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm rounded-4 p-4">
                <div class="bg-purple bg-opacity-10 text-purple rounded-3 p-3 d-inline-flex mb-3" style="width: 54px; height: 54px; align-items: center; justify-content: center; background-color: rgba(139, 92, 246, 0.1); color: #8b5cf6;">
                    <i class="fa-solid fa-file-pdf fs-4"></i>
                </div>
                <h5 class="fw-bold mb-2">PDF Material Viewer</h5>
                <p class="text-muted small">Embedded modal document viewer for lecture slides, supplementary reading notes, and reference books.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
