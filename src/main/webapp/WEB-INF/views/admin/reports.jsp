<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Reports & Analytics - Admin - Cloud LMS" />
</jsp:include>

<style>
    .metric-card-report {
        background: white;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 4px 16px rgba(15, 43, 92, 0.04);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .metric-card-report:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(15, 43, 92, 0.08);
    }
</style>

<div class="container py-4">
    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="reports" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-chart-pie text-info me-2"></i> Comprehensive Reports & Analytics</h4>
                        <p class="text-muted small mb-0">High-level institutional intelligence, enrollment metrics, faculty productivity, and assessment outcomes.</p>
                    </div>
                    <button class="btn btn-outline-primary rounded-pill px-3 py-1.5 fw-bold" onclick="window.print()">
                        <i class="fa-solid fa-print me-1"></i> Print / Export Report
                    </button>
                </div>

                <!-- 7 Live Real-Time Dashboard Counters -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3 col-6">
                        <div class="metric-card-report text-center border-primary border-top border-3">
                            <div class="text-muted small fw-bold text-uppercase">Total Students</div>
                            <div class="fs-2 fw-extrabold text-navy my-1">${totalStudents}</div>
                            <span class="badge bg-primary bg-opacity-10 text-primary fs-8">Active Learners</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="metric-card-report text-center border-warning border-top border-3">
                            <div class="text-muted small fw-bold text-uppercase">Total Faculty</div>
                            <div class="fs-2 fw-extrabold text-navy my-1">${totalFaculty}</div>
                            <span class="badge bg-warning bg-opacity-10 text-warning fs-8">Instructors</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="metric-card-report text-center border-info border-top border-3">
                            <div class="text-muted small fw-bold text-uppercase">Total Courses</div>
                            <div class="fs-2 fw-extrabold text-navy my-1">${totalCourses}</div>
                            <span class="badge bg-info bg-opacity-10 text-info fs-8">${publishedCourses} Active</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="metric-card-report text-center border-success border-top border-3">
                            <div class="text-muted small fw-bold text-uppercase">Total Enrollments</div>
                            <div class="fs-2 fw-extrabold text-navy my-1">${totalEnrollments}</div>
                            <span class="badge bg-success bg-opacity-10 text-success fs-8">Course Seats</span>
                        </div>
                    </div>
                    <div class="col-md-4 col-6">
                        <div class="metric-card-report text-center">
                            <div class="text-muted small fw-bold text-uppercase">Total Quizzes</div>
                            <div class="fs-3 fw-bold text-dark my-1">${totalQuizzes} Assessments</div>
                            <div class="small text-muted">Pass Rate: <strong>${passRate}%</strong></div>
                        </div>
                    </div>
                    <div class="col-md-4 col-6">
                        <div class="metric-card-report text-center">
                            <div class="text-muted small fw-bold text-uppercase">Live Classrooms</div>
                            <div class="fs-3 fw-bold text-dark my-1">${totalLiveClasses} Broadcasts</div>
                            <div class="small text-muted">Webinars & Q&As</div>
                        </div>
                    </div>
                    <div class="col-md-4 col-12">
                        <div class="metric-card-report text-center">
                            <div class="text-muted small fw-bold text-uppercase">Course Completion Rate</div>
                            <div class="fs-3 fw-bold text-success my-1">${completionRate}%</div>
                            <div class="small text-muted">Graduation benchmark</div>
                        </div>
                    </div>
                </div>

                <!-- SECTION 1: Student Performance Report -->
                <div class="card bg-light border-0 rounded-4 p-3 mb-4">
                    <h6 class="fw-bold text-navy mb-2"><i class="fa-solid fa-graduation-cap me-2 text-primary"></i> 1. Student Performance & Gradebook Analysis</h6>
                    <p class="small text-muted mb-3">Overall student assessment scoring average across all completed quizzes: <strong>${avgQuizScore}%</strong> with a <strong>${passRate}%</strong> passing rate.</p>
                    <div class="progress mb-2" style="height: 10px;">
                        <div class="progress-bar bg-success" style="width: ${passRate}%;" title="Passed"></div>
                        <div class="progress-bar bg-danger" style="width: ${100 - passRate}%;" title="Failed"></div>
                    </div>
                    <div class="d-flex justify-content-between small text-muted">
                        <span>Passed: <strong>${passRate}%</strong></span>
                        <span>Needs Improvement: <strong>${100 - passRate}%</strong></span>
                    </div>
                </div>

                <!-- SECTION 2: Course Enrollment & Offerings Breakdown -->
                <div class="card bg-light border-0 rounded-4 p-3 mb-4">
                    <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-book-open me-2 text-primary"></i> 2. Course Catalog & Faculty Teaching Distribution</h6>
                    <div class="table-responsive">
                        <table class="table table-sm table-hover align-middle border mb-0 bg-white rounded-3">
                            <thead class="table-light">
                                <tr class="fs-8 text-uppercase text-muted">
                                    <th>Course Title</th>
                                    <th>Assigned Faculty</th>
                                    <th>Category</th>
                                    <th>Level</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${courses}">
                                    <tr>
                                        <td class="fw-bold text-dark">${c.title}</td>
                                        <td class="small">${c.instructorName}</td>
                                        <td><span class="badge bg-primary bg-opacity-10 text-primary">${c.category != null ? c.category.name : 'CS'}</span></td>
                                        <td><span class="badge bg-secondary bg-opacity-10 text-secondary">${c.level}</span></td>
                                        <td>
                                            <span class="badge ${c.published ? 'bg-success' : 'bg-warning'} px-2 py-0.5 rounded-pill fs-8">
                                                ${c.published ? 'Active' : 'Draft'}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- SECTION 3: Recent Assessment Results Stream -->
                <div class="card bg-light border-0 rounded-4 p-3">
                    <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-list-check me-2 text-warning"></i> 3. Recent Quiz Results Stream</h6>
                    <div class="table-responsive">
                        <table class="table table-sm table-hover align-middle border mb-0 bg-white rounded-3">
                            <thead class="table-light">
                                <tr class="fs-8 text-uppercase text-muted">
                                    <th>Student</th>
                                    <th>Quiz</th>
                                    <th>Score</th>
                                    <th>Status</th>
                                    <th>Submitted On</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="sub" items="${submissions}" varStatus="status">
                                    <c:if test="${status.index < 5}">
                                        <tr>
                                            <td class="fw-bold small text-dark">${sub.studentName}</td>
                                            <td class="small">${sub.quiz.title}</td>
                                            <td class="fw-bold ${sub.scorePct >= 60 ? 'text-success' : 'text-danger'}">${sub.scorePct}%</td>
                                            <td><span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'} rounded-pill">${sub.status}</span></td>
                                            <td class="small text-muted">${sub.submittedAt}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
