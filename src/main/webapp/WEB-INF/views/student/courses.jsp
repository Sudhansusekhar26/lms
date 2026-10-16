<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="My Courses - Student Portal" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="smenu.jsp">
                <jsp:param name="active" value="courses" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h4 class="fw-bold text-dark mb-4"><i class="fa-solid fa-book-bookmark me-2 text-primary"></i> My Enrolled Courses</h4>

                <c:choose>
                    <c:when test="${not empty enrollments}">
                        <div class="row g-4">
                            <c:forEach var="enr" items="${enrollments}">
                                <div class="col-md-6">
                                    <div class="card h-100 border rounded-4 overflow-hidden shadow-none">
                                        <div class="position-relative">
                                            <img src="${enr.course.thumbnailUrl}" class="card-img-top object-fit-cover" style="height: 160px;" alt="${enr.course.title}">
                                            <span class="position-absolute top-0 end-0 m-2 badge bg-dark bg-opacity-75 text-white">${enr.course.level}</span>
                                        </div>
                                        <div class="card-body p-4 d-flex flex-column">
                                            <span class="badge bg-primary bg-opacity-10 text-primary small align-self-start mb-2">${enr.course.category.name}</span>
                                            <h5 class="fw-bold text-dark mb-2">${enr.course.title}</h5>
                                            <p class="text-muted small mb-3 flex-grow-1 line-clamp-2">${enr.course.description}</p>
                                            
                                            <div class="mb-3">
                                                <div class="d-flex justify-content-between align-items-center small text-muted mb-1">
                                                    <span>Course Completion</span>
                                                    <span class="fw-bold text-primary">${enr.progressPct}%</span>
                                                </div>
                                                <div class="progress" style="height: 6px;">
                                                    <div class="progress-bar ${enr.progressPct == 100 ? 'bg-success' : 'bg-primary'}" role="progressbar" style="width: ${enr.progressPct}%;"></div>
                                                </div>
                                            </div>

                                            <a href="/student/courses/${enr.course.id}/learn" class="btn btn-primary w-100 rounded-pill fw-bold">
                                                <i class="fa-solid fa-circle-play me-2"></i> Open Course Player
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-light rounded-4">
                            <i class="fa-solid fa-book-open-reader fs-1 text-muted mb-3"></i>
                            <h5 class="fw-bold">No active enrollments yet</h5>
                            <p class="text-muted small mb-3">Explore our public course catalog to find topics aligned with your career goals.</p>
                            <a href="/catalog" class="btn btn-primary">Discover Courses</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Discover More Courses -->
            <c:if test="${not empty discoverCourses}">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                    <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-compass me-2 text-primary"></i> Explore More Available Programs</h5>
                    <div class="row g-3">
                        <c:forEach var="c" items="${discoverCourses}">
                            <div class="col-md-4">
                                <div class="card h-100 border rounded-3 p-3 d-flex flex-column justify-content-between">
                                    <div>
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="badge bg-secondary bg-opacity-10 text-secondary small">${c.level}</span>
                                            <c:if test="${c.upcoming}">
                                                <span class="badge bg-warning text-dark small"><i class="fa-solid fa-clock me-1"></i> Upcoming</span>
                                            </c:if>
                                        </div>
                                        <h6 class="fw-bold text-dark mb-1">${c.title}</h6>
                                        <p class="text-muted fs-8 line-clamp-2">${c.description}</p>
                                    </div>
                                    <c:choose>
                                        <c:when test="${c.upcoming}">
                                            <div class="d-flex flex-column gap-1 mt-2">
                                                <button type="button" class="btn btn-sm btn-secondary w-100 rounded-pill fw-semibold" disabled>
                                                    <i class="fa-solid fa-lock me-1"></i> Opening Soon
                                                </button>
                                                <a href="/courses/${c.id}" class="btn btn-sm btn-outline-warning text-dark w-100 rounded-pill fs-8 fw-bold">
                                                    <i class="fa-solid fa-eye me-1"></i> View Syllabus
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="/student/enroll/${c.id}" method="POST" class="mt-2">
                                                <button type="submit" class="btn btn-sm btn-outline-primary w-100 rounded-pill fw-semibold">
                                                    <i class="fa-solid fa-plus me-1"></i> Enroll Now
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
