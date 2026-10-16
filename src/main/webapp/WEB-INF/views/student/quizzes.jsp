<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Assessment & Quiz Hub - Student Portal" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="smenu.jsp">
                <jsp:param name="active" value="quizzes" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-list-check me-2 text-warning"></i> Course Quizzes & Examinations</h4>
                        <p class="text-muted small mb-0">Evaluate your module comprehension through timed assessments with instant automated grading.</p>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty quizzes}">
                        <div class="row g-4">
                            <c:forEach var="qz" items="${quizzes}">
                                <c:set var="lastSub" value="${submissionMap[qz.id]}" />
                                <div class="col-md-6">
                                    <div class="card h-100 border rounded-4 p-4 shadow-none d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="badge bg-primary bg-opacity-10 text-primary small">${qz.course.title}</span>
                                                <c:choose>
                                                    <c:when test="${lastSub != null}">
                                                        <span class="badge ${lastSub.status == 'PASS' ? 'bg-success' : 'bg-danger'} rounded-pill px-3 py-1">
                                                            ${lastSub.scorePct}% (${lastSub.status})
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning bg-opacity-10 text-dark rounded-pill px-3 py-1">Not Attempted</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <h5 class="fw-bold text-dark mb-2">${qz.title}</h5>
                                            <p class="text-muted small mb-3">${qz.description}</p>
                                        </div>

                                        <div class="pt-3 border-top">
                                            <div class="d-flex justify-content-between align-items-center small text-muted mb-3">
                                                <span><i class="fa-regular fa-clock me-1"></i> ${qz.timeLimitMinutes} Mins</span>
                                                <span><i class="fa-solid fa-trophy me-1"></i> Pass: ${qz.passingScorePct}%</span>
                                                <span><i class="fa-solid fa-circle-question me-1"></i> ${qz.questions.size()} Questions</span>
                                            </div>
                                            <a href="/student/quizzes/${qz.id}/start" class="btn btn-warning w-100 rounded-pill fw-bold text-dark">
                                                <i class="fa-solid fa-play me-1"></i> ${lastSub != null ? 'Retake Assessment' : 'Start Timed Assessment'}
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-light rounded-4">
                            <i class="fa-solid fa-spell-check fs-1 text-muted mb-3"></i>
                            <h5 class="fw-bold">No quizzes available yet</h5>
                            <p class="text-muted small mb-3">Enroll in courses to unlock interactive assessments.</p>
                            <a href="/student/courses" class="btn btn-primary">My Courses</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Past Submissions History -->
            <c:if test="${not empty allSubmissions}">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i> Assessment History</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle small mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Assessment Title</th>
                                    <th>Course</th>
                                    <th>Questions</th>
                                    <th>Correct</th>
                                    <th>Score %</th>
                                    <th>Status</th>
                                    <th>Submission Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="sub" items="${allSubmissions}">
                                    <tr>
                                        <td class="fw-bold text-dark">${sub.quiz.title}</td>
                                        <td>${sub.quiz.course.title}</td>
                                        <td>${sub.totalQuestions}</td>
                                        <td class="text-success fw-bold">${sub.correctAnswers}</td>
                                        <td class="fw-bold">${sub.scorePct}%</td>
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
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
