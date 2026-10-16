<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Faculty Studio - Cloud LMS" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="dashboard" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <!-- Welcome Header -->
            <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 text-white" style="background: linear-gradient(135deg, #1e1b4b, #312e81);">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <span class="badge bg-purple bg-opacity-25 text-white" style="background-color: #8b5cf6;">FACULTY MANAGEMENT CONSOLE</span>
                            <c:if test="${not empty sessionScope.regNumber}">
                                <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 fw-bold">
                                    <i class="fa-solid fa-id-card me-1"></i> Faculty ID: ${sessionScope.regNumber}
                                </span>
                            </c:if>
                        </div>
                        <h2 class="fw-bold mb-1">Instructor Studio: ${sessionScope.userName != null ? sessionScope.userName : 'Professor'}</h2>
                        <p class="text-secondary small mb-0">Manage course syllabi, upload PDF lecture notes, build auto-grading quiz banks, and host live video masterclasses.</p>
                    </div>
                    <div class="col-md-4 text-md-end mt-3 mt-md-0">
                        <a href="/faculty/courses/create" class="btn btn-light text-primary btn-sm px-3 py-2 fw-bold"><i class="fa-solid fa-plus me-1"></i> Create New Course</a>
                    </div>
                </div>
            </div>

            <!-- Stats Ticker -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white d-flex flex-row align-items-center gap-3">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-book-open fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${totalCourses}</h4>
                            <span class="text-muted small">Managed Courses</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white d-flex flex-row align-items-center gap-3">
                        <div class="bg-success bg-opacity-10 text-success rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-users fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${totalStudents}</h4>
                            <span class="text-muted small">Total Students Enrolled</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white d-flex flex-row align-items-center gap-3">
                        <div class="bg-warning bg-opacity-10 text-warning rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-spell-check fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${totalSubmissions}</h4>
                            <span class="text-muted small">Graded Submissions</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Courses & Syllabus Quick Studio -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-layer-group me-2 text-primary"></i> My Active Courses</h5>
                    <a href="/faculty/courses" class="btn btn-sm btn-outline-primary">Manage All</a>
                </div>

                <c:choose>
                    <c:when test="${not empty courses}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle small mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Course Title</th>
                                        <th>Category</th>
                                        <th>Level</th>
                                        <th>Syllabus Lessons</th>
                                        <th>Status</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${courses}">
                                        <tr>
                                            <td class="fw-bold text-dark">${c.title}</td>
                                            <td><span class="badge bg-light text-dark border">${c.category != null ? c.category.name : 'Engineering'}</span></td>
                                            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">${c.level}</span></td>
                                            <td>${c.totalLessons} Lessons</td>
                                            <td>
                                                <span class="badge ${c.published ? 'bg-success' : 'bg-secondary'} rounded-pill px-3 py-1">
                                                    ${c.published ? 'Published' : 'Draft'}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <a href="/faculty/courses/${c.id}/builder" class="btn btn-sm btn-primary rounded-pill px-3">
                                                    <i class="fa-solid fa-pen-ruler me-1"></i> Syllabus Studio
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-4 text-center bg-light rounded-4 text-muted">
                            <p class="mb-2">No courses created yet.</p>
                            <a href="/faculty/courses/create" class="btn btn-sm btn-primary">Create Your First Course</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Recent Quiz Submissions Table -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-chart-simple me-2 text-warning"></i> Recent Student Submissions</h5>
                    <a href="/faculty/analytics" class="btn btn-sm btn-outline-secondary">Full Gradebook</a>
                </div>
                <c:choose>
                    <c:when test="${not empty recentSubmissions}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle small mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Student</th>
                                        <th>Assessment</th>
                                        <th>Score</th>
                                        <th>Grade Status</th>
                                        <th>Submitted At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sub" items="${recentSubmissions}">
                                        <tr>
                                            <td class="fw-semibold text-dark">${sub.studentName} (${sub.studentEmail})</td>
                                            <td>${sub.quiz.title}</td>
                                            <td class="fw-bold text-primary">${sub.scorePct}%</td>
                                            <td><span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'}">${sub.status}</span></td>
                                            <td class="text-muted">${sub.submittedAt}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted small mb-0">No submissions received yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
