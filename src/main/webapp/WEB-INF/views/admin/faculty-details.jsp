<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Faculty Details - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <c:if test="${not empty param.msg}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check fs-4 text-success"></i>
            <div><strong>Success!</strong> ${param.msg}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="faculty" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <!-- Header Summary Card -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4" style="background: linear-gradient(135deg, #1e1b4b, #312e81); color: white;">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-circle text-white d-flex align-items-center justify-content-center fw-bold fs-2 shadow" style="width: 70px; height: 70px; background-color: #8b5cf6;">
                            <i class="fa-solid fa-chalkboard-user"></i>
                        </div>
                        <div>
                            <h3 class="fw-bold mb-0 text-white">${faculty.name}</h3>
                            <p class="text-white-50 mb-0">${faculty.email} &bull; ID: <strong>${not empty faculty.registrationNumber ? faculty.registrationNumber : 'FAC-'}${empty faculty.registrationNumber ? faculty.id : ''}</strong></p>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="/admin/faculty" class="btn btn-outline-light rounded-pill px-3 py-1.5 fw-semibold">
                            <i class="fa-solid fa-arrow-left me-1"></i> Back to Faculty
                        </a>
                        <button class="btn btn-light rounded-pill px-3 py-1.5 fw-bold text-dark" data-bs-toggle="modal" data-bs-target="#editFacultyModal">
                            <i class="fa-solid fa-pen-to-square me-1"></i> Edit Faculty
                        </button>
                    </div>
                </div>
            </div>

            <!-- Faculty Profile Information Card -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-briefcase me-2 text-primary"></i> Professional & Personal Profile</h5>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Designation</div>
                        <div class="fw-bold text-dark">${not empty faculty.designation ? faculty.designation : 'Professor'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Department</div>
                        <div class="fw-bold text-dark">${not empty faculty.department ? faculty.department : 'Computer Science & Engineering'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Experience</div>
                        <div class="fw-bold text-dark">${not empty faculty.experience ? faculty.experience : 'N/A'}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="small text-muted fw-bold text-uppercase">Academic Qualification</div>
                        <div class="fw-bold text-dark">${not empty faculty.qualification ? faculty.qualification : 'N/A'}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="small text-muted fw-bold text-uppercase">Specialization / Research</div>
                        <div class="fw-bold text-dark">${not empty faculty.specialization ? faculty.specialization : 'N/A'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Mobile</div>
                        <div class="fw-bold text-dark">${not empty faculty.mobile ? faculty.mobile : 'N/A'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Joining Date</div>
                        <div class="fw-bold text-dark">${not empty faculty.joiningDate ? faculty.joiningDate : 'N/A'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Registration Date</div>
                        <div class="fw-bold text-dark">${faculty.createdAt}</div>
                    </div>
                </div>
            </div>

            <!-- Assigned Courses Studio -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-layer-group me-2 text-primary"></i> Courses Assigned & Created (${courses.size()})</h5>
                <c:choose>
                    <c:when test="${not empty courses}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle border mb-0">
                                <thead class="table-light">
                                    <tr class="fs-8 text-uppercase text-muted">
                                        <th>Course Title</th>
                                        <th>Category</th>
                                        <th>Level & Duration</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${courses}">
                                        <tr>
                                            <td class="fw-bold text-dark">${c.title}</td>
                                            <td><span class="badge bg-primary bg-opacity-10 text-primary">${c.category != null ? c.category.name : 'Computer Science'}</span></td>
                                            <td>${c.level} &bull; <span class="small text-muted">${c.duration}</span></td>
                                            <td>
                                                <span class="badge ${c.published ? 'bg-success' : 'bg-warning'} px-2.5 py-1 rounded-pill">
                                                    ${c.published ? 'Published' : 'Draft'}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-3 bg-light rounded-3 text-muted text-center">No courses assigned to this faculty yet.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Live Sessions & Quizzes -->
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="card shadow-sm border-0 rounded-4 p-4 h-100">
                        <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-video me-2 text-danger"></i> Live Classrooms (${liveClasses.size()})</h6>
                        <c:forEach var="lc" items="${liveClasses}">
                            <div class="p-2 border rounded-2 mb-2 bg-light">
                                <div class="fw-bold small text-dark">${lc.title}</div>
                                <span class="badge bg-danger bg-opacity-10 text-danger fs-8">${lc.status}</span>
                                <span class="small text-muted ms-2">${lc.scheduledAt}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card shadow-sm border-0 rounded-4 p-4 h-100">
                        <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-list-check me-2 text-warning"></i> Quizzes Created (${quizzes.size()})</h6>
                        <c:forEach var="qz" items="${quizzes}">
                            <div class="p-2 border rounded-2 mb-2 bg-light">
                                <div class="fw-bold small text-dark">${qz.title}</div>
                                <span class="small text-muted">Passing Score: ${qz.passingScorePct}% &bull; Time: ${qz.timeLimitMinutes} min</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- MODAL: Edit Faculty Details -->
<div class="modal fade" id="editFacultyModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-dark text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-pen me-2"></i> Edit Faculty: ${faculty.name}</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/faculty/${faculty.id}/update" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Full Name *</label>
                            <input type="text" name="name" class="form-control rounded-3" value="${faculty.name}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Mobile Number</label>
                            <input type="text" name="mobile" class="form-control rounded-3" value="${faculty.mobile}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="${faculty.department}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Designation</label>
                            <select name="designation" class="form-select rounded-3">
                                <option value="Professor" ${faculty.designation == 'Professor' ? 'selected' : ''}>Professor</option>
                                <option value="Associate Professor" ${faculty.designation == 'Associate Professor' ? 'selected' : ''}>Associate Professor</option>
                                <option value="Assistant Professor" ${faculty.designation == 'Assistant Professor' ? 'selected' : ''}>Assistant Professor</option>
                                <option value="Lecturer" ${faculty.designation == 'Lecturer' ? 'selected' : ''}>Lecturer</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Qualification</label>
                            <input type="text" name="qualification" class="form-control rounded-3" value="${faculty.qualification}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Specialization</label>
                            <input type="text" name="specialization" class="form-control rounded-3" value="${faculty.specialization}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Experience</label>
                            <input type="text" name="experience" class="form-control rounded-3" value="${faculty.experience}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Joining Date</label>
                            <input type="date" name="joiningDate" class="form-control rounded-3" value="${faculty.joiningDate}">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Bio / Notes</label>
                            <textarea name="bio" class="form-control rounded-3" rows="2">${faculty.bio}</textarea>
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

<jsp:include page="../footer.jsp" />
