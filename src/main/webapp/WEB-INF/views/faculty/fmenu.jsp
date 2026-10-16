<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
    <div class="bg-dark text-white p-4 text-center border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #1e1b4b, #312e81);">
        <div class="position-relative d-inline-block mb-3">
            <div class="rounded-circle bg-purple text-white d-flex align-items-center justify-content-center mx-auto shadow" style="width: 72px; height: 72px; font-size: 1.8rem; font-weight: 700; background-color: #8b5cf6;">
                <i class="fa-solid fa-chalkboard-user"></i>
            </div>
            <span class="position-absolute bottom-0 end-0 bg-success border border-dark rounded-circle p-1" style="width: 16px; height: 16px;" title="Online"></span>
        </div>
        <h6 class="fw-bold mb-0 text-white">${sessionScope.userName != null ? sessionScope.userName : 'Faculty Instructor'}</h6>
        <p class="text-secondary small mb-1">${sessionScope.email}</p>
        <c:if test="${not empty sessionScope.regNumber}">
            <div class="mb-2">
                <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 px-2 py-1 small">
                    <i class="fa-solid fa-id-card me-1"></i> Faculty ID: <strong>${sessionScope.regNumber}</strong>
                </span>
            </div>
        </c:if>
        <span class="badge bg-purple bg-opacity-25 text-white border border-light border-opacity-25 rounded-pill px-3 py-1 fw-bold fs-8" style="background-color: #6366f1;">
            <i class="fa-solid fa-certificate me-1"></i> FACULTY CONSOLE
        </span>
    </div>

    <div class="list-group list-group-flush p-2">
        <a href="/faculty/profile" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'profile' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-id-card ${param.active == 'profile' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Faculty Profile</span>
        </a>

        <a href="/faculty/dashboard" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'dashboard' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-chart-pie ${param.active == 'dashboard' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Faculty Dashboard</span>
        </a>

        <a href="/faculty/courses" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'courses' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-layer-group ${param.active == 'courses' ? 'text-white' : 'text-primary'}" style="width: 20px;"></i>
            <span class="fw-semibold">Course Studio</span>
        </a>

        <a href="/faculty/courses/create" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'create-course' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-square-plus ${param.active == 'create-course' ? 'text-white' : 'text-success'}" style="width: 20px;"></i>
            <span class="fw-semibold">New Course Builder</span>
        </a>

        <a href="/faculty/quizzes" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'quizzes' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-spell-check ${param.active == 'quizzes' ? 'text-white' : 'text-warning'}" style="width: 20px;"></i>
            <span class="fw-semibold">Quiz Engine & MCQ Bank</span>
        </a>

        <a href="/faculty/live" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'live' ? 'active bg-primary text-white' : 'text-danger'}" style="width: 20px;"></i>
            <span class="fw-semibold">Live Class Scheduler</span>
        </a>

        <a href="/faculty/analytics" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 ${param.active == 'analytics' ? 'active bg-primary text-white' : 'text-dark'}">
            <i class="fa-solid fa-graduation-cap ${param.active == 'analytics' ? 'text-white' : 'text-info'}" style="width: 20px;"></i>
            <span class="fw-semibold">Gradebook & Analytics</span>
        </a>

        <hr class="my-2 border-secondary border-opacity-10">

        <a href="/logout" class="list-group-item list-group-item-action d-flex align-items-center gap-3 py-3 px-3 rounded-3 border-0 text-danger">
            <i class="fa-solid fa-right-from-bracket text-danger" style="width: 20px;"></i>
            <span class="fw-semibold">Sign Out</span>
        </a>
    </div>
</div>