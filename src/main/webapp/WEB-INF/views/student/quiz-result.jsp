<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Assessment Results - ${quiz.title}" />
</jsp:include>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <!-- Score Overview Card -->
            <div class="card border-0 shadow-lg rounded-4 overflow-hidden mb-4 text-center">
                <div class="p-5 text-white" style="background: ${submission.status == 'PASS' ? 'linear-gradient(135deg, #065f46, #047857)' : 'linear-gradient(135deg, #991b1b, #b91c1c)'};">
                    <div class="rounded-circle bg-white bg-opacity-20 d-inline-flex p-4 mb-3">
                        <i class="fa-solid ${submission.status == 'PASS' ? 'fa-award text-warning' : 'fa-circle-exclamation text-white'} fs-1"></i>
                    </div>
                    <h2 class="fw-extrabold mb-1">Assessment Complete!</h2>
                    <p class="text-white text-opacity-75 small mb-3">${quiz.title} &bull; ${quiz.course.title}</p>
                    
                    <div class="d-inline-flex align-items-center gap-3 bg-black bg-opacity-30 px-4 py-2 rounded-pill mb-2">
                        <span class="fs-4 fw-extrabold text-white">${submission.scorePct}%</span>
                        <span class="badge ${submission.status == 'PASS' ? 'bg-success' : 'bg-danger'} px-3 py-1 rounded-pill fw-bold">${submission.status}</span>
                    </div>
                    <p class="small text-white text-opacity-75 mb-0">Passing Grade Requirement: ${quiz.passingScorePct}%</p>
                </div>

                <div class="card-body p-4 bg-white">
                    <div class="row g-3 text-center">
                        <div class="col-4 border-end">
                            <h4 class="fw-bold text-dark mb-0">${submission.totalQuestions}</h4>
                            <span class="text-muted small">Total Questions</span>
                        </div>
                        <div class="col-4 border-end">
                            <h4 class="fw-bold text-success mb-0">${submission.correctAnswers}</h4>
                            <span class="text-muted small">Correct Answers</span>
                        </div>
                        <div class="col-4">
                            <h4 class="fw-bold text-danger mb-0">${submission.wrongAnswers}</h4>
                            <span class="text-muted small">Incorrect Answers</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Detailed Question Breakdown & Explanations -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-list-check me-2 text-primary"></i> Question Review & Explanations</h5>

                <div class="d-flex flex-column gap-4">
                    <c:forEach var="q" items="${quiz.questions}" varStatus="status">
                        <c:set var="userAnsKey" value="question_${q.id}" />
                        <c:set var="userAns" value="${userAnswers[userAnsKey]}" />
                        <c:set var="isCorrect" value="${userAns != null && userAns.equalsIgnoreCase(q.correctAnswer)}" />

                        <div class="p-4 rounded-4 border ${isCorrect ? 'border-success bg-success bg-opacity-5' : 'border-danger bg-danger bg-opacity-5'}">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge ${isCorrect ? 'bg-success' : 'bg-danger'} rounded-pill px-3 py-1">
                                    <i class="fa-solid ${isCorrect ? 'fa-check' : 'fa-xmark'} me-1"></i> Question ${status.index + 1}
                                </span>
                                <span class="small fw-bold ${isCorrect ? 'text-success' : 'text-danger'}">
                                    <c:choose>
                                        <c:when test="${isCorrect}">+${q.points} Point(s)</c:when>
                                        <c:otherwise>0 Points</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <h6 class="fw-bold text-dark mb-3">${q.questionText}</h6>

                            <div class="row g-2 mb-3 small">
                                <div class="col-md-6">
                                    <div class="p-2 rounded-2 border ${q.correctAnswer == 'A' ? 'bg-success text-white fw-bold' : (userAns == 'A' ? 'bg-danger text-white' : 'bg-white')}">
                                        A. ${q.optionA}
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-2 rounded-2 border ${q.correctAnswer == 'B' ? 'bg-success text-white fw-bold' : (userAns == 'B' ? 'bg-danger text-white' : 'bg-white')}">
                                        B. ${q.optionB}
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-2 rounded-2 border ${q.correctAnswer == 'C' ? 'bg-success text-white fw-bold' : (userAns == 'C' ? 'bg-danger text-white' : 'bg-white')}">
                                        C. ${q.optionC}
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-2 rounded-2 border ${q.correctAnswer == 'D' ? 'bg-success text-white fw-bold' : (userAns == 'D' ? 'bg-danger text-white' : 'bg-white')}">
                                        D. ${q.optionD}
                                    </div>
                                </div>
                            </div>

                            <div class="p-3 bg-white rounded-3 border small">
                                <strong class="text-primary d-block mb-1"><i class="fa-solid fa-lightbulb me-1"></i> Correct Answer: Option ${q.correctAnswer}</strong>
                                <span class="text-muted">${q.explanation != null ? q.explanation : 'Review lecture syllabus for relevant documentation.'}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Return Actions -->
            <div class="d-flex justify-content-center gap-3">
                <a href="/student/quizzes" class="btn btn-outline-secondary px-4 fw-semibold"><i class="fa-solid fa-arrow-left me-1"></i> Back to Quizzes</a>
                <a href="/student/courses/${quiz.course.id}/learn" class="btn btn-primary px-4 fw-bold"><i class="fa-solid fa-play me-1"></i> Continue Course Player</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
