<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Live Classrooms - Student Portal" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="smenu.jsp">
                <jsp:param name="active" value="live" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-video me-2 text-danger"></i> Live Virtual Classrooms</h4>
                        <p class="text-muted small mb-0">Join interactive WebRTC live lectures, ask questions in real-time, and collaborate with faculty.</p>
                    </div>
                </div>

                <!-- Active Live Sessions -->
                <c:if test="${not empty liveNow}">
                    <div class="alert alert-danger bg-danger bg-opacity-10 border-danger border-opacity-25 rounded-4 p-4 mb-4">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="spinner-grow spinner-grow-sm text-danger" role="status"></span>
                            <h5 class="fw-bold text-danger mb-0">BROADCASTING NOW</h5>
                        </div>
                        <div class="row g-3">
                            <c:forEach var="lc" items="${liveNow}">
                                <div class="col-md-6">
                                    <div class="card bg-white border-0 shadow-sm rounded-3 p-3">
                                        <span class="badge bg-primary bg-opacity-10 text-primary small mb-1 align-self-start">${lc.course.title}</span>
                                        <h6 class="fw-bold text-dark mb-2">${lc.title}</h6>
                                        <p class="text-muted small mb-3">${lc.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-muted fs-8"><i class="fa-solid fa-chalkboard-user me-1"></i> ${lc.instructorEmail}</span>
                                            <a href="/student/live/${lc.id}/join" class="btn btn-danger btn-sm rounded-pill px-3 fw-bold">
                                                <i class="fa-solid fa-video me-1"></i> Join Room
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Upcoming Scheduled Sessions -->
                <h5 class="fw-bold text-dark mb-3"><i class="fa-regular fa-calendar-days me-2 text-primary"></i> Scheduled Sessions</h5>
                <c:choose>
                    <c:when test="${not empty upcoming}">
                        <div class="row g-4">
                            <c:forEach var="lc" items="${upcoming}">
                                <div class="col-md-6">
                                    <div class="card h-100 border rounded-4 p-4 shadow-none d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="badge bg-primary bg-opacity-10 text-primary small">${lc.course.title}</span>
                                                <span class="badge bg-secondary bg-opacity-10 text-secondary">${lc.durationMinutes} Mins</span>
                                            </div>
                                            <h5 class="fw-bold text-dark mb-2">${lc.title}</h5>
                                            <p class="text-muted small mb-3">${lc.description}</p>
                                        </div>
                                        <div class="pt-3 border-top d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="text-muted fs-8 d-block"><i class="fa-regular fa-clock me-1"></i> Scheduled At:</span>
                                                <strong class="text-dark small">${lc.scheduledAt}</strong>
                                            </div>
                                            <a href="/student/live/${lc.id}/join" class="btn btn-outline-danger btn-sm rounded-pill px-3 fw-bold">
                                                <i class="fa-solid fa-door-open me-1"></i> Enter Room
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-4 text-center bg-light rounded-4 text-muted">
                            <i class="fa-solid fa-calendar-check fs-2 text-secondary mb-2"></i>
                            <p class="mb-0">No upcoming live sessions scheduled for your enrolled courses.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
