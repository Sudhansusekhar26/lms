<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Course Catalog - Cloud LMS Academic Portal" />
</jsp:include>

<div class="py-5 border-bottom" style="background: linear-gradient(180deg, #dbeafe 0%, #eaf2fb 60%, #f0f5fa 100%);">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <span class="badge bg-white text-primary border border-primary fw-bold px-3 py-1 mb-2 shadow-sm">CURRICULUM REPOSITORY</span>
                <h1 class="fw-bold mb-2" style="color: #0f2b5c;">Certified Course Catalog</h1>
                <p class="text-muted mb-0">Browse certified academic programs, view syllabi, study lecture notes, and take auto-graded quizzes.</p>
            </div>
            <div class="col-md-4 mt-3 mt-md-0">
                <form action="/catalog" method="GET">
                    <div class="card border-0 shadow-sm rounded-pill p-1 bg-white">
                        <div class="input-group">
                            <input type="text" name="search" value="${searchTerm}" class="form-control border-0 px-3 shadow-none rounded-pill" placeholder="Search courses...">
                            <button class="btn btn-portal-primary rounded-pill px-3" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="container py-5">
    <div class="row g-4">
        <!-- Sidebar Filters -->
        <div class="col-lg-3">
            <div class="card portal-card p-3 mb-4">
                <h6 class="fw-bold mb-3" style="color: #0f2b5c;"><i class="fa-solid fa-filter me-2 text-primary"></i> Academic Streams</h6>
                <div class="list-group list-group-flush small">
                    <a href="/catalog" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 px-2 rounded-2 ${selectedCategoryId == null ? 'active bg-primary text-white' : ''}" style="${selectedCategoryId == null ? 'background-color: #1d70b8 !important;' : ''}">
                        <span>All Streams</span>
                    </a>
                    <c:forEach var="cat" items="${categories}">
                        <a href="/catalog?categoryId=${cat.id}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 px-2 rounded-2 ${selectedCategoryId == cat.id ? 'active bg-primary text-white' : ''}" style="${selectedCategoryId == cat.id ? 'background-color: #1d70b8 !important;' : ''}">
                            <span><i class="fa-solid ${cat.icon} me-2 text-secondary"></i> ${cat.name}</span>
                        </a>
                    </c:forEach>
                </div>
            </div>

            <div class="card portal-card p-4 text-white" style="background: linear-gradient(135deg, #0f2b5c, #1d70b8);">
                <h6 class="fw-bold mb-2"><i class="fa-solid fa-graduation-cap me-2 text-warning"></i> Faculty Onboarding</h6>
                <p class="small text-white text-opacity-75 mb-3">Join our distinguished faculty to build courses and publish live webinars.</p>
                <a href="/register" class="btn btn-sm btn-light text-primary fw-bold w-100 rounded-pill">Apply with Faculty ID</a>
            </div>
        </div>

        <!-- Course List -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0" style="color: #0f2b5c;">Showing ${courses.size()} Available Courses</h5>
                <c:if test="${not empty searchTerm}">
                    <span class="badge bg-white text-dark border shadow-sm">Keyword: "${searchTerm}" <a href="/catalog" class="text-danger ms-1"><i class="fa-solid fa-xmark"></i></a></span>
                </c:if>
            </div>

            <div class="row g-4">
                <c:forEach var="course" items="${courses}">
                    <div class="col-md-6">
                        <div class="card h-100 portal-card overflow-hidden">
                            <div class="position-relative">
                                <img src="${course.thumbnailUrl}" class="card-img-top object-fit-cover" style="height: 180px;" alt="${course.title}">
                                <div class="position-absolute top-0 end-0 m-3 d-flex flex-column align-items-end gap-1">
                                    <span class="badge bg-dark bg-opacity-75 text-white px-3 py-1 rounded-pill small">
                                        ${course.level}
                                    </span>
                                    <c:if test="${course.upcoming}">
                                        <span class="badge bg-warning text-dark fw-bold px-3 py-1 rounded-pill shadow-sm">
                                            <i class="fa-solid fa-sparkles me-1"></i> UPCOMING
                                        </span>
                                    </c:if>
                                </div>
                                <c:if test="${not empty course.category}">
                                    <span class="position-absolute bottom-0 start-0 m-3 badge px-3 py-1 rounded-pill text-white" style="background-color: #1d70b8;">
                                        <i class="fa-solid ${course.category.icon} me-1"></i> ${course.category.name}
                                    </span>
                                </c:if>
                            </div>
                            <div class="card-body p-4 d-flex flex-column">
                                <div class="d-flex align-items-center gap-2 mb-2 text-muted small">
                                    <i class="fa-solid fa-user-tie text-primary"></i>
                                    <span class="fw-semibold">${course.instructorName != null ? course.instructorName : course.instructorEmail}</span>
                                </div>
                                <h5 class="card-title fw-bold mb-2" style="color: #0f2b5c;">
                                    ${course.title}
                                    <c:if test="${course.upcoming}">
                                        <span class="badge bg-warning bg-opacity-25 text-warning-emphasis fs-8 ms-1">Opening Soon</span>
                                    </c:if>
                                </h5>
                                <p class="card-text text-muted small mb-3 flex-grow-1 line-clamp-2">
                                    ${course.description}
                                </p>
                                <div class="d-flex justify-content-between align-items-center mb-3 small text-muted">
                                    <span><i class="fa-regular fa-clock me-1 text-primary"></i> <strong>${course.duration}</strong></span>
                                    <c:choose>
                                        <c:when test="${course.upcoming}">
                                            <span class="badge bg-warning bg-opacity-25 text-warning-emphasis fw-bold px-2 py-1"><i class="fa-regular fa-calendar-check me-1"></i> Upcoming</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success bg-opacity-10 text-success fw-bold px-2 py-1">${course.price}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                    <div class="text-muted small">
                                        <i class="fa-regular fa-folder-open me-1 text-primary"></i>
                                        <span>${course.totalLessons} Lessons</span>
                                    </div>
                                    <c:choose>
                                        <c:when test="${course.upcoming}">
                                            <a href="/courses/${course.id}" class="btn btn-sm btn-warning fw-bold px-3 text-dark shadow-sm">
                                                <i class="fa-solid fa-bullhorn me-1"></i> Upcoming Syllabus <i class="fa-solid fa-chevron-right ms-1"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/courses/${course.id}" class="btn btn-sm btn-portal-primary px-3 fw-bold">
                                                View Syllabus <i class="fa-solid fa-chevron-right ms-1"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
