<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Course Studio - Faculty Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="courses" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-layer-group me-2 text-primary"></i> Course Authoring Studio</h4>
                        <p class="text-muted small mb-0">Build, structure syllabi, and publish curricula for enrolled students.</p>
                    </div>
                    <a href="/faculty/courses/create" class="btn btn-brand btn-sm px-3 py-2 fw-bold">
                        <i class="fa-solid fa-plus me-1"></i> Create New Course
                    </a>
                </div>

                <c:choose>
                    <c:when test="${not empty courses}">
                        <div class="row g-4">
                            <c:forEach var="c" items="${courses}">
                                <div class="col-md-6">
                                    <div class="card h-100 border rounded-4 overflow-hidden shadow-none d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="position-relative">
                                                <img src="${c.thumbnailUrl}" class="card-img-top object-fit-cover" style="height: 160px;" alt="${c.title}">
                                                <span class="position-absolute top-0 end-0 m-2 badge bg-dark bg-opacity-75 text-white">${c.level}</span>
                                                <span class="position-absolute bottom-0 start-0 m-2 badge ${c.published ? 'bg-success' : 'bg-secondary'}">
                                                    ${c.published ? 'Published' : 'Draft'}
                                                </span>
                                            </div>
                                            <div class="card-body p-3">
                                                <span class="badge bg-primary bg-opacity-10 text-primary small mb-1">${c.category != null ? c.category.name : 'Computer Science'}</span>
                                                <h5 class="fw-bold text-dark mb-2">${c.title}</h5>
                                                <p class="text-muted small mb-2 line-clamp-2">${c.description}</p>
                                                <span class="text-muted fs-8"><i class="fa-regular fa-folder-open me-1"></i> ${c.totalLessons} Total Lessons</span>
                                            </div>
                                        </div>

                                        <div class="card-footer bg-light p-3 border-top d-flex justify-content-between align-items-center">
                                            <form action="/faculty/courses/${c.id}/toggle-publish" method="POST">
                                                <button type="submit" class="btn btn-sm ${c.published ? 'btn-outline-secondary' : 'btn-outline-success'}">
                                                    <i class="fa-solid ${c.published ? 'fa-eye-slash' : 'fa-eye'} me-1"></i> ${c.published ? 'Unpublish' : 'Publish'}
                                                </button>
                                            </form>
                                            <a href="/faculty/courses/${c.id}/builder" class="btn btn-sm btn-primary rounded-pill px-3 fw-bold">
                                                <i class="fa-solid fa-pen-ruler me-1"></i> Edit Syllabus
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-light rounded-4 text-muted">
                            <i class="fa-solid fa-book-open fs-1 mb-3 text-secondary"></i>
                            <h5 class="fw-bold">No courses created yet</h5>
                            <p class="small mb-3">Begin by authoring your first curriculum module.</p>
                            <a href="/faculty/courses/create" class="btn btn-primary">Create Course Now</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
