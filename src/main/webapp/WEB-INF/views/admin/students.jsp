<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Student Management - Admin - Cloud LMS" />
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
                <jsp:param name="active" value="students" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-user-graduate text-success me-2"></i> Student Management</h4>
                        <p class="text-muted small mb-0">Monitor, enroll, verify, activate/deactivate, and govern student accounts.</p>
                    </div>
                    <button type="button" class="btn btn-success rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#addStudentModal">
                        <i class="fa-solid fa-user-plus me-1"></i> Add New Student
                    </button>
                </div>

                <!-- Search & Filters -->
                <form action="/admin/students" method="GET" class="row g-2 mb-4">
                    <div class="col-md-9">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                            <input type="text" name="search" class="form-control border-start-0 ps-0" placeholder="Search by name, email, roll number, or reg ID..." value="${search}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary w-100 rounded-3 fw-bold">Search</button>
                    </div>
                </form>

                <!-- Students Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Student Details</th>
                                <th>Academic Profile</th>
                                <th>Enrolled / Completed</th>
                                <th>Account Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${students}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px;">
                                                <i class="fa-solid fa-user-graduate"></i>
                                            </div>
                                            <div>
                                                <div class="fw-bold text-dark">${s.name}</div>
                                                <div class="small text-muted">${s.email}</div>
                                                <span class="badge bg-light text-dark border fs-8">Reg: ${not empty s.registrationNumber ? s.registrationNumber : 'STU-'}${empty s.registrationNumber ? s.id : ''}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark fs-7">${not empty s.program ? s.program : 'B.Tech CSE'}</div>
                                        <div class="small text-muted">Roll: <strong>${not empty s.rollNumber ? s.rollNumber : 'N/A'}</strong> &bull; ${not empty s.semester ? s.semester : '1st Sem'}</div>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary bg-opacity-10 text-primary me-1">${enrollmentCounts[s.email]} Enrolled</span>
                                        <span class="badge bg-success bg-opacity-10 text-success">${completedCounts[s.email]} Done</span>
                                    </td>
                                    <td>
                                        <form action="/admin/students/${s.id}/toggle-status" method="POST" class="d-inline">
                                            <button type="submit" class="btn btn-sm ${s.status == 'ACTIVE' ? 'btn-success' : 'btn-warning'} rounded-pill px-3 py-0.5 fs-8 fw-bold">
                                                <i class="fa-solid ${s.status == 'ACTIVE' ? 'fa-check' : 'fa-pause'} me-1"></i> ${s.status}
                                            </button>
                                        </form>
                                    </td>
                                    <td class="text-end">
                                        <div class="dropdown d-inline">
                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle rounded-pill px-2.5" type="button" data-bs-toggle="dropdown">
                                                <i class="fa-solid fa-ellipsis-vertical"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 p-2">
                                                <li><a class="dropdown-item fw-semibold" href="/admin/students/${s.id}"><i class="fa-solid fa-eye me-2 text-primary"></i> View Details & Progress</a></li>
                                                <li><button class="dropdown-item fw-semibold" data-bs-toggle="modal" data-bs-target="#resetPwdModal${s.id}"><i class="fa-solid fa-key me-2 text-warning"></i> Reset Password</button></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li>
                                                    <form action="/admin/students/${s.id}/delete" method="POST" onsubmit="return confirm('Are you sure you want to delete this student account?');">
                                                        <button type="submit" class="dropdown-item text-danger fw-semibold"><i class="fa-solid fa-trash me-2"></i> Delete Student</button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>

                                        <!-- Reset Password Modal for student -->
                                        <div class="modal fade text-start" id="resetPwdModal${s.id}" tabindex="-1">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow rounded-4">
                                                    <div class="modal-header bg-dark text-white p-3 px-4 rounded-top-4">
                                                        <h6 class="modal-title fw-bold"><i class="fa-solid fa-key text-warning me-2"></i> Reset Password: ${s.name}</h6>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="/admin/students/${s.id}/reset-password" method="POST">
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

<!-- MODAL: Add Student -->
<div class="modal fade" id="addStudentModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-success text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-plus me-2"></i> Register New Student</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/students/add" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Student Full Name *</label>
                            <input type="text" name="name" class="form-control rounded-3" required placeholder="e.g. John Doe">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Email Address *</label>
                            <input type="email" name="email" class="form-control rounded-3" required placeholder="student@lms.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Mobile Number</label>
                            <input type="text" name="mobile" class="form-control rounded-3" placeholder="+91 98765 00000">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Initial Password *</label>
                            <input type="password" name="password" class="form-control rounded-3" required minlength="6" placeholder="At least 6 characters">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Registration Number (ID)</label>
                            <input type="text" name="registrationNumber" class="form-control rounded-3" placeholder="e.g. STU-2026-105">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Roll Number</label>
                            <input type="text" name="rollNumber" class="form-control rounded-3" placeholder="e.g. CSE-2024-001">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Program / Degree</label>
                            <input type="text" name="program" class="form-control rounded-3" value="B.Tech CSE">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="Department of Computer Science & Engineering">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Semester</label>
                            <input type="text" name="semester" class="form-control rounded-3" value="1st Semester">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Batch</label>
                            <input type="text" name="batch" class="form-control rounded-3" value="2024 - 2028">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Section</label>
                            <input type="text" name="section" class="form-control rounded-3" value="Section A">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-pill px-4 fw-bold">
                        <i class="fa-solid fa-check me-1"></i> Create Student Account
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
