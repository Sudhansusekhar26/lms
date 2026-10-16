<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Quiz & Assessment Management - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <c:if test="${not empty param.msg}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check fs-4 text-success"></i>
            <div><strong>Success!</strong> ${param.msg}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

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
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-list-check text-info me-2"></i> Quiz & Assessment Management</h4>
                        <p class="text-muted small mb-0">View, create, approve, and moderate MCQ quizzes and evaluation benchmarks across all courses.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="/admin/submissions" class="btn btn-outline-primary rounded-pill px-3 fw-bold">
                            <i class="fa-solid fa-graduation-cap me-1"></i> View Submissions (${submissions.size()})
                        </a>
                        <button type="button" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#createQuizModal">
                            <i class="fa-solid fa-plus-circle me-1"></i> Create Quiz
                        </button>
                    </div>
                </div>

                <!-- Quizzes Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Quiz Title</th>
                                <th>Course</th>
                                <th>Questions</th>
                                <th>Passing Score %</th>
                                <th>Time Limit</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="q" items="${quizzes}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${q.title}</div>
                                        <div class="small text-muted">${q.description}</div>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary bg-opacity-10 text-primary">${q.course.title}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary bg-opacity-10 text-secondary">${q.questions != null ? q.questions.size() : 0} Questions</span>
                                    </td>
                                    <td>
                                        <span class="fw-bold text-success">${q.passingScorePct}%</span>
                                    </td>
                                    <td class="small text-muted fw-bold">${q.timeLimitMinutes} min</td>
                                    <td class="text-end">
                                        <form action="/admin/quizzes/${q.id}/delete" method="POST" class="d-inline" onsubmit="return confirm('Delete quiz: ${q.title}?');">
                                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2.5" title="Delete Quiz">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL: Create Quiz -->
<div class="modal fade" id="createQuizModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-primary text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-plus-circle me-2"></i> Create Assessment Quiz</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/quizzes/create" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Select Course *</label>
                            <select name="courseId" class="form-select rounded-3" required>
                                <c:forEach var="c" items="${courses}">
                                    <option value="${c.id}">${c.title} (${c.instructorName})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Quiz Title *</label>
                            <input type="text" name="title" class="form-control rounded-3" placeholder="e.g. Java Foundations Module 1 Quiz" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Description</label>
                            <textarea name="description" class="form-control rounded-3" rows="2" placeholder="Brief assessment objectives..."></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Time Limit (Minutes)</label>
                            <input type="number" name="timeLimitMinutes" class="form-control rounded-3" value="20" min="5" max="180">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Passing Score %</label>
                            <input type="number" name="passingScorePct" class="form-control rounded-3" value="60" min="10" max="100">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">
                        <i class="fa-solid fa-check me-1"></i> Create Quiz
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
