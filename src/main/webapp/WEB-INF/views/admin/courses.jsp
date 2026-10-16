<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Course Management - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="courses" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-book-atlas text-primary me-2"></i> Course Management</h4>
                        <p class="text-muted small mb-0">Create, assign faculty, set duration & level, approve/reject, and moderate academic courses.</p>
                    </div>
                    <button type="button" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#createCourseModal">
                        <i class="fa-solid fa-plus-circle me-1"></i> Create Course
                    </button>
                </div>

                <!-- Course Directory Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Course Title & Category</th>
                                <th>Assigned Faculty</th>
                                <th>Duration & Level</th>
                                <th>Enrolled Students</th>
                                <th>Approval / Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${courses}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${c.title}</div>
                                        <span class="badge bg-primary bg-opacity-10 text-primary">${c.category != null ? c.category.name : 'Engineering'}</span>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark fs-7">${c.instructorName}</div>
                                        <div class="small text-muted">${c.instructorEmail}</div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark fs-7">${not empty c.duration ? c.duration : '8 Weeks'}</div>
                                        <span class="badge bg-secondary bg-opacity-10 text-secondary fs-8">${c.level}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-info bg-opacity-10 text-info fs-7 fw-bold px-2.5 py-1">
                                            <i class="fa-solid fa-users me-1"></i> ${enrollmentCounts[c.id] != null ? enrollmentCounts[c.id] : 0} Enrolled
                                        </span>
                                    </td>
                                    <td>
                                        <form action="/admin/courses/${c.id}/toggle-publish" method="POST" class="d-inline">
                                            <button type="submit" class="btn btn-sm ${c.published ? 'btn-success' : 'btn-warning'} rounded-pill px-3 py-0.5 fs-8 fw-bold">
                                                <i class="fa-solid ${c.published ? 'fa-check-circle' : 'fa-clock'} me-1"></i> ${c.published ? 'Approved & Live' : 'Draft / Pending'}
                                            </button>
                                        </form>
                                    </td>
                                    <td class="text-end">
                                        <div class="d-inline-flex gap-1">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-2.5" data-bs-toggle="modal" data-bs-target="#editCourseModal${c.id}" title="Edit Course">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </button>
                                            <form action="/admin/courses/${c.id}/delete" method="POST" class="d-inline" onsubmit="return confirm('Permanently delete course: ${c.title}?');">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2.5" title="Delete Course">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>

                                        <!-- Edit Course Modal -->
                                        <div class="modal fade text-start" id="editCourseModal${c.id}" tabindex="-1">
                                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                                <div class="modal-content border-0 shadow-lg rounded-4">
                                                    <div class="modal-header bg-primary text-white border-0 rounded-top-4 p-3 px-4">
                                                        <h5 class="modal-title fw-bold"><i class="fa-solid fa-pen-to-square me-2"></i> Edit Course: ${c.title}</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="/admin/courses/${c.id}/edit" method="POST">
                                                        <div class="modal-body p-4">
                                                            <div class="row g-3">
                                                                <div class="col-md-12">
                                                                    <label class="form-label small fw-bold">Course Title *</label>
                                                                    <input type="text" name="title" class="form-control rounded-3" value="${c.title}" required>
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <label class="form-label small fw-bold">Description</label>
                                                                    <textarea name="description" class="form-control rounded-3" rows="3">${c.description}</textarea>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-bold">Assign Faculty Instructor *</label>
                                                                    <select name="facultyEmail" class="form-select rounded-3" required>
                                                                        <c:forEach var="f" items="${facultyList}">
                                                                            <option value="${f.email}" ${f.email == c.instructorEmail ? 'selected' : ''}>${f.name} (${f.email})</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-bold">Academic Category</label>
                                                                    <select name="categoryId" class="form-select rounded-3">
                                                                        <c:forEach var="cat" items="${categories}">
                                                                            <option value="${cat.id}" ${c.category != null && c.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label class="form-label small fw-bold">Duration (e.g. 8 Weeks)</label>
                                                                    <input type="text" name="duration" class="form-control rounded-3" value="${c.duration}">
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label class="form-label small fw-bold">Course Level</label>
                                                                    <select name="level" class="form-select rounded-3">
                                                                        <option value="Beginner" ${c.level == 'Beginner' ? 'selected' : ''}>Beginner</option>
                                                                        <option value="Intermediate" ${c.level == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                                                                        <option value="Advanced" ${c.level == 'Advanced' ? 'selected' : ''}>Advanced</option>
                                                                    </select>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <label class="form-label small fw-bold">Price / Access</label>
                                                                    <input type="text" name="price" class="form-control rounded-3" value="${c.price}">
                                                                </div>
                                                                <div class="col-md-12">
                                                                    <label class="form-label small fw-bold">Thumbnail Image URL</label>
                                                                    <input type="text" name="thumbnailUrl" class="form-control rounded-3" value="${c.thumbnailUrl}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                                                            <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">
                                                                <i class="fa-solid fa-floppy-disk me-1"></i> Save Changes
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL: Create Course -->
<div class="modal fade" id="createCourseModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-primary text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-plus-circle me-2"></i> Create New Academic Course</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/courses/create" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Course Title *</label>
                            <input type="text" name="title" class="form-control rounded-3" placeholder="e.g. Cloud Native Microservices" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Course Description *</label>
                            <textarea name="description" class="form-control rounded-3" rows="3" placeholder="Detailed syllabus and curriculum summary..." required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Assign Faculty Instructor *</label>
                            <select name="facultyEmail" class="form-select rounded-3" required>
                                <c:forEach var="f" items="${facultyList}">
                                    <option value="${f.email}">${f.name} (${f.email})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Category *</label>
                            <select name="categoryId" class="form-select rounded-3" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Duration</label>
                            <input type="text" name="duration" class="form-control rounded-3" value="8 Weeks">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Level</label>
                            <select name="level" class="form-select rounded-3">
                                <option value="Beginner">Beginner</option>
                                <option value="Intermediate" selected>Intermediate</option>
                                <option value="Advanced">Advanced</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Tuition / Access</label>
                            <input type="text" name="price" class="form-control rounded-3" value="Free">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Thumbnail Image URL</label>
                            <input type="text" name="thumbnailUrl" class="form-control rounded-3" placeholder="https://images.unsplash.com/...">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">
                        <i class="fa-solid fa-check me-1"></i> Create & Publish Course
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
