<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
    <div class="bg-dark text-white p-4 text-center border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #09090b, #18181b, #0f2b5c);">
        <div class="position-relative d-inline-block mb-3">
            <div class="rounded-circle bg-danger text-white d-flex align-items-center justify-content-center mx-auto shadow" style="width: 72px; height: 72px; font-size: 1.8rem; font-weight: 700;">
                <i class="fa-solid fa-user-shield"></i>
            </div>
            <span class="position-absolute bottom-0 end-0 bg-success border border-dark rounded-circle p-1" style="width: 16px; height: 16px;" title="Online"></span>
        </div>
        <h6 class="fw-bold mb-0 text-white">${sessionScope.userName != null ? sessionScope.userName : 'Administrator'}</h6>
        <p class="text-secondary small mb-1">${sessionScope.email}</p>
        <c:if test="${not empty sessionScope.regNumber}">
            <div class="mb-2">
                <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 px-2 py-1 small">
                    <i class="fa-solid fa-id-badge me-1"></i> Admin ID: <strong>${sessionScope.regNumber}</strong>
                </span>
            </div>
        </c:if>
        <span class="badge bg-danger bg-opacity-25 text-danger border border-danger border-opacity-25 rounded-pill px-3 py-1 fw-bold fs-8">
            <i class="fa-solid fa-lock me-1"></i> CENTRAL LMS GOVERNANCE
        </span>
    </div>

    <div class="list-group list-group-flush p-2">
        <!-- 0. Admin Profile (AT THE TOP) -->
        <a href="/admin/profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'profile' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-id-card ${param.active == 'profile' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Admin Profile</span>
        </a>

        <a href="/admin/dashboard" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'dashboard' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-gauge-high ${param.active == 'dashboard' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Governance Overview</span>
        </a>

        <div class="px-3 pt-2 pb-1 text-uppercase text-muted fw-bold fs-8">Management Modules</div>

        <!-- 1. Student Management -->
        <a href="/admin/students" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'students' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-user-graduate ${param.active == 'students' ? 'text-white' : 'text-success'}" style="width: 20px;"></i>
            <span class="fw-semibold">Student Management</span>
        </a>

        <!-- 2. Faculty Management -->
        <a href="/admin/faculty" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'faculty' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-chalkboard-user ${param.active == 'faculty' ? 'text-white' : 'text-warning'}" style="width: 20px;"></i>
            <span class="fw-semibold">Faculty Management</span>
        </a>

        <!-- 3. Course Management -->
        <a href="/admin/courses" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'courses' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-book-atlas ${param.active == 'courses' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Course Studio & Catalog</span>
        </a>

        <!-- 4. Study Material Management -->
        <a href="/admin/materials" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'materials' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-file-pdf ${param.active == 'materials' ? 'text-white' : 'text-danger'}" style="width: 20px;"></i>
            <span class="fw-semibold">Study Materials</span>
        </a>

        <!-- 5. Quiz & Assignment Management -->
        <a href="/admin/quizzes" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'quizzes' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-list-check ${param.active == 'quizzes' ? 'text-white' : 'text-info'}" style="width: 20px;"></i>
            <span class="fw-semibold">Quizzes & Assessments</span>
        </a>

        <!-- 6. Live Class Management -->
        <a href="/admin/live" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'live' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-video ${param.active == 'live' ? 'text-white' : 'text-danger'}" style="width: 20px;"></i>
            <span class="fw-semibold">Live Classrooms</span>
            <span class="badge bg-danger rounded-pill ms-auto small">LIVE</span>
        </a>

        <!-- 7. Reports & Analytics -->
        <a href="/admin/reports" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'reports' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-chart-pie ${param.active == 'reports' ? 'text-white' : 'text-info'}" style="width: 20px;"></i>
            <span class="fw-semibold">Reports & Analytics</span>
        </a>

        <!-- 8. System Management -->
        <a href="/admin/system" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'system' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-sliders ${param.active == 'system' ? 'text-white' : 'text-secondary'}" style="width: 20px;"></i>
            <span class="fw-semibold">System Settings</span>
        </a>

        <div class="px-3 pt-2 pb-1 text-uppercase text-muted fw-bold fs-8">Administration Utilities</div>

        <a href="/admin/categories" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'categories' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-tags ${param.active == 'categories' ? 'text-white' : 'text-warning'}" style="width: 20px;"></i>
            <span class="fw-semibold">Taxonomy Categories</span>
        </a>

        <a href="/admin/registrations" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'registrations' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-id-card-clip ${param.active == 'registrations' ? 'text-white' : 'text-warning'}" style="width: 20px;"></i>
            <span class="fw-semibold">Authorized Reg. Numbers</span>
        </a>

        <a href="/admin/announcements" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'announcements' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-bullhorn ${param.active == 'announcements' ? 'text-white' : 'text-info'}" style="width: 20px;"></i>
            <span class="fw-semibold">Announcements</span>
        </a>

        <a href="/admin/messages" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'messages' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-inbox ${param.active == 'messages' ? 'text-white' : 'text-secondary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Contact Inquiries</span>
        </a>

        <a href="/admin/audit-logs" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 ${param.active == 'audit' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-clipboard-list ${param.active == 'audit' ? 'text-white' : 'text-danger'}" style="width: 20px;"></i>
            <span class="fw-semibold">Security Audit Logs</span>
        </a>

        <hr class="my-2 border-secondary border-opacity-10">

        <a href="/logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-2.5 px-3 rounded-3 border-0 text-danger">
            <i class="fa-solid fa-right-from-bracket text-danger" style="width: 20px;"></i>
            <span class="fw-semibold">Sign Out</span>
        </a>
    </div>
</div>