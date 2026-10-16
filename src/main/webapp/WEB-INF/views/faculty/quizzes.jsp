<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Quiz Engine - Faculty Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="quizzes" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-spell-check me-2 text-warning"></i> Quiz Engine & Question Banks</h4>
                        <p class="text-muted small mb-0">Create timed multiple-choice assessments with automated grading rules and explanation keys.</p>
                    </div>
                    <button type="button" class="btn btn-warning btn-sm px-3 py-2 fw-bold text-dark rounded-pill" data-bs-toggle="modal" data-bs-target="#createQuizModal">
                        <i class="fa-solid fa-plus me-1"></i> Build New Quiz
                    </button>
                </div>

                <c:choose>
                    <c:when test="${not empty quizzes}">
                        <div class="row g-4">
                            <c:forEach var="qz" items="${quizzes}">
                                <div class="col-md-6">
                                    <div class="card h-100 border rounded-4 p-4 shadow-none d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="badge bg-primary bg-opacity-10 text-primary small">${qz.course.title}</span>
                                                <span class="badge bg-secondary bg-opacity-10 text-secondary">${qz.questions.size()} Questions</span>
                                            </div>
                                            <h5 class="fw-bold text-dark mb-2">${qz.title}</h5>
                                            <p class="text-muted small mb-3">${qz.description}</p>
                                        </div>

                                        <div class="pt-3 border-top">
                                            <div class="d-flex justify-content-between align-items-center small text-muted mb-3">
                                                <span><i class="fa-regular fa-clock me-1"></i> ${qz.timeLimitMinutes} Mins Limit</span>
                                                <span><i class="fa-solid fa-award me-1"></i> Pass: ${qz.passingScorePct}%</span>
                                            </div>
                                            <a href="/faculty/quizzes/${qz.id}/questions" class="btn btn-outline-warning w-100 rounded-pill fw-bold text-dark">
                                                <i class="fa-solid fa-pen-to-square me-1"></i> Manage Question Bank (${qz.questions.size()})
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-light rounded-4 text-muted">
                            <i class="fa-solid fa-list-check fs-1 mb-3 text-secondary"></i>
                            <h5 class="fw-bold">No quizzes created yet</h5>
                            <p class="small mb-3">Build an automated assessment for your course students.</p>
                            <button type="button" class="btn btn-warning text-dark fw-bold" data-bs-toggle="modal" data-bs-target="#createQuizModal">
                                Create Your First Quiz
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Create Quiz Modal -->
<div class="modal fade" id="createQuizModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Create New Assessment</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/faculty/quizzes/create" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Select Course</label>
                        <select name="courseId" class="form-select" required>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}">${c.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Quiz Title</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g. Midterm Assessment: Cloud Patterns" required>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-6">
                            <label class="form-label fw-semibold text-dark small">Time Limit (Minutes)</label>
                            <input type="number" name="timeLimitMinutes" class="form-control" value="15" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label fw-semibold text-dark small">Passing Grade (%)</label>
                            <input type="number" name="passingScorePct" class="form-control" value="60" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Description</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Brief assessment instructions..."></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Proceed to Questions</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
