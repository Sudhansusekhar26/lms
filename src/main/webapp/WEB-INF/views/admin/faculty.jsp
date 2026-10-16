<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Faculty Management - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check fs-4 text-success"></i>
            <div><strong>Success!</strong> ${successMsg}</div>
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
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-chalkboard-user text-warning me-2"></i> Faculty Management</h4>
                        <p class="text-muted small mb-0">Manage professors, assign courses, monitor teaching workloads, and govern faculty permissions.</p>
                    </div>
                    <button type="button" class="btn btn-warning text-dark rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#addFacultyModal">
                        <i class="fa-solid fa-user-plus me-1"></i> Add New Faculty
                    </button>
                </div>

                <!-- Search & Filters -->
                <form action="/admin/faculty" method="GET" class="row g-2 mb-4">
                    <div class="col-md-9">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                            <input type="text" name="search" class="form-control border-start-0 ps-0" placeholder="Search by name, email, department, or designation..." value="${search}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary w-100 rounded-3 fw-bold">Search</button>
                    </div>
                </form>

                <!-- Faculty Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Faculty Details</th>
                                <th>Designation & Department</th>
                                <th>Courses / Students</th>
                                <th>Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="f" items="${facultyList}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-purple bg-opacity-10 text-white d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px; background-color: #8b5cf6;">
                                                <i class="fa-solid fa-chalkboard-user"></i>
                                            </div>
                                            <div>
                                                <div class="fw-bold text-dark">${f.name}</div>
                                                <div class="small text-muted">${f.email}</div>
                                                <span class="badge bg-light text-dark border fs-8">ID: ${not empty f.registrationNumber ? f.registrationNumber : 'FAC-'}${empty f.registrationNumber ? f.id : ''}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark fs-7">${not empty f.designation ? f.designation : 'Professor'}</div>
                                        <div class="small text-muted">${not empty f.department ? f.department : 'Computer Science'}</div>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary bg-opacity-10 text-primary me-1">${courseCounts[f.email]} Courses</span>
                                        <span class="badge bg-success bg-opacity-10 text-success">${studentCounts[f.email]} Students</span>
                                    </td>
                                    <td>
                                        <form action="/admin/faculty/${f.id}/toggle-status" method="POST" class="d-inline">
                                            <button type="submit" class="btn btn-sm ${f.status == 'ACTIVE' ? 'btn-success' : 'btn-warning'} rounded-pill px-3 py-0.5 fs-8 fw-bold">
                                                <i class="fa-solid ${f.status == 'ACTIVE' ? 'fa-check' : 'fa-pause'} me-1"></i> ${f.status}
                                            </button>
                                        </form>
                                    </td>
                                    <td class="text-end">
                                        <div class="dropdown d-inline">
                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle rounded-pill px-2.5" type="button" data-bs-toggle="dropdown">
                                                <i class="fa-solid fa-ellipsis-vertical"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2">
                                                <li><a class="dropdown-item fw-semibold" href="/admin/faculty/${f.id}"><i class="fa-solid fa-eye me-2 text-primary"></i> View Details & Courses</a></li>
                                                <li><button class="dropdown-item fw-semibold" data-bs-toggle="modal" data-bs-target="#assignCourseModal${f.id}"><i class="fa-solid fa-plus-circle me-2 text-success"></i> Assign Course</button></li>
                                                <li><button class="dropdown-item fw-semibold" data-bs-toggle="modal" data-bs-target="#resetFacultyPwdModal${f.id}"><i class="fa-solid fa-key me-2 text-warning"></i> Reset Password</button></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li>
                                                    <form action="/admin/faculty/${f.id}/delete" method="POST" onsubmit="return confirm('Are you sure you want to remove this faculty account?');">
                                                        <button type="submit" class="dropdown-item text-danger fw-semibold"><i class="fa-solid fa-trash me-2"></i> Delete Faculty</button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>

                                        <!-- Assign Course Modal -->
                                        <div class="modal fade text-start" id="assignCourseModal${f.id}" tabindex="-1">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow rounded-4">
                                                    <div class="modal-header bg-primary text-white p-3 px-4 rounded-top-4">
                                                        <h6 class="modal-title fw-bold"><i class="fa-solid fa-book-open me-2"></i> Assign Course to ${f.name}</h6>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="/admin/faculty/assign-course" method="POST">
                                                        <input type="hidden" name="facultyEmail" value="${f.email}">
                                                        <div class="modal-body p-4">
                                                            <label class="form-label small fw-bold">Select Course to Assign</label>
                                                            <select name="courseId" class="form-select rounded-3" required>
                                                                <c:forEach var="c" items="${allCourses}">
                                                                    <option value="${c.id}">${c.title} (Current: ${c.instructorName})</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="modal-footer bg-light border-0 p-3 rounded-bottom-4">
                                                            <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Confirm Assignment</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Reset Password Modal for faculty -->
                                        <div class="modal fade text-start" id="resetFacultyPwdModal${f.id}" tabindex="-1">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow rounded-4">
                                                    <div class="modal-header bg-dark text-white p-3 px-4 rounded-top-4">
                                                        <h6 class="modal-title fw-bold"><i class="fa-solid fa-key text-warning me-2"></i> Reset Password: ${f.name}</h6>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="/admin/faculty/${f.id}/reset-password" method="POST">
                                                        <div class="modal-body p-4">
                                                            <label class="form-label small fw-bold">New Password</label>
                                                            <input type="password" name="newPassword" class="form-control rounded-3" required minlength="6" placeholder="Enter new password">
                                                        </div>
                                                        <div class="modal-footer bg-light border-0 p-3 rounded-bottom-4">
                                                            <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Update Password</button>
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

<!-- MODAL: Add Faculty -->
<div class="modal fade" id="addFacultyModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-warning text-dark border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-chalkboard-user me-2"></i> Register New Faculty</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/faculty/add" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Faculty Full Name *</label>
                            <input type="text" name="name" class="form-control rounded-3" required placeholder="e.g. Prof. Alan Turing">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Email Address *</label>
                            <input type="email" name="email" class="form-control rounded-3" required placeholder="faculty@lms.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Mobile Number</label>
                            <input type="text" name="mobile" class="form-control rounded-3" placeholder="+91 98765 11111">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Initial Password *</label>
                            <input type="password" name="password" class="form-control rounded-3" required minlength="6" placeholder="At least 6 characters">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Faculty ID (Reg Number)</label>
                            <input type="text" name="registrationNumber" class="form-control rounded-3" placeholder="e.g. FAC-2026-505">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="Department of Computer Science & Engineering">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Designation</label>
                            <select name="designation" class="form-select rounded-3">
                                <option value="Professor">Professor</option>
                                <option value="Associate Professor">Associate Professor</option>
                                <option value="Assistant Professor" selected>Assistant Professor</option>
                                <option value="Lecturer">Lecturer</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Academic Qualification</label>
                            <input type="text" name="qualification" class="form-control rounded-3" placeholder="e.g. Ph.D. in Computer Science">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Specialization</label>
                            <input type="text" name="specialization" class="form-control rounded-3" placeholder="e.g. Cloud Computing & AI">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Experience</label>
                            <input type="text" name="experience" class="form-control rounded-3" placeholder="e.g. 5+ Years">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-warning text-dark rounded-pill px-4 fw-bold">
                        <i class="fa-solid fa-check me-1"></i> Create Faculty Account
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
