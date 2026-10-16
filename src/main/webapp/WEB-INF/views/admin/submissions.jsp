<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Student Submissions - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="quizzes" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-graduation-cap text-info me-2"></i> All Student Submissions & Performance</h4>
                        <p class="text-muted small mb-0">Gradebook audit tracking all completed quizzes, scored marks, and pass/fail metrics.</p>
                    </div>
                    <a href="/admin/quizzes" class="btn btn-outline-primary rounded-pill px-3 fw-bold">
                        <i class="fa-solid fa-arrow-left me-1"></i> Back to Quizzes
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Student</th>
                                <th>Assessment & Course</th>
                                <th>Score Marks</th>
                                <th>Percentage</th>
                                <th>Status</th>
                                <th>Date Submitted</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="sub" items="${submissions}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${sub.studentName}</div>
                                        <div class="small text-muted">${sub.studentEmail}</div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark fs-7">${sub.quiz.title}</div>
                                        <span class="badge bg-light text-dark border fs-8">${sub.quiz.course.title}</span>
                                    </td>
                                    <td><strong>${sub.score}</strong> / ${sub.totalPoints}</td>
                                    <td>
                                        <span class="fw-bold ${sub.scorePct >= 60 ? 'text-success' : 'text-danger'}">${sub.scorePct}%</span>
                                    </td>
                                    <td>
                                        <span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'} px-2.5 py-1 rounded-pill">
                                            ${sub.status}
                                        </span>
                                    </td>
                                    <td class="small text-muted">${sub.submittedAt}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
