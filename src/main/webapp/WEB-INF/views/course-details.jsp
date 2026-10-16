<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="${course.title} - Course Overview" />
</jsp:include>

<div class="py-5 bg-dark text-white border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #0b0f19, #1e1b4b);">
    <div class="container py-3">
        <div class="row align-items-center g-4">
            <div class="col-lg-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb text-secondary small mb-2">
                        <li class="breadcrumb-item"><a href="/" class="text-secondary text-decoration-none">Home</a></li>
                        <li class="breadcrumb-item"><a href="/catalog" class="text-secondary text-decoration-none">Courses</a></li>
                        <li class="breadcrumb-item active text-white" aria-current="page">${course.title}</li>
                    </ol>
                </nav>
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="badge bg-primary px-3 py-1 rounded-pill">${course.level}</span>
                    <span class="badge bg-secondary bg-opacity-50 text-white px-3 py-1 rounded-pill"><i class="fa-regular fa-clock me-1"></i> ${course.duration}</span>
                    <c:if test="${course.upcoming}">
                        <span class="badge bg-warning text-dark px-3 py-1 rounded-pill fw-bold shadow-sm">
                            <i class="fa-solid fa-sparkles me-1"></i> UPCOMING BATCH
                        </span>
                    </c:if>
                </div>
                <h1 class="display-6 fw-bold mb-3">${course.title}</h1>
                <p class="lead text-secondary mb-4 leading-relaxed">${course.description}</p>
                <div class="d-flex flex-wrap align-items-center gap-4 text-secondary small">
                    <div><i class="fa-solid fa-user-tie text-primary me-1"></i> Instructor: <strong class="text-white">${course.instructorName != null ? course.instructorName : course.instructorEmail}</strong></div>
                    <div><i class="fa-regular fa-folder-open text-primary me-1"></i> <strong class="text-white">${course.totalLessons} Lessons</strong></div>
                    <div><i class="fa-solid fa-layer-group text-primary me-1"></i> Category: <strong class="text-white">${course.category != null ? course.category.name : 'Engineering'}</strong></div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden bg-white text-dark">
                    <img src="${course.thumbnailUrl}" class="card-img-top object-fit-cover" style="height: 200px;" alt="${course.title}">
                    <div class="card-body p-4">
                        <c:choose>
                            <c:when test="${course.upcoming}">
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <span class="fs-4 fw-extrabold text-warning">UPCOMING BATCH</span>
                                    <span class="badge bg-warning bg-opacity-25 text-warning-emphasis fw-bold px-3 py-1"><i class="fa-regular fa-clock me-1"></i> Opening Soon</span>
                                </div>
                                <div class="alert alert-warning py-3 px-3 rounded-3 small text-dark mb-3 border-0 bg-warning bg-opacity-10">
                                    <div class="fw-bold mb-1"><i class="fa-solid fa-bullhorn text-warning me-1"></i> Admissions Announced</div>
                                    Direct enrollment for this 16-week flagship masterclass is opening soon. Review the structured modular syllabus below.
                                </div>
                                <button type="button" class="btn btn-secondary w-100 py-3 fw-bold fs-6 mb-2" disabled>
                                    <i class="fa-solid fa-lock me-2"></i> Enrollment Opening Soon
                                </button>
                                <a href="/catalog" class="btn btn-outline-secondary w-100 py-2 small fw-semibold">
                                    <i class="fa-solid fa-arrow-left me-1"></i> Explore Active Courses
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <span class="fs-4 fw-extrabold text-success">${course.price != null && course.price.equalsIgnoreCase('free') ? 'FREE ACCESS' : course.price}</span>
                                    <span class="badge bg-success bg-opacity-10 text-success fw-bold px-3 py-1">Open Enrollment</span>
                                </div>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.email}">
                                        <form action="/student/enroll/${course.id}" method="POST">
                                            <button type="submit" class="btn btn-brand w-100 py-3 fw-bold fs-6 mb-2">
                                                <i class="fa-solid fa-play me-2"></i> Enroll & Start Learning
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/login" class="btn btn-brand w-100 py-3 fw-bold fs-6 mb-2">
                                            <i class="fa-solid fa-arrow-right-to-bracket me-2"></i> Sign In to Enroll
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <p class="text-center text-muted fs-8 mb-0 mt-3"><i class="fa-solid fa-shield-check text-success me-1"></i> Verified Academic Syllabus & Timed Assessments</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-8">
            <h4 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-list-ol me-2 text-primary"></i> Course Curriculum & Syllabi</h4>

            <c:choose>
                <c:when test="${not empty course.sections}">
                    <div class="accordion shadow-sm rounded-4 overflow-hidden border-0" id="syllabusAccordion">
                        <c:forEach var="sec" items="${course.sections}" varStatus="status">
                            <div class="accordion-item border-0 border-bottom">
                                <h2 class="accordion-header" id="heading${sec.id}">
                                    <button class="accordion-button ${status.first ? '' : 'collapsed'} fw-bold bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${sec.id}">
                                        <span class="badge bg-primary rounded-pill me-3">${status.index + 1}</span>
                                        ${sec.title}
                                        <span class="ms-auto me-3 badge bg-secondary bg-opacity-10 text-secondary fs-8">${sec.lessons.size()} Lessons</span>
                                    </button>
                                </h2>
                                <div id="collapse${sec.id}" class="accordion-collapse collapse ${status.first ? 'show' : ''}" data-bs-parent="#syllabusAccordion">
                                    <div class="accordion-body p-0">
                                        <ul class="list-group list-group-flush">
                                            <c:forEach var="les" items="${sec.lessons}">
                                                <li class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <i class="fa-regular fa-circle-play text-primary"></i>
                                                        <div>
                                                            <div class="fw-semibold text-dark">${les.title}</div>
                                                            <div class="text-muted fs-8">${les.durationMinutes} mins &bull; ${les.materialName != null ? les.materialName : 'Lecture Stream'}</div>
                                                        </div>
                                                    </div>
                                                    <c:choose>
                                                        <c:when test="${course.upcoming}">
                                                            <span class="badge bg-light text-muted border"><i class="fa-solid fa-calendar-clock me-1"></i> Upcoming</span>
                                                        </c:when>
                                                        <c:when test="${not empty sessionScope.email}">
                                                            <a href="/student/courses/${course.id}/learn?lessonId=${les.id}" class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                                                <i class="fa-solid fa-play me-1"></i> Stream
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-light text-muted border"><i class="fa-solid fa-lock me-1"></i> Locked</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="p-4 bg-white rounded-4 shadow-sm text-center text-muted">
                        <i class="fa-solid fa-hourglass-start fs-2 mb-2 text-warning"></i>
                        <p class="mb-0">Course syllabus is being curated by the faculty instructor.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
                <h6 class="fw-bold mb-3"><i class="fa-solid fa-circle-info me-2 text-primary"></i> Course Highlights</h6>
                <ul class="list-unstyled small text-muted d-flex flex-column gap-3 mb-0">
                    <li class="d-flex align-items-center gap-2"><i class="fa-solid fa-video text-primary"></i> HD Streamed Video Lectures</li>
                    <li class="d-flex align-items-center gap-2"><i class="fa-solid fa-file-pdf text-danger"></i> Downloadable Notes & Reference PDFs</li>
                    <li class="d-flex align-items-center gap-2"><i class="fa-solid fa-clock text-warning"></i> Self-Paced Learning Tracker</li>
                    <li class="d-flex align-items-center gap-2"><i class="fa-solid fa-spell-check text-success"></i> Automated Module Quizzes</li>
                    <li class="d-flex align-items-center gap-2"><i class="fa-solid fa-headset text-info"></i> Direct WebRTC Live Classes</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
