<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Student Details - Admin - Cloud LMS" />
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
                <jsp:param name="active" value="students" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <!-- Header Summary Card -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4" style="background: linear-gradient(135deg, #0f2b5c, #1d70b8); color: white;">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-circle bg-white text-primary d-flex align-items-center justify-content-center fw-bold fs-2" style="width: 70px; height: 70px;">
                            <i class="fa-solid fa-user-graduate"></i>
                        </div>
                        <div>
                            <h3 class="fw-bold mb-0 text-white">${student.name}</h3>
                            <p class="text-white-50 mb-0">${student.email} &bull; ID: <strong>${not empty student.registrationNumber ? student.registrationNumber : 'STU-'}${empty student.registrationNumber ? student.id : ''}</strong></p>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="/admin/students" class="btn btn-outline-light rounded-pill px-3 py-1.5 fw-semibold">
                            <i class="fa-solid fa-arrow-left me-1"></i> Back to Students
                        </a>
                        <button class="btn btn-light rounded-pill px-3 py-1.5 fw-bold text-primary" data-bs-toggle="modal" data-bs-target="#editStudentModal">
                            <i class="fa-solid fa-pen-to-square me-1"></i> Edit Student
                        </button>
                    </div>
                </div>
            </div>

            <!-- Student Profile Information Card -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-id-card me-2 text-primary"></i> Academic & Personal Information</h5>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Roll Number</div>
                        <div class="fw-bold text-dark">${not empty student.rollNumber ? student.rollNumber : 'N/A'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Program</div>
                        <div class="fw-bold text-dark">${not empty student.program ? student.program : 'B.Tech CSE'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Department</div>
                        <div class="fw-bold text-dark">${not empty student.department ? student.department : 'Computer Science & Engineering'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Semester & Year</div>
                        <div class="fw-bold text-dark">${not empty student.semester ? student.semester : '1st Semester'} (${not empty student.academicYear ? student.academicYear : '1st Year'})</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Batch & Section</div>
                        <div class="fw-bold text-dark">${not empty student.batch ? student.batch : '2024-2028'} (${not empty student.section ? student.section : 'A'})</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="small text-muted fw-bold text-uppercase">Mobile</div>
                        <div class="fw-bold text-dark">${not empty student.mobile ? student.mobile : 'N/A'}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="small text-muted fw-bold text-uppercase">Address & Location</div>
                        <div class="fw-bold text-dark">${not empty student.address ? student.address : 'N/A'}, ${not empty student.city ? student.city : ''} ${not empty student.state ? student.state : ''}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="small text-muted fw-bold text-uppercase">Registration Date</div>
                        <div class="fw-bold text-dark">${student.createdAt}</div>
                    </div>
                </div>
            </div>

            <!-- Enrolled Courses -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-book-bookmark me-2 text-primary"></i> Enrolled Courses (${enrollments.size()})</h5>
                <c:choose>
                    <c:when test="${not empty enrollments}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle border mb-0">
                                <thead class="table-light">
                                    <tr class="fs-8 text-uppercase text-muted">
                                        <th>Course Name</th>
                                        <th>Instructor</th>
                                        <th style="width: 30%;">Learning Progress %</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="e" items="${enrollments}">
                                        <tr>
                                            <td class="fw-bold text-dark">${e.course.title}</td>
                                            <td class="small text-muted">${e.course.instructorName}</td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="progress flex-grow-1" style="height: 8px;">
                                                        <div class="progress-bar ${e.progressPct >= 100 ? 'bg-success' : 'bg-primary'}" style="width: ${e.progressPct}%;"></div>
                                                    </div>
                                                    <span class="small fw-bold">${e.progressPct}%</span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge ${e.progressPct >= 100 ? 'bg-success' : 'bg-primary'} px-2.5 py-1 rounded-pill">
                                                    ${e.progressPct >= 100 ? 'Completed' : 'In Progress'}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-3 bg-light rounded-3 text-muted text-center">No courses enrolled yet.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Quiz & Assignment Submissions -->
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-list-check me-2 text-warning"></i> Quiz & Assignment Results (${submissions.size()})</h5>
                <c:choose>
                    <c:when test="${not empty submissions}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle border mb-0">
                                <thead class="table-light">
                                    <tr class="fs-8 text-uppercase text-muted">
                                        <th>Assessment</th>
                                        <th>Course</th>
                                        <th>Score</th>
                                        <th>Percentage</th>
                                        <th>Result</th>
                                        <th>Submitted At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sub" items="${submissions}">
                                        <tr>
                                            <td class="fw-bold text-dark">${sub.quiz.title}</td>
                                            <td class="small text-muted">${sub.quiz.course.title}</td>
                                            <td><strong>${sub.score}</strong> / ${sub.totalPoints}</td>
                                            <td class="fw-bold ${sub.scorePct >= 60 ? 'text-success' : 'text-danger'}">${sub.scorePct}%</td>
                                            <td>
                                                <span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'} px-2.5 py-1 rounded-pill">
                                                    ${sub.status}
                                                </span>
                                            </td>
                                            <td class="small text-muted">${sub.submittedAt}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-3 bg-light rounded-3 text-muted text-center">No assessment submissions recorded.</div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</div>

<!-- MODAL: Edit Student Details -->
<div class="modal fade" id="editStudentModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-primary text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-pen me-2"></i> Edit Student: ${student.name}</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/students/${student.id}/update" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Full Name *</label>
                            <input type="text" name="name" class="form-control rounded-3" value="${student.name}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Mobile Number</label>
                            <input type="text" name="mobile" class="form-control rounded-3" value="${student.mobile}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Date of Birth</label>
                            <input type="date" name="dob" class="form-control rounded-3" value="${student.dob}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Gender</label>
                            <select name="gender" class="form-select rounded-3">
                                <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${student.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Roll Number</label>
                            <input type="text" name="rollNumber" class="form-control rounded-3" value="${student.rollNumber}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Program / Degree</label>
                            <input type="text" name="program" class="form-control rounded-3" value="${student.program}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="${student.department}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Semester</label>
                            <input type="text" name="semester" class="form-control rounded-3" value="${student.semester}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Academic Year</label>
                            <input type="text" name="academicYear" class="form-control rounded-3" value="${student.academicYear}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Batch</label>
                            <input type="text" name="batch" class="form-control rounded-3" value="${student.batch}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Section</label>
                            <input type="text" name="section" class="form-control rounded-3" value="${student.section}">
                        </div>
                        <div class="col-md-8">
                            <label class="form-label small fw-bold">Address</label>
                            <input type="text" name="address" class="form-control rounded-3" value="${student.address}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">City</label>
                            <input type="text" name="city" class="form-control rounded-3" value="${student.city}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">State</label>
                            <input type="text" name="state" class="form-control rounded-3" value="${student.state}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Country</label>
                            <input type="text" name="country" class="form-control rounded-3" value="${student.country}">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Bio / Notes</label>
                            <textarea name="bio" class="form-control rounded-3" rows="2">${student.bio}</textarea>
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
