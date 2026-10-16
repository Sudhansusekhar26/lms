<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Question Authoring Studio - ${quiz.title}" />
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
            <!-- Quiz Info Header -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <a href="/faculty/quizzes" class="btn btn-outline-secondary btn-sm rounded-circle"><i class="fa-solid fa-arrow-left"></i></a>
                        <div>
                            <span class="badge bg-warning bg-opacity-10 text-dark small mb-1">${quiz.course.title} &bull; ${quiz.timeLimitMinutes} Mins</span>
                            <h4 class="fw-bold mb-0 text-dark">${quiz.title}</h4>
                        </div>
                    </div>
                    <button type="button" class="btn btn-primary btn-sm rounded-pill px-3 fw-bold" data-bs-toggle="modal" data-bs-target="#addQuestionModal">
                        <i class="fa-solid fa-plus me-1"></i> Add MCQ Question
                    </button>
                </div>
            </div>

            <!-- Existing Questions List -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-spell-check me-2 text-primary"></i> Question Bank (${questions.size()} Questions)</h5>

                <c:choose>
                    <c:when test="${not empty questions}">
                        <div class="d-flex flex-column gap-3">
                            <c:forEach var="q" items="${questions}" varStatus="status">
                                <div class="p-4 rounded-4 border bg-light">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge bg-dark rounded-pill">Question ${status.index + 1}</span>
                                        <span class="badge bg-primary bg-opacity-10 text-primary">${q.points} Point(s)</span>
                                    </div>
                                    <h6 class="fw-bold text-dark mb-3">${q.questionText}</h6>
                                    
                                    <div class="row g-2 mb-3 small">
                                        <div class="col-md-6">
                                            <div class="p-2 rounded-2 border ${q.correctAnswer == 'A' ? 'bg-success text-white fw-bold' : 'bg-white text-dark'}">
                                                A. ${q.optionA}
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="p-2 rounded-2 border ${q.correctAnswer == 'B' ? 'bg-success text-white fw-bold' : 'bg-white text-dark'}">
                                                B. ${q.optionB}
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="p-2 rounded-2 border ${q.correctAnswer == 'C' ? 'bg-success text-white fw-bold' : 'bg-white text-dark'}">
                                                C. ${q.optionC}
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="p-2 rounded-2 border ${q.correctAnswer == 'D' ? 'bg-success text-white fw-bold' : 'bg-white text-dark'}">
                                                D. ${q.optionD}
                                            </div>
                                        </div>
                                    </div>

                                    <div class="p-2 rounded bg-white border text-muted fs-8">
                                        <strong class="text-success"><i class="fa-solid fa-check me-1"></i> Correct Key: Option ${q.correctAnswer}</strong>
                                        <c:if test="${not empty q.explanation}">
                                            &bull; <span>Explanation: ${q.explanation}</span>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-light rounded-4 text-muted">
                            <p class="mb-3">No questions in this assessment bank yet.</p>
                            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addQuestionModal">
                                Add First Question
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Add Question Modal -->
<div class="modal fade" id="addQuestionModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Add Question to Quiz</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/faculty/quizzes/${quiz.id}/questions/add" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label fw-semibold text-dark small">Question Prompt / Problem Statement</label>
                            <textarea name="questionText" class="form-control" rows="3" placeholder="Enter question..." required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Option A</label>
                            <input type="text" name="optionA" class="form-control" placeholder="Option A text" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Option B</label>
                            <input type="text" name="optionB" class="form-control" placeholder="Option B text" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Option C</label>
                            <input type="text" name="optionC" class="form-control" placeholder="Option C text" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Option D</label>
                            <input type="text" name="optionD" class="form-control" placeholder="Option D text" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Correct Answer Key</label>
                            <select name="correctAnswer" class="form-select" required>
                                <option value="A">Option A</option>
                                <option value="B">Option B</option>
                                <option value="C">Option C</option>
                                <option value="D">Option D</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Marks / Points</label>
                            <input type="number" name="points" class="form-control" value="1" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold text-dark small">Answer Explanation & References</label>
                            <textarea name="explanation" class="form-control" rows="2" placeholder="Explain why this option is correct..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Save Question</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
