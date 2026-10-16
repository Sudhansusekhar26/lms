<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
    <div class="bg-dark text-white p-4 text-center border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #0f172a, #1e293b);">
        <div class="position-relative d-inline-block mb-3">
            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto shadow" style="width: 72px; height: 72px; font-size: 1.8rem; font-weight: 700;">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <span class="position-absolute bottom-0 end-0 bg-success border border-dark rounded-circle p-1" style="width: 16px; height: 16px;" title="Online"></span>
        </div>
        <h6 class="fw-bold mb-0 text-white">${sessionScope.userName != null ? sessionScope.userName : 'Student Learner'}</h6>
        <p class="text-secondary small mb-1">${sessionScope.email}</p>
        <c:if test="${not empty sessionScope.regNumber}">
            <div class="mb-2">
                <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 px-2 py-1 small">
                    <i class="fa-solid fa-id-card me-1"></i> Reg No: <strong>${sessionScope.regNumber}</strong>
                </span>
            </div>
        </c:if>
        <span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-25 rounded-pill px-3 py-1 fw-bold fs-8">
            <i class="fa-solid fa-shield-check me-1"></i> STUDENT PORTAL
        </span>
    </div>

    <div class="list-group list-group-flush p-2">
        <a href="/student/profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'profile' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-id-card ${param.active == 'profile' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Student Profile</span>
        </a>

        <a href="/student/dashboard" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'dashboard' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-gauge-high ${param.active == 'dashboard' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Learning Hub</span>
        </a>

        <a href="/student/courses" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'courses' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-book-bookmark ${param.active == 'courses' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">My Courses & Syllabus</span>
        </a>

        <a href="/student/quizzes" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'quizzes' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-list-check ${param.active == 'quizzes' ? 'text-white' : 'text-warning'}" style="width: 20px;"></i>
            <span class="fw-semibold">Assessments & Quizzes</span>
        </a>

        <a href="/student/live" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'live' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-video ${param.active == 'live' ? 'text-white' : 'text-danger'}" style="width: 20px;"></i>
            <span class="fw-semibold">Live Classrooms</span>
            <span class="badge bg-danger rounded-pill ms-auto small">LIVE</span>
        </a>

        <a href="/student/analytics" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'analytics' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-chart-line ${param.active == 'analytics' ? 'text-white' : 'text-info'}" style="width: 20px;"></i>
            <span class="fw-semibold">Progress & Analytics</span>
        </a>

        <hr class="my-2 border-secondary border-opacity-10">

        <a href="/catalog" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 text-secondary">
            <i class="fa-solid fa-compass text-secondary" style="width: 20px;"></i>
            <span class="fw-semibold">Discover Courses</span>
        </a>

        <a href="/logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 text-danger">
            <i class="fa-solid fa-right-from-bracket text-danger" style="width: 20px;"></i>
            <span class="fw-semibold">Sign Out</span>
        </a>
    </div>
</div>