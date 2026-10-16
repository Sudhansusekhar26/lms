<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="${quiz.title} - Live Assessment" />
</jsp:include>

<div class="container py-4">
    <!-- Quiz Header & Floating Timer -->
    <div class="card border-0 shadow-sm rounded-4 p-4 bg-dark text-white mb-4 sticky-top" style="background: linear-gradient(135deg, #0f172a, #1e1b4b); z-index: 1020; top: 15px;">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <span class="badge bg-warning text-dark fw-bold mb-1"><i class="fa-solid fa-stopwatch me-1"></i> TIMED EXAMINATION</span>
                <h4 class="fw-bold mb-0 text-white">${quiz.title}</h4>
                <span class="text-secondary small">${quiz.course.title} &bull; ${questions.size()} Questions</span>
            </div>
            <div class="d-flex align-items-center gap-3 bg-black bg-opacity-50 px-4 py-2 rounded-pill border border-secondary border-opacity-25">
                <i class="fa-solid fa-clock-rotate-left text-warning fs-5"></i>
                <div>
                    <span class="fs-8 text-secondary d-block text-uppercase">Time Remaining</span>
                    <span id="countdownTimer" class="fs-4 fw-extrabold text-warning tracking-wider">--:--</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Quiz Question Form -->
    <form action="/student/quizzes/${quiz.id}/submit" method="POST" id="quizForm">
        <div class="row g-4">
            <div class="col-lg-8">
                <c:forEach var="q" items="${questions}" varStatus="status">
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4" id="questionCard_${q.id}">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <span class="badge bg-primary rounded-pill px-3 py-1">Question ${status.index + 1} of ${questions.size()}</span>
                            <span class="badge bg-light text-muted border">${q.points} Point(s)</span>
                        </div>

                        <h5 class="fw-bold text-dark mb-4 leading-relaxed">${q.questionText}</h5>

                        <div class="d-flex flex-column gap-3">
                            <label class="p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer option-label hover-bg-light">
                                <input type="radio" name="question_${q.id}" value="A" class="form-check-input" onchange="markAnswered(${status.index + 1})">
                                <span class="fw-bold text-primary">A.</span>
                                <span class="text-dark small">${q.optionA}</span>
                            </label>

                            <label class="p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer option-label hover-bg-light">
                                <input type="radio" name="question_${q.id}" value="B" class="form-check-input" onchange="markAnswered(${status.index + 1})">
                                <span class="fw-bold text-primary">B.</span>
                                <span class="text-dark small">${q.optionB}</span>
                            </label>

                            <label class="p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer option-label hover-bg-light">
                                <input type="radio" name="question_${q.id}" value="C" class="form-check-input" onchange="markAnswered(${status.index + 1})">
                                <span class="fw-bold text-primary">C.</span>
                                <span class="text-dark small">${q.optionC}</span>
                            </label>

                            <label class="p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer option-label hover-bg-light">
                                <input type="radio" name="question_${q.id}" value="D" class="form-check-input" onchange="markAnswered(${status.index + 1})">
                                <span class="fw-bold text-primary">D.</span>
                                <span class="text-dark small">${q.optionD}</span>
                            </label>
                        </div>
                    </div>
                </c:forEach>

                <div class="d-flex justify-content-end mb-5">
                    <button type="button" class="btn btn-brand btn-lg px-5 py-3 fw-bold" data-bs-toggle="modal" data-bs-target="#submitModal">
                        <i class="fa-solid fa-paper-plane me-2"></i> Submit Assessment
                    </button>
                </div>
            </div>

            <!-- Question Jump Navigator -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white sticky-top" style="top: 130px;">
                    <h6 class="fw-bold mb-3 text-dark"><i class="fa-solid fa-table-cells me-2 text-primary"></i> Question Navigator</h6>
                    <div class="d-flex flex-wrap gap-2 mb-4">
                        <c:forEach var="q" items="${questions}" varStatus="status">
                            <a href="#questionCard_${q.id}" id="navBadge_${status.index + 1}" class="btn btn-outline-secondary btn-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 38px; height: 38px; font-weight: 700;">
                                ${status.index + 1}
                            </a>
                        </c:forEach>
                    </div>

                    <div class="border-top pt-3 small text-muted d-flex flex-column gap-2">
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-success rounded-circle p-1" style="width: 12px; height: 12px;"></span>
                            <span>Answered Question</span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-secondary rounded-circle p-1" style="width: 12px; height: 12px;"></span>
                            <span>Unanswered Question</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Submit Confirmation Modal -->
        <div class="modal fade" id="submitModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 border-0">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="modal-title fw-bold text-dark">Confirm Submission</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body py-4 text-center">
                        <i class="fa-solid fa-circle-question fs-1 text-warning mb-3"></i>
                        <p class="text-muted mb-0">Are you sure you want to finalize and grade your assessment? Once submitted, your score will be computed instantly.</p>
                    </div>
                    <div class="modal-footer border-0 pt-0">
                        <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">Review Answers</button>
                        <button type="submit" class="btn btn-primary px-4 fw-bold">Yes, Grade Now</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // Live Countdown Timer
    var totalSeconds = ${quiz.timeLimitMinutes} * 60;
    var timerDisplay = document.getElementById('countdownTimer');
    var quizForm = document.getElementById('quizForm');

    function updateTimer() {
        var minutes = Math.floor(totalSeconds / 60);
        var seconds = totalSeconds % 60;

        timerDisplay.textContent = 
            (minutes < 10 ? "0" + minutes : minutes) + ":" + 
            (seconds < 10 ? "0" + seconds : seconds);

        if (totalSeconds <= 120) {
            timerDisplay.classList.remove('text-warning');
            timerDisplay.classList.add('text-danger', 'animate-pulse');
        }

        if (totalSeconds <= 0) {
            clearInterval(timerInterval);
            alert("Time is up! Your assessment is submitting automatically.");
            quizForm.submit();
        } else {
            totalSeconds--;
        }
    }

    var timerInterval = setInterval(updateTimer, 1000);
    updateTimer();

    function markAnswered(questionNumber) {
        var badge = document.getElementById('navBadge_' + questionNumber);
        if (badge) {
            badge.classList.remove('btn-outline-secondary');
            badge.classList.add('btn-success', 'text-white');
        }
    }
</script>

<jsp:include page="../footer.jsp" />
