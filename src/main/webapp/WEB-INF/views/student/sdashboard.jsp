<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Student Learning Hub - Cloud LMS" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="smenu.jsp">
                <jsp:param name="active" value="dashboard" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <!-- Welcome Header -->
            <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 text-white" style="background: linear-gradient(135deg, #1e1b4b, #312e81);">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <span class="badge bg-primary bg-opacity-25 text-cyan">STUDENT LEARNER PORTAL</span>
                            <c:if test="${not empty sessionScope.regNumber}">
                                <span class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 fw-bold">
                                    <i class="fa-solid fa-id-card me-1"></i> Reg No: ${sessionScope.regNumber}
                                </span>
                            </c:if>
                        </div>
                        <h2 class="fw-bold mb-1">Welcome back, ${sessionScope.userName != null ? sessionScope.userName : 'Student'}! 👋</h2>
                        <p class="text-secondary small mb-0">Continue your active curricula, attend live webinars, and test your skills with auto-graded quizzes.</p>
                    </div>
                    <div class="col-md-4 text-md-end mt-3 mt-md-0">
                        <a href="/catalog" class="btn btn-brand btn-sm px-3 py-2"><i class="fa-solid fa-plus me-1"></i> Enroll in New Course</a>
                    </div>
                </div>
            </div>

            <!-- Stats Ticker -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white d-flex flex-row align-items-center gap-3">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-book-open fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${totalEnrolled}</h4>
                            <span class="text-muted small">Enrolled Courses</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white d-flex flex-row align-items-center gap-3">
                        <div class="bg-success bg-opacity-10 text-success rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-circle-check fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${completedCourses}</h4>
                            <span class="text-muted small">Completed Modules</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-3 bg-white d-flex flex-row align-items-center gap-3">
                        <div class="bg-warning bg-opacity-10 text-warning rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                            <i class="fa-solid fa-award fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">${avgScore}%</h4>
                            <span class="text-muted small">Avg. Quiz Score</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Active Enrolled Courses -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-play me-2 text-primary"></i> In-Progress Curricula</h5>
                    <a href="/student/courses" class="btn btn-sm btn-outline-primary">View All</a>
                </div>

                <c:choose>
                    <c:when test="${not empty enrollments}">
                        <div class="row g-4">
                            <c:forEach var="enr" items="${enrollments}">
                                <div class="col-md-6">
                                    <div class="card h-100 border rounded-4 overflow-hidden shadow-none hover-shadow transition-all">
                                        <div class="position-relative">
                                            <img src="${enr.course.thumbnailUrl}" class="card-img-top object-fit-cover" style="height: 140px;" alt="${enr.course.title}">
                                            <span class="position-absolute top-0 end-0 m-2 badge bg-dark bg-opacity-75 text-white">${enr.course.level}</span>
                                        </div>
                                        <div class="card-body p-3 d-flex flex-column">
                                            <h6 class="fw-bold text-dark mb-2">${enr.course.title}</h6>
                                            <div class="mb-3">
                                                <div class="d-flex justify-content-between align-items-center text-muted small mb-1">
                                                    <span>Progress</span>
                                                    <span class="fw-bold text-primary">${enr.progressPct}%</span>
                                                </div>
                                                <div class="progress" style="height: 6px;">
                                                    <div class="progress-bar bg-primary" role="progressbar" style="width: ${enr.progressPct}%;"></div>
                                                </div>
                                            </div>
                                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                                <span class="text-muted fs-8"><i class="fa-regular fa-folder-open me-1"></i> ${enr.course.totalLessons} Lessons</span>
                                                <a href="/student/courses/${enr.course.id}/learn" class="btn btn-sm btn-primary px-3 rounded-pill fw-semibold">
                                                    Resume <i class="fa-solid fa-arrow-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-4 text-center text-muted bg-light rounded-4">
                            <i class="fa-solid fa-graduation-cap fs-2 text-secondary mb-2"></i>
                            <p class="mb-2">You haven't enrolled in any courses yet.</p>
                            <a href="/catalog" class="btn btn-sm btn-primary">Browse Course Catalog</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Upcoming Live & Recent Quiz Submissions -->
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100">
                        <h5 class="fw-bold mb-3 text-dark"><i class="fa-solid fa-video me-2 text-danger"></i> Upcoming Live Classrooms</h5>
                        <c:choose>
                            <c:when test="${not empty liveClasses}">
                                <div class="d-flex flex-column gap-3">
                                    <c:forEach var="lc" items="${liveClasses}">
                                        <div class="p-3 rounded-3 bg-light border d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-danger bg-opacity-10 text-danger small mb-1">${lc.status}</span>
                                                <h6 class="fw-bold mb-1 text-dark">${lc.title}</h6>
                                                <span class="text-muted fs-8"><i class="fa-regular fa-clock me-1"></i> ${lc.durationMinutes} mins &bull; ${lc.course.title}</span>
                                            </div>
                                            <a href="/student/live/${lc.id}/join" class="btn btn-sm btn-outline-danger px-3 rounded-pill fw-bold">
                                                <i class="fa-solid fa-door-open me-1"></i> Join
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted small">No upcoming live sessions scheduled today.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100">
                        <h5 class="fw-bold mb-3 text-dark"><i class="fa-solid fa-award me-2 text-warning"></i> Recent Quiz Results</h5>
                        <c:choose>
                            <c:when test="${not empty submissions}">
                                <div class="d-flex flex-column gap-2">
                                    <c:forEach var="sub" items="${submissions}" begin="0" end="3">
                                        <div class="p-3 rounded-3 bg-light border d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="fw-bold mb-1 text-dark">${sub.quiz.title}</h6>
                                                <span class="text-muted fs-8">${sub.correctAnswers}/${sub.totalQuestions} Correct &bull; ${sub.submittedAt}</span>
                                            </div>
                                            <div class="text-end">
                                                <span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'} px-3 py-1 rounded-pill fw-bold">${sub.scorePct}% (${sub.status})</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted small">No quiz submissions recorded yet.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
