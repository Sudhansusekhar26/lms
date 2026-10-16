<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Student Profile - Cloud LMS" />
</jsp:include>

<style>
    :root {
        --stu-navy: #0f2b5c;
        --stu-blue: #1d70b8;
        --stu-ice: #dbeafe;
        --stu-card-bg: #ffffff;
        --stu-border: #e2e8f0;
    }
    .profile-hero {
        background: linear-gradient(135deg, #0f2b5c 0%, #1d70b8 100%);
        border-radius: 20px;
        padding: 2.5rem 2rem;
        color: white;
        position: relative;
        overflow: hidden;
        margin-bottom: 2rem;
        box-shadow: 0 10px 30px rgba(15, 43, 92, 0.15);
    }
    .profile-hero::before {
        content: '';
        position: absolute;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, transparent 70%);
        top: -100px;
        right: -50px;
        border-radius: 50%;
    }
    .profile-avatar-box {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        background: white;
        padding: 4px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }
    .profile-avatar-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }
    .info-card {
        background: white;
        border: 1px solid var(--stu-border);
        border-radius: 16px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 4px 16px rgba(15, 43, 92, 0.04);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .info-card:hover {
        box-shadow: 0 8px 24px rgba(15, 43, 92, 0.08);
    }
    .section-title {
        font-family: 'Outfit', sans-serif;
        font-weight: 700;
        font-size: 1.15rem;
        color: var(--stu-navy);
        display: flex;
        align-items: center;
        gap: 0.6rem;
        padding-bottom: 0.85rem;
        border-bottom: 2px solid #f1f5f9;
        margin-bottom: 1.25rem;
    }
    .info-label {
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #64748b;
        margin-bottom: 0.2rem;
    }
    .info-value {
        font-size: 0.95rem;
        font-weight: 700;
        color: #1e293b;
        word-break: break-word;
    }
    .stat-pill {
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.25);
        border-radius: 12px;
        padding: 0.75rem 1rem;
        text-align: center;
    }
    .cert-card {
        background: linear-gradient(135deg, #f8fafc, #edf2f7);
        border: 1.5px solid #cbd5e1;
        border-radius: 14px;
        padding: 1.25rem;
        position: relative;
        overflow: hidden;
    }
    .cert-card::after {
        content: '\f5a0';
        font-family: 'Font Awesome 6 Free';
        font-weight: 900;
        position: absolute;
        right: -10px;
        bottom: -15px;
        font-size: 5rem;
        color: rgba(29, 112, 184, 0.07);
        pointer-events: none;
    }
    .certificate-modal-view {
        background: #ffffff;
        border: 12px solid #0f2b5c;
        border-image: linear-gradient(to right, #0f2b5c, #1d70b8, #f59e0b, #0f2b5c) 1;
        padding: 2.5rem;
        position: relative;
    }
</style>

<div class="container py-4">
    <!-- Success & Error Alert Messages -->
    <c:if test="${not empty profileSuccess}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check fs-4 text-success"></i>
            <div>
                <strong>Success!</strong> ${profileSuccess}
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty pwdSuccessMessage}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-key fs-4 text-success"></i>
            <div>
                <strong>Password Changed!</strong> ${pwdSuccessMessage}
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty pwdErrorMessage}">
        <div class="alert alert-danger alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-triangle-exclamation fs-4 text-danger"></i>
            <div>
                <strong>Password Error:</strong> ${pwdErrorMessage}
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="smenu.jsp">
                <jsp:param name="active" value="profile" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">

            <!-- Hero Profile Banner -->
            <div class="profile-hero">
                <div class="row align-items-center g-4">
                    <div class="col-auto">
                        <div class="profile-avatar-box">
                            <c:choose>
                                <c:when test="${not empty student.profilePhoto}">
                                    <img src="${student.profilePhoto}" alt="${student.name}" class="profile-avatar-img">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-primary text-white d-flex align-items-center justify-content-center w-100 h-100 fs-1 fw-bold">
                                        <i class="fa-solid fa-user-graduate"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col">
                        <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                            <h2 class="h3 fw-bold mb-0 text-white">${student.name}</h2>
                            <span class="badge bg-success bg-opacity-75 text-white border border-light border-opacity-25 px-2.5 py-1 rounded-pill small">
                                <i class="fa-solid fa-circle-check me-1"></i> ${student.status}
                            </span>
                            <span class="badge bg-info bg-opacity-50 text-white border border-light border-opacity-25 px-2.5 py-1 rounded-pill small">
                                <i class="fa-solid fa-shield me-1"></i> Verified Student
                            </span>
                        </div>
                        <p class="mb-2 text-white-50 fs-6">
                            <i class="fa-solid fa-graduation-cap me-1"></i> ${not empty student.program ? student.program : 'B.Tech CSE'} 
                            &bull; <i class="fa-solid fa-building-columns me-1 ms-1"></i> ${not empty student.department ? student.department : 'Computer Science & Engineering'}
                        </p>
                        <p class="mb-0 text-white-50 small">
                            <i class="fa-solid fa-id-badge me-1"></i> Reg ID: <strong>${not empty student.registrationNumber ? student.registrationNumber : 'STU-'}${empty student.registrationNumber ? student.id : ''}</strong>
                            &bull; <i class="fa-solid fa-envelope me-1 ms-2"></i> ${student.email}
                        </p>
                    </div>
                    <div class="col-12 col-md-auto d-flex flex-md-column gap-2">
                        <button type="button" class="btn btn-light btn-sm fw-bold px-3 py-2 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="fa-solid fa-pen-to-square me-1 text-primary"></i> Edit Profile
                        </button>
                        <button type="button" class="btn btn-outline-light btn-sm fw-bold px-3 py-2 rounded-pill" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                            <i class="fa-solid fa-key me-1"></i> Change Password
                        </button>
                    </div>
                </div>

                <!-- Live Academic Metric Stats -->
                <div class="row g-3 mt-3 pt-3 border-top border-light border-opacity-20">
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill">
                            <div class="fs-4 fw-extrabold text-white">${enrollments.size()}</div>
                            <div class="small text-white-50 fs-8">Enrolled</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill">
                            <div class="fs-4 fw-extrabold text-success text-light">${completedCourses.size()}</div>
                            <div class="small text-white-50 fs-8">Completed</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill">
                            <div class="fs-4 fw-extrabold text-warning">${ongoingCourses.size()}</div>
                            <div class="small text-white-50 fs-8">Ongoing</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill">
                            <div class="fs-4 fw-extrabold text-info text-light">${avgProgress}%</div>
                            <div class="small text-white-50 fs-8">Avg Progress</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill">
                            <div class="fs-4 fw-extrabold text-white">${avgScore}%</div>
                            <div class="small text-white-50 fs-8">Avg Quiz Score</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill">
                            <div class="fs-4 fw-extrabold text-warning">${attendancePct}%</div>
                            <div class="small text-white-50 fs-8">Attendance</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- SECTION 1: Personal Information -->
            <div class="info-card">
                <div class="section-title">
                    <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <span>1. Personal Information</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-id-card-clip me-1 text-primary"></i> Student ID</div>
                        <div class="info-value">${not empty student.registrationNumber ? student.registrationNumber : 'STU-'}${empty student.registrationNumber ? student.id : ''}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-signature me-1 text-primary"></i> Full Name</div>
                        <div class="info-value">${student.name}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-image me-1 text-primary"></i> Profile Photo</div>
                        <div class="info-value">${not empty student.profilePhoto ? 'Custom Photo Set' : 'Default Academic Avatar'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-cake-candles me-1 text-primary"></i> Date of Birth</div>
                        <div class="info-value">${not empty student.dob ? student.dob : '2003-05-15'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-venus-mars me-1 text-primary"></i> Gender</div>
                        <div class="info-value">${not empty student.gender ? student.gender : 'Male'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-envelope me-1 text-primary"></i> Email Address</div>
                        <div class="info-value text-primary">${student.email}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-phone me-1 text-primary"></i> Mobile Number</div>
                        <div class="info-value">${not empty student.mobile ? student.mobile : '+91 98765 43210'}</div>
                    </div>
                    <div class="col-md-8 col-sm-12">
                        <div class="info-label"><i class="fa-solid fa-location-dot me-1 text-primary"></i> Address</div>
                        <div class="info-value">${not empty student.address ? student.address : 'Hostel Block H-4, Room 302, University Campus'}</div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="info-label"><i class="fa-solid fa-city me-1 text-primary"></i> City</div>
                        <div class="info-value">${not empty student.city ? student.city : 'Bhubaneswar'}</div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="info-label"><i class="fa-solid fa-map-location-dot me-1 text-primary"></i> State</div>
                        <div class="info-value">${not empty student.state ? student.state : 'Odisha'}</div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="info-label"><i class="fa-solid fa-earth-americas me-1 text-primary"></i> Country</div>
                        <div class="info-value">${not empty student.country ? student.country : 'India'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 2: Academic Information -->
            <div class="info-card">
                <div class="section-title">
                    <div class="bg-success bg-opacity-10 text-success rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-graduation-cap"></i>
                    </div>
                    <span>2. Academic Information</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-hashtag me-1 text-success"></i> Roll Number</div>
                        <div class="info-value">${not empty student.rollNumber ? student.rollNumber : 'CSE-2023-042'}</div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-fingerprint me-1 text-success"></i> Registration Number</div>
                        <div class="info-value">${not empty student.registrationNumber ? student.registrationNumber : 'STU-2026-100'}</div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="info-label"><i class="fa-solid fa-book-open-reader me-1 text-success"></i> Course / Program</div>
                        <div class="info-value">${not empty student.program ? student.program : 'B.Tech CSE'}</div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="info-label"><i class="fa-solid fa-building-columns me-1 text-success"></i> Department</div>
                        <div class="info-value">${not empty student.department ? student.department : 'Department of Computer Science & Engineering'}</div>
                    </div>
                    <div class="col-md-2 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-layer-group me-1 text-success"></i> Semester</div>
                        <div class="info-value">${not empty student.semester ? student.semester : '6th Semester'}</div>
                    </div>
                    <div class="col-md-2 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-calendar me-1 text-success"></i> Year</div>
                        <div class="info-value">${not empty student.academicYear ? student.academicYear : '3rd Year'}</div>
                    </div>
                    <div class="col-md-2 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-people-group me-1 text-success"></i> Batch</div>
                        <div class="info-value">${not empty student.batch ? student.batch : '2023 - 2027'}</div>
                    </div>
                    <div class="col-md-2 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-chalkboard me-1 text-success"></i> Section</div>
                        <div class="info-value">${not empty student.section ? student.section : 'Section A'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 3: LMS Information -->
            <div class="info-card">
                <div class="section-title">
                    <div class="bg-warning bg-opacity-10 text-warning rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-laptop-code text-warning"></i>
                    </div>
                    <span>3. LMS Information</span>
                </div>

                <!-- Metric Highlights -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Enrolled Courses</div>
                            <div class="fs-4 fw-bold text-primary">${enrollments.size()} Courses</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Completed Courses</div>
                            <div class="fs-4 fw-bold text-success">${completedCourses.size()} Courses</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Ongoing Courses</div>
                            <div class="fs-4 fw-bold text-warning">${ongoingCourses.size()} Courses</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Lessons Completed</div>
                            <div class="fs-4 fw-bold text-info">${totalCompletedLessons} Lessons</div>
                        </div>
                    </div>
                </div>

                <!-- Course Progress Details Table -->
                <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-bars-progress me-2 text-primary"></i> Enrolled Courses & Progress %</h6>
                <c:choose>
                    <c:when test="${not empty enrollments}">
                        <div class="table-responsive mb-4">
                            <table class="table table-hover align-middle border mb-0">
                                <thead class="table-light">
                                    <tr class="fs-8 text-uppercase text-muted">
                                        <th>Course Name</th>
                                        <th>Instructor</th>
                                        <th>Category</th>
                                        <th style="width: 25%;">Course Progress %</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="e" items="${enrollments}">
                                        <tr>
                                            <td>
                                                <div class="fw-bold text-dark">${e.course.title}</div>
                                                <span class="badge bg-secondary bg-opacity-10 text-secondary fs-8">${e.course.level}</span>
                                            </td>
                                            <td class="small text-muted">${e.course.instructorName}</td>
                                            <td><span class="badge bg-primary bg-opacity-10 text-primary">${e.course.category != null ? e.course.category.name : 'General'}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="progress flex-grow-1" style="height: 8px;">
                                                        <div class="progress-bar ${e.progressPct >= 100 ? 'bg-success' : 'bg-primary'}" style="width: ${e.progressPct}%;"></div>
                                                    </div>
                                                    <span class="fw-bold small ${e.progressPct >= 100 ? 'text-success' : 'text-primary'}">${e.progressPct}%</span>
                                                </div>
                                            </td>
                                            <td class="text-end">
                                                <a href="/student/courses/${e.course.id}/learn" class="btn btn-sm ${e.progressPct >= 100 ? 'btn-outline-success' : 'btn-primary'} rounded-pill px-3 py-1">
                                                    <i class="fa-solid ${e.progressPct >= 100 ? 'fa-check' : 'fa-play'} me-1"></i> ${e.progressPct >= 100 ? 'Completed' : 'Continue'}
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-light border text-center p-3 mb-4 text-muted">
                            No courses enrolled yet. <a href="/catalog" class="fw-bold text-primary">Browse Course Catalog</a>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Quiz / Assignment Scores -->
                <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-list-check me-2 text-warning"></i> Quiz & Assignment Scores</h6>
                <c:choose>
                    <c:when test="${not empty submissions}">
                        <div class="table-responsive mb-4">
                            <table class="table table-sm table-hover align-middle border mb-0">
                                <thead class="table-light">
                                    <tr class="fs-8 text-uppercase text-muted">
                                        <th>Quiz Title</th>
                                        <th>Course</th>
                                        <th>Marks Score</th>
                                        <th>Score %</th>
                                        <th>Result</th>
                                        <th>Submitted On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sub" items="${submissions}">
                                        <tr>
                                            <td class="fw-semibold text-dark">${sub.quiz.title}</td>
                                            <td class="small text-muted">${sub.quiz.course.title}</td>
                                            <td><strong>${sub.correctAnswers}</strong> / ${sub.totalQuestions}</td>
                                            <td>
                                                <span class="fw-bold ${sub.scorePct >= 60 ? 'text-success' : 'text-danger'}">${sub.scorePct}%</span>
                                            </td>
                                            <td>
                                                <span class="badge ${sub.status == 'PASS' ? 'bg-success' : 'bg-danger'} bg-opacity-25 ${sub.status == 'PASS' ? 'text-success' : 'text-danger'} border ${sub.status == 'PASS' ? 'border-success' : 'border-danger'} rounded-pill px-2 py-1">
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
                        <div class="alert alert-light border text-center p-3 mb-4 text-muted">
                            No quiz submissions yet. <a href="/student/quizzes" class="fw-bold text-primary">Take an assessment</a>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Certificates Earned -->
                <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-award me-2 text-warning"></i> Certificates Earned</h6>
                <c:choose>
                    <c:when test="${not empty completedCourses}">
                        <div class="row g-3 mb-3">
                            <c:forEach var="comp" items="${completedCourses}">
                                <div class="col-md-6">
                                    <div class="cert-card">
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <i class="fa-solid fa-certificate text-warning fs-4"></i>
                                            <div>
                                                <h6 class="fw-bold text-navy mb-0">${comp.course.title}</h6>
                                                <span class="badge bg-success bg-opacity-25 text-success small">Verified Certificate</span>
                                            </div>
                                        </div>
                                        <p class="small text-muted mb-2">Issued by: <strong>Cloud LMS University</strong> &bull; Grade: <strong>Distinction</strong></p>
                                        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
                                            <span class="small text-muted fs-8">Cert ID: <strong>CERT-STU-${comp.course.id}-${student.id}</strong></span>
                                            <div class="d-flex gap-1">
                                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-2.5 py-1" onclick="viewCertificate('${comp.course.title}', '${student.name}', 'CERT-STU-${comp.course.id}-${student.id}', '${comp.course.instructorName}')">
                                                    <i class="fa-solid fa-eye me-1"></i> Quick View
                                                </button>
                                                <a href="/certificate/CERT-STU-${comp.course.id}-${student.id}" target="_blank" class="btn btn-sm btn-success rounded-pill px-2.5 py-1 text-white">
                                                    <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Public Credential
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-3 bg-light rounded-3 border text-center text-muted mb-3">
                            <i class="fa-solid fa-award fs-3 mb-2 text-secondary"></i>
                            <p class="small mb-0">Complete 100% of any enrolled course to unlock your verified course completion certificate.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Attendance & Last Login -->
                <div class="row g-3 pt-2">
                    <div class="col-md-6">
                        <div class="info-label"><i class="fa-solid fa-clipboard-user me-1 text-primary"></i> Attendance Status</div>
                        <div class="info-value text-success"><i class="fa-solid fa-circle-check me-1"></i> ${attendancePct}% Regular Attendance Tracked</div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-label"><i class="fa-solid fa-clock-rotate-left me-1 text-primary"></i> Last Login Session</div>
                        <div class="info-value">${not empty student.lastLogin ? student.lastLogin : 'Active Now'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 4: Account Information -->
            <div class="info-card">
                <div class="section-title">
                    <div class="bg-danger bg-opacity-10 text-danger rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <span>4. Account Information</span>
                </div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-user-shield me-1 text-danger"></i> Username / Email</div>
                        <div class="info-value">${student.email}</div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-key me-1 text-danger"></i> Password Hash</div>
                        <div class="info-value text-muted">•••••••• (BCrypt Hashed)</div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-circle-dot me-1 text-danger"></i> Account Status</div>
                        <div>
                            <span class="badge ${student.status == 'ACTIVE' ? 'bg-success' : 'bg-warning'} px-3 py-1.5 rounded-pill">
                                ${student.status}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label"><i class="fa-solid fa-calendar-check me-1 text-danger"></i> Registration Date</div>
                        <div class="info-value">${student.createdAt}</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- MODAL: Edit Student Profile -->
<div class="modal fade" id="editProfileModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-primary text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-pen me-2"></i> Edit Student Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/student/profile/update" method="POST">
                <div class="modal-body p-4">
                    <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-user me-2 text-primary"></i> Personal Details</h6>
                    <div class="row g-3 mb-4">
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
                            <label class="form-label small fw-bold">Profile Photo URL</label>
                            <input type="text" name="profilePhoto" class="form-control rounded-3" value="${student.profilePhoto}" placeholder="https://... or avatar URL">
                        </div>
                        <div class="col-md-12">
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
                            <input type="text" name="country" class="form-control rounded-3" value="${not empty student.country ? student.country : 'India'}">
                        </div>
                    </div>

                    <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-graduation-cap me-2 text-success"></i> Academic Details</h6>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Roll Number</label>
                            <input type="text" name="rollNumber" class="form-control rounded-3" value="${student.rollNumber}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Program / Degree</label>
                            <input type="text" name="program" class="form-control rounded-3" value="${student.program}" placeholder="e.g. B.Tech CSE">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="${student.department}" placeholder="Department of Computer Science">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Semester</label>
                            <input type="text" name="semester" class="form-control rounded-3" value="${student.semester}" placeholder="e.g. 6th Semester">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Academic Year</label>
                            <input type="text" name="academicYear" class="form-control rounded-3" value="${student.academicYear}" placeholder="e.g. 3rd Year">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Batch</label>
                            <input type="text" name="batch" class="form-control rounded-3" value="${student.batch}" placeholder="e.g. 2023 - 2027">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Section</label>
                            <input type="text" name="section" class="form-control rounded-3" value="${student.section}" placeholder="e.g. Section A">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Bio / Academic Interest</label>
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

<!-- MODAL: Change Password -->
<div class="modal fade" id="changePasswordModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-dark text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-lock me-2 text-warning"></i> Change Password</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/student/profile/change-password" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Current Password *</label>
                        <input type="password" name="currentPassword" class="form-control rounded-3" required placeholder="Enter current password">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">New Password (min 6 characters) *</label>
                        <input type="password" name="newPassword" class="form-control rounded-3" required minlength="6" placeholder="Enter new secure password">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Confirm New Password *</label>
                        <input type="password" name="confirmPassword" class="form-control rounded-3" required minlength="6" placeholder="Repeat new password">
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">
                        <i class="fa-solid fa-check me-1"></i> Update Password
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL: Certificate Viewer -->
<div class="modal fade" id="certificateModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
            <div class="modal-body p-0">
                <div class="certificate-modal-view text-center">
                    <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-3">
                        <div class="d-flex align-items-center gap-2">
                            <i class="fa-solid fa-graduation-cap fs-2 text-primary"></i>
                            <div class="text-start">
                                <h5 class="fw-extrabold text-navy mb-0">CLOUD LMS ACADEMY</h5>
                                <span class="fs-8 text-muted">Institutional Certificate of Excellence</span>
                            </div>
                        </div>
                        <div class="badge bg-success bg-opacity-25 text-success border border-success px-3 py-1.5 rounded-pill">
                            <i class="fa-solid fa-shield-check me-1"></i> VERIFIED CREDENTIAL
                        </div>
                    </div>

                    <p class="text-uppercase text-muted letter-spacing-2 fs-8 mb-2">This is to certify that</p>
                    <h3 class="fw-bold text-navy mb-3" id="certStudentName">${student.name}</h3>
                    <p class="text-muted mb-3">has successfully satisfied all rigorous curriculum modules and passed assessments for the course</p>
                    <h4 class="fw-extrabold text-primary mb-4" id="certCourseTitle">Course Name</h4>

                    <div class="row align-items-center justify-content-between pt-4 border-top">
                        <div class="col-4 text-start">
                            <div class="fw-bold text-dark fs-7" id="certInstructor">Instructor</div>
                            <div class="fs-8 text-muted">Authorized Faculty Instructor</div>
                        </div>
                        <div class="col-4">
                            <i class="fa-solid fa-stamp fs-1 text-warning"></i>
                            <div class="fs-8 fw-bold text-navy mt-1">OFFICIAL SEAL</div>
                        </div>
                        <div class="col-4 text-end">
                            <div class="fw-bold text-dark fs-7" id="certCode">CERT-ID</div>
                            <div class="fs-8 text-muted">Verification ID</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer bg-light p-3 border-0 d-flex justify-content-between">
                <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary rounded-pill px-4" onclick="window.print()">
                    <i class="fa-solid fa-print me-1"></i> Print / Download PDF
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    function viewCertificate(courseTitle, studentName, certCode, instructor) {
        document.getElementById('certCourseTitle').innerText = courseTitle;
        document.getElementById('certStudentName').innerText = studentName;
        document.getElementById('certCode').innerText = certCode;
        document.getElementById('certInstructor').innerText = instructor || 'Senior Faculty';
        new bootstrap.Modal(document.getElementById('certificateModal')).show();
    }
</script>

<jsp:include page="../footer.jsp" />
