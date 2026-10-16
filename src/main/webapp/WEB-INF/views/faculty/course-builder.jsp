<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Syllabus Studio - ${course.title}" />
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
            <!-- Course Header Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <a href="/faculty/courses" class="btn btn-outline-secondary btn-sm rounded-circle"><i class="fa-solid fa-arrow-left"></i></a>
                        <div>
                            <span class="badge bg-primary bg-opacity-10 text-primary small mb-1">${course.level} &bull; ${course.category != null ? course.category.name : 'Engineering'}</span>
                            <h4 class="fw-bold mb-0 text-dark">${course.title}</h4>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-primary btn-sm rounded-pill px-3 fw-bold" data-bs-toggle="modal" data-bs-target="#addSectionModal">
                            <i class="fa-solid fa-plus me-1"></i> Add Section
                        </button>
                        <a href="/student/courses/${course.id}/learn" target="_blank" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                            <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Preview Player
                        </a>
                    </div>
                </div>
            </div>

            <!-- Sections & Lessons Tree -->
            <div class="d-flex flex-column gap-4">
                <c:choose>
                    <c:when test="${not empty course.sections}">
                        <c:forEach var="sec" items="${course.sections}" varStatus="sStat">
                            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                                <div class="card-header bg-light p-3 d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge bg-dark rounded-pill">Section ${sStat.index + 1}</span>
                                        <h6 class="fw-bold mb-0 text-dark">${sec.title}</h6>
                                    </div>
                                    <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#addLessonModal_${sec.id}">
                                        <i class="fa-solid fa-plus me-1"></i> Add Lesson
                                    </button>
                                </div>

                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${not empty sec.lessons}">
                                            <ul class="list-group list-group-flush">
                                                <c:forEach var="les" items="${sec.lessons}">
                                                    <li class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fa-solid fa-circle-play text-primary fs-5"></i>
                                                            <div>
                                                                <h6 class="fw-bold mb-0 text-dark">${les.title}</h6>
                                                                <div class="text-muted fs-8">
                                                                    <span><i class="fa-regular fa-clock me-1"></i> ${les.durationMinutes} mins</span>
                                                                    <c:if test="${not empty les.materialUrl}">
                                                                        &bull; <span class="text-danger"><i class="fa-solid fa-file-pdf me-1"></i> ${les.materialName != null ? les.materialName : 'PDF Asset Attached'}</span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <span class="badge bg-light text-muted border">Lesson ${les.orderNum}</span>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="p-3 text-center text-muted small">
                                                No lessons in this section yet. Click "Add Lesson" above to add video and PDF assets.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Add Lesson Modal for this Section -->
                            <div class="modal fade" id="addLessonModal_${sec.id}" tabindex="-1">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content rounded-4 border-0">
                                        <div class="modal-header bg-dark text-white p-3">
                                            <h5 class="modal-title fw-bold">Add Lesson to: ${sec.title}</h5>
                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                        </div>
                                        <form action="/faculty/sections/${sec.id}/lessons/add" method="POST">
                                            <input type="hidden" name="courseId" value="${course.id}">
                                            <div class="modal-body p-4">
                                                <div class="row g-3">
                                                    <div class="col-md-9">
                                                        <label class="form-label fw-semibold text-dark small">Lesson Title</label>
                                                        <input type="text" name="title" class="form-control" placeholder="e.g. 1.1 Microservices Architecture Fundamentals" required>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="form-label fw-semibold text-dark small">Order #</label>
                                                        <input type="number" name="orderNum" class="form-control" value="${sec.lessons.size() + 1}" required>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <label class="form-label fw-semibold text-dark small">Streamed Video URL (YouTube Embed / MP4 Cloud Stream)</label>
                                                        <input type="url" name="videoUrl" class="form-control" placeholder="https://www.youtube.com/embed/..." value="https://www.youtube.com/embed/dQw4w9WgXcQ">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label fw-semibold text-dark small">Duration (Minutes)</label>
                                                        <input type="number" name="durationMinutes" class="form-control" value="20" required>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-semibold text-dark small">PDF Material URL (S3 / Cloud Storage / Presigned URL)</label>
                                                        <input type="url" name="materialUrl" class="form-control" placeholder="https://..." value="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-semibold text-dark small">PDF Asset Name</label>
                                                        <input type="text" name="materialName" class="form-control" placeholder="e.g. Architecture-Cheatsheet.pdf" value="Lecture-Notes.pdf">
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label fw-semibold text-dark small">Lecture Notes & Markdown Content</label>
                                                        <textarea name="contentText" class="form-control" rows="4" placeholder="Detailed syllabus summary and study guidelines..."></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer bg-light p-3">
                                                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Save Lesson</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-white rounded-4 shadow-sm text-muted">
                            <i class="fa-solid fa-list-ol fs-1 mb-3 text-secondary"></i>
                            <h5 class="fw-bold">No syllabus sections created yet</h5>
                            <p class="small mb-3">Add structured modules and attach video lessons and PDF notes.</p>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addSectionModal">
                                Add First Section
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Add Section Modal -->
<div class="modal fade" id="addSectionModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Add New Course Section</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/faculty/courses/${course.id}/sections/add" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Section / Module Title</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g. Module 1: Cloud Architecture Foundations" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Section Order Number</label>
                        <input type="number" name="orderNum" class="form-control" value="${course.sections.size() + 1}" required>
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Create Section</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
