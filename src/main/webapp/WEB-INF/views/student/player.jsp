<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="${course.title} - Learning Player" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <!-- Player Top Bar -->
    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white mb-4">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <a href="/student/courses" class="btn btn-outline-secondary btn-sm rounded-pill"><i class="fa-solid fa-arrow-left me-1"></i> Back to Courses</a>
                <div>
                    <h5 class="fw-bold mb-0 text-dark">${course.title}</h5>
                    <span class="text-muted small"><i class="fa-solid fa-user-tie me-1"></i> Instructor: ${course.instructorName != null ? course.instructorName : course.instructorEmail}</span>
                </div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="text-end d-none d-md-block">
                    <span class="small text-muted d-block">Course Progress</span>
                    <strong class="text-primary">${enrollment != null ? enrollment.progressPct : 0}% Completed</strong>
                </div>
                <div class="progress d-none d-md-block" style="width: 120px; height: 8px;">
                    <div class="progress-bar bg-success" role="progressbar" style="width: ${enrollment != null ? enrollment.progressPct : 0}%;"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Course 100% Completion Celebration Banner -->
    <c:if test="${enrollment != null and enrollment.progressPct >= 100}">
        <div class="alert alert-success border-0 shadow-sm rounded-4 p-3 d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4" style="background: linear-gradient(135deg, #dcfce7, #bbf7d0);">
            <div class="d-flex align-items-center gap-3">
                <div class="rounded-circle bg-success text-white p-2 d-flex align-items-center justify-content-center" style="width: 44px; height: 44px;">
                    <i class="fa-solid fa-award fs-4"></i>
                </div>
                <div>
                    <h6 class="fw-bold text-success-emphasis mb-0">Congratulations! You've 100% Completed This Course!</h6>
                    <span class="small text-muted">Your verified official course completion certificate has been generated.</span>
                </div>
            </div>
            <a href="/certificate/CERT-STU-${course.id}-${student != null ? student.id : 1}" target="_blank" class="btn btn-success rounded-pill px-4 fw-bold shadow-sm">
                <i class="fa-solid fa-certificate me-1"></i> View Official Certificate
            </a>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Video & Material Player Column -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-black mb-4">
                <div class="ratio ratio-16x9">
                    <c:choose>
                        <c:when test="${not empty currentLesson and not empty currentLesson.videoUrl}">
                            <iframe src="${currentLesson.videoUrl}" title="${currentLesson.title}" allowfullscreen class="w-100 h-100"></iframe>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex flex-column align-items-center justify-content-center text-white bg-dark">
                                <i class="fa-solid fa-film fs-1 text-secondary mb-2"></i>
                                <p class="text-secondary">Select a lesson from the syllabus on the right to start streaming.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Active Lesson Details & Actions -->
            <c:if test="${not empty currentLesson}">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                    <div class="d-flex flex-wrap justify-content-between align-items-start gap-3 mb-3">
                        <div>
                            <span class="badge bg-primary bg-opacity-10 text-primary small mb-1">Active Lecture</span>
                            <h4 class="fw-bold text-dark mb-1">${currentLesson.title}</h4>
                            <span class="text-muted small"><i class="fa-regular fa-clock me-1"></i> Estimated Duration: ${currentLesson.durationMinutes} Minutes</span>
                        </div>
                        <div class="d-flex gap-2">
                            <c:if test="${not empty currentLesson.materialUrl}">
                                <button type="button" class="btn btn-outline-danger btn-sm rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#pdfModal">
                                    <i class="fa-solid fa-file-pdf me-1"></i> View PDF Notes
                                </button>
                                <a href="${currentLesson.materialUrl}" target="_blank" download class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                                    <i class="fa-solid fa-download me-1"></i> Download
                                </a>
                            </c:if>

                            <form action="/student/lessons/${currentLesson.id}/complete" method="POST">
                                <input type="hidden" name="courseId" value="${course.id}">
                                <c:choose>
                                    <c:when test="${completedLessonIds.contains(currentLesson.id)}">
                                        <button type="button" class="btn btn-success btn-sm rounded-pill px-3" disabled>
                                            <i class="fa-solid fa-circle-check me-1"></i> Completed
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3">
                                            <i class="fa-solid fa-check me-1"></i> Mark as Completed
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                    </div>

                    <!-- Interactive Learning Hub: Overview & Study Notes -->
                    <div class="border-top pt-3">
                        <ul class="nav nav-pills mb-3 gap-2" id="lessonTabs" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active rounded-pill px-3 py-1 btn-sm fw-semibold" id="overview-tab" data-bs-toggle="pill" data-bs-target="#overview-content" type="button">
                                    <i class="fa-solid fa-book-open me-1"></i> Lecture Overview
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link rounded-pill px-3 py-1 btn-sm fw-semibold" id="notes-tab" data-bs-toggle="pill" data-bs-target="#notes-content" type="button">
                                    <i class="fa-solid fa-pen-nib me-1"></i> My Study Notes <span class="badge bg-warning text-dark ms-1" id="notesStatusBadge">Auto-Save</span>
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content" id="lessonTabsContent">
                            <div class="tab-pane fade show active" id="overview-content" role="tabpanel">
                                <p class="text-muted small leading-relaxed mb-0">
                                    ${currentLesson.contentText != null ? currentLesson.contentText : 'Follow along with the video lecture and review reference architecture documents.'}
                                </p>
                            </div>
                            <div class="tab-pane fade" id="notes-content" role="tabpanel">
                                <div class="p-3 rounded-3 bg-light border">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fs-8 text-muted"><i class="fa-solid fa-cloud-arrow-up text-success me-1"></i> Notes persist in your browser</span>
                                        <div class="d-flex gap-2">
                                            <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill py-0.5 px-2.5 fs-8" onclick="exportNotes()">
                                                <i class="fa-solid fa-download me-1"></i> Export .txt
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-danger rounded-pill py-0.5 px-2.5 fs-8" onclick="clearNotes()">
                                                <i class="fa-solid fa-trash me-1"></i> Clear
                                            </button>
                                        </div>
                                    </div>
                                    <textarea id="studyNotesBox" class="form-control border-0 rounded-3 shadow-none bg-white p-3 small" rows="5" placeholder="Type personal notes, formulas, or key timestamps here... Auto-saves with every keystroke!"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Course Quizzes Quick Hook -->
            <c:if test="${not empty course.quizzes}">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-spell-check me-2 text-warning"></i> Module Assessments</h5>
                    <div class="d-flex flex-column gap-2">
                        <c:forEach var="qz" items="${course.quizzes}">
                            <div class="p-3 rounded-3 bg-light border d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="fw-bold mb-1 text-dark">${qz.title}</h6>
                                    <span class="text-muted fs-8"><i class="fa-regular fa-clock me-1"></i> ${qz.timeLimitMinutes} Mins &bull; Passing Grade: ${qz.passingScorePct}% &bull; ${qz.questions.size()} Questions</span>
                                </div>
                                <a href="/student/quizzes/${qz.id}/start" class="btn btn-warning btn-sm rounded-pill px-3 fw-bold">
                                    <i class="fa-solid fa-play me-1"></i> Take Quiz
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Syllabus Tree Column -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                <div class="card-header bg-dark text-white p-3 d-flex justify-content-between align-items-center">
                    <h6 class="fw-bold mb-0"><i class="fa-solid fa-list-ol me-2 text-primary"></i> Course Syllabus</h6>
                    <span class="badge bg-secondary bg-opacity-25 text-white fs-8">${course.totalLessons} Lessons</span>
                </div>

                <div class="accordion accordion-flush" id="playerSyllabusAccordion">
                    <c:forEach var="sec" items="${course.sections}" varStatus="sStat">
                        <div class="accordion-item border-bottom">
                            <h2 class="accordion-header" id="headingSec${sec.id}">
                                <button class="accordion-button ${sStat.first ? '' : 'collapsed'} fw-bold bg-light py-3 px-3 small" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSec${sec.id}">
                                    <span class="badge bg-primary rounded-pill me-2">${sStat.index + 1}</span>
                                    ${sec.title}
                                </button>
                            </h2>
                            <div id="collapseSec${sec.id}" class="accordion-collapse collapse ${sStat.first ? 'show' : ''}" data-bs-parent="#playerSyllabusAccordion">
                                <div class="accordion-body p-0">
                                    <div class="list-group list-group-flush small">
                                        <c:forEach var="les" items="${sec.lessons}">
                                            <a href="/student/courses/${course.id}/learn?lessonId=${les.id}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center py-3 px-3 border-0 ${currentLesson != null && currentLesson.id == les.id ? 'active bg-primary text-white' : ''}">
                                                <div class="d-flex align-items-center gap-2">
                                                    <c:choose>
                                                        <c:when test="${completedLessonIds.contains(les.id)}">
                                                            <i class="fa-solid fa-circle-check text-success fs-6"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa-regular fa-circle ${currentLesson != null && currentLesson.id == les.id ? 'text-white' : 'text-muted'} fs-6"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="fw-semibold">${les.title}</span>
                                                </div>
                                                <span class="badge ${currentLesson != null && currentLesson.id == les.id ? 'bg-light text-primary' : 'bg-light text-muted'} border">${les.durationMinutes}m</span>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- PDF Material Viewer Modal -->
<c:if test="${not empty currentLesson and not empty currentLesson.materialUrl}">
    <div class="modal fade" id="pdfModal" tabindex="-1" aria-labelledby="pdfModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 overflow-hidden">
                <div class="modal-header bg-dark text-white p-3">
                    <h5 class="modal-title fw-bold" id="pdfModalLabel"><i class="fa-solid fa-file-pdf text-danger me-2"></i> ${currentLesson.materialName != null ? currentLesson.materialName : 'Lecture PDF Document'}</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-0" style="height: 75vh;">
                    <iframe src="${currentLesson.materialUrl}" class="w-100 h-100" frameborder="0"></iframe>
                </div>
                <div class="modal-footer bg-light p-2">
                    <a href="${currentLesson.materialUrl}" target="_blank" download class="btn btn-primary btn-sm"><i class="fa-solid fa-download me-1"></i> Download PDF</a>
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close Viewer</button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script>
    (function() {
        const storageKey = 'lms_notes_${course.id}_${currentLesson != null ? currentLesson.id : "general"}';
        const notesBox = document.getElementById('studyNotesBox');
        const badge = document.getElementById('notesStatusBadge');

        if (notesBox) {
            const saved = localStorage.getItem(storageKey);
            if (saved) notesBox.value = saved;

            notesBox.addEventListener('input', function() {
                localStorage.setItem(storageKey, notesBox.value);
                if (badge) {
                    badge.innerText = 'Saved';
                    badge.className = 'badge bg-success text-white ms-1';
                    setTimeout(() => {
                        badge.innerText = 'Auto-Save';
                        badge.className = 'badge bg-warning text-dark ms-1';
                    }, 1200);
                }
            });
        }

        window.exportNotes = function() {
            if (!notesBox || !notesBox.value.trim()) {
                alert('No notes written yet to export.');
                return;
            }
            const blob = new Blob([notesBox.value], { type: 'text/plain;charset=utf-8' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'StudyNotes-${course.title}-${currentLesson != null ? currentLesson.title : "Lesson"}.txt';
            link.click();
        };

        window.clearNotes = function() {
            if (confirm('Are you sure you want to clear your notes for this lesson?')) {
                if (notesBox) notesBox.value = '';
                localStorage.removeItem(storageKey);
            }
        };
    })();
</script>

<jsp:include page="../footer.jsp" />
