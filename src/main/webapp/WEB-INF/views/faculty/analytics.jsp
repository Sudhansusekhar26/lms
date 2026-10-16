<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Gradebook & Performance - Faculty Console" />
</jsp:include>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="analytics" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-graduation-cap me-2 text-info"></i> Class Gradebook & Performance Metrics</h4>
                <p class="text-muted small mb-4">Comprehensive overview of student quiz scores, pass/fail metrics, and submission audit logs.</p>

                <!-- Metrics Row -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-primary mb-1">${totalStudents}</h3>
                            <span class="text-muted small">Total Students</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-info mb-1">${submissions.size()}</h3>
                            <span class="text-muted small">Total Submissions</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-success mb-1">${avgScore}%</h3>
                            <span class="text-muted small">Average Score</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-warning mb-1">${passRate}%</h3>
                            <span class="text-muted small">Class Pass Rate</span>
                        </div>
                    </div>
                </div>

                <!-- Submissions Gradebook Table -->
                <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-table-list me-2 text-primary"></i> Student Assessment Submissions</h5>
                <c:choose>
                    <c:when test="${not empty submissions}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle small mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Student Name</th>
                                        <th>Student Email</th>
                                        <th>Assessment Title</th>
                                        <th>Course</th>
                                        <th>Score</th>
                                        <th>Grade</th>
                                        <th>Submitted At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sub" items="${submissions}">
                                        <tr>
                                            <td class="fw-bold text-dark">${sub.studentName}</td>
                                            <td><code>${sub.studentEmail}</code></td>
                                            <td>${sub.quiz.title}</td>
                                            <td>${sub.quiz.course.title}</td>
                                            <td class="fw-bold text-primary">${sub.scorePct}% (${sub.correctAnswers}/${sub.totalQuestions})</td>
                                            <td>
                                                <span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'} rounded-pill px-3 py-1">
                                                    ${sub.status}
                                                </span>
                                            </td>
                                            <td class="text-muted">${sub.submittedAt}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-4 text-center bg-light rounded-4 text-muted">
                            <p class="mb-0">No student assessment submissions recorded yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
