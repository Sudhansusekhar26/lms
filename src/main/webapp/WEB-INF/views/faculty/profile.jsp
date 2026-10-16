<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Faculty Profile - Cloud LMS" />
</jsp:include>

<style>
    :root {
        --fac-navy: #0f2b5c;
        --fac-purple: #6366f1;
        --fac-blue: #1d70b8;
        --fac-card-bg: #ffffff;
        --fac-border: #e2e8f0;
    }
    .profile-hero-faculty {
        background: linear-gradient(135deg, #1e1b4b 0%, #312e81 50%, #1d70b8 100%);
        border-radius: 20px;
        padding: 2.5rem 2rem;
        color: white;
        position: relative;
        overflow: hidden;
        margin-bottom: 2rem;
        box-shadow: 0 10px 30px rgba(30, 27, 75, 0.2);
    }
    .profile-hero-faculty::before {
        content: '';
        position: absolute;
        width: 320px;
        height: 320px;
        background: radial-gradient(circle, rgba(139, 92, 246, 0.25) 0%, transparent 70%);
        top: -100px;
        right: -50px;
        border-radius: 50%;
    }
    .profile-avatar-box-fac {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        background: white;
        padding: 4px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.25);
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }
    .profile-avatar-img-fac {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }
    .info-card-fac {
        background: white;
        border: 1px solid var(--fac-border);
        border-radius: 16px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 4px 16px rgba(15, 43, 92, 0.04);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .info-card-fac:hover {
        box-shadow: 0 8px 24px rgba(15, 43, 92, 0.08);
    }
    .section-title-fac {
        font-family: 'Outfit', sans-serif;
        font-weight: 700;
        font-size: 1.15rem;
        color: var(--fac-navy);
        display: flex;
        align-items: center;
        gap: 0.6rem;
        padding-bottom: 0.85rem;
        border-bottom: 2px solid #f1f5f9;
        margin-bottom: 1.25rem;
    }
    .info-label-fac {
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #64748b;
        margin-bottom: 0.2rem;
    }
    .info-value-fac {
        font-size: 0.95rem;
        font-weight: 700;
        color: #1e293b;
        word-break: break-word;
    }
    .stat-pill-fac {
        background: rgba(255, 255, 255, 0.12);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 12px;
        padding: 0.75rem 1rem;
        text-align: center;
    }
</style>

<div class="container py-4">
    <!-- Alerts -->
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
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="profile" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">

            <!-- Hero Faculty Profile Banner -->
            <div class="profile-hero-faculty">
                <div class="row align-items-center g-4">
                    <div class="col-auto">
                        <div class="profile-avatar-box-fac">
                            <c:choose>
                                <c:when test="${not empty faculty.profilePhoto}">
                                    <img src="${faculty.profilePhoto}" alt="${faculty.name}" class="profile-avatar-img-fac">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-indigo text-white d-flex align-items-center justify-content-center w-100 h-100 fs-1 fw-bold" style="background-color: #6366f1;">
                                        <i class="fa-solid fa-chalkboard-user"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col">
                        <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                            <h2 class="h3 fw-bold mb-0 text-white">${faculty.name}</h2>
                            <span class="badge bg-success bg-opacity-75 text-white border border-light border-opacity-25 px-2.5 py-1 rounded-pill small">
                                <i class="fa-solid fa-circle-check me-1"></i> ${faculty.status}
                            </span>
                            <span class="badge bg-purple bg-opacity-75 text-white border border-light border-opacity-25 px-2.5 py-1 rounded-pill small" style="background-color: #8b5cf6;">
                                <i class="fa-solid fa-award me-1"></i> ${not empty faculty.designation ? faculty.designation : 'Professor'}
                            </span>
                        </div>
                        <p class="mb-2 text-white-50 fs-6">
                            <i class="fa-solid fa-building-columns me-1"></i> ${not empty faculty.department ? faculty.department : 'Computer Science & Engineering'} 
                            &bull; <i class="fa-solid fa-user-graduate me-1 ms-1"></i> ${not empty faculty.qualification ? faculty.qualification : 'Ph.D. in Computer Science'}
                        </p>
                        <p class="mb-0 text-white-50 small">
                            <i class="fa-solid fa-id-badge me-1"></i> Faculty ID: <strong>${not empty faculty.registrationNumber ? faculty.registrationNumber : 'FAC-'}${empty faculty.registrationNumber ? faculty.id : ''}</strong>
                            &bull; <i class="fa-solid fa-envelope me-1 ms-2"></i> ${faculty.email}
                        </p>
                    </div>
                    <div class="col-12 col-md-auto d-flex flex-md-column gap-2">
                        <button type="button" class="btn btn-light btn-sm fw-bold px-3 py-2 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#editFacultyProfileModal">
                            <i class="fa-solid fa-user-pen me-1 text-primary"></i> Edit Profile
                        </button>
                        <button type="button" class="btn btn-outline-light btn-sm fw-bold px-3 py-2 rounded-pill" data-bs-toggle="modal" data-bs-target="#changeFacultyPasswordModal">
                            <i class="fa-solid fa-key me-1"></i> Change Password
                        </button>
                    </div>
                </div>

                <!-- Live Faculty Teaching Metrics -->
                <div class="row g-3 mt-3 pt-3 border-top border-light border-opacity-20">
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-fac">
                            <div class="fs-4 fw-extrabold text-white">${totalCourses}</div>
                            <div class="small text-white-50 fs-8">Courses</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-fac">
                            <div class="fs-4 fw-extrabold text-white">${totalStudents}</div>
                            <div class="small text-white-50 fs-8">Total Students</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-fac">
                            <div class="fs-4 fw-extrabold text-warning">${totalMaterials}</div>
                            <div class="small text-white-50 fs-8">Study Materials</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-fac">
                            <div class="fs-4 fw-extrabold text-info text-light">${liveClasses.size()}</div>
                            <div class="small text-white-50 fs-8">Live Classes</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-fac">
                            <div class="fs-4 fw-extrabold text-white">${quizzes.size()}</div>
                            <div class="small text-white-50 fs-8">Quizzes Created</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-fac">
                            <div class="fs-4 fw-extrabold text-success text-light">${passRate}%</div>
                            <div class="small text-white-50 fs-8">Avg Pass Rate</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- SECTION 1: Personal Information -->
            <div class="info-card-fac">
                <div class="section-title-fac">
                    <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <span>1. Personal Information</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-id-card-clip me-1 text-primary"></i> Faculty ID</div>
                        <div class="info-value-fac">${not empty faculty.registrationNumber ? faculty.registrationNumber : 'FAC-'}${empty faculty.registrationNumber ? faculty.id : ''}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-signature me-1 text-primary"></i> Full Name</div>
                        <div class="info-value-fac">${faculty.name}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-image me-1 text-primary"></i> Profile Photo</div>
                        <div class="info-value-fac">${not empty faculty.profilePhoto ? 'Custom Photo Set' : 'Default Faculty Avatar'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-cake-candles me-1 text-primary"></i> Date of Birth</div>
                        <div class="info-value-fac">${not empty faculty.dob ? faculty.dob : '1985-06-23'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-venus-mars me-1 text-primary"></i> Gender</div>
                        <div class="info-value-fac">${not empty faculty.gender ? faculty.gender : 'Male'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-envelope me-1 text-primary"></i> Email Address</div>
                        <div class="info-value-fac text-primary">${faculty.email}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-phone me-1 text-primary"></i> Mobile Number</div>
                        <div class="info-value-fac">${not empty faculty.mobile ? faculty.mobile : '+91 98765 12345'}</div>
                    </div>
                    <div class="col-md-8 col-sm-12">
                        <div class="info-label-fac"><i class="fa-solid fa-location-dot me-1 text-primary"></i> Address</div>
                        <div class="info-value-fac">${not empty faculty.address ? faculty.address : 'Staff Quarters Q-12, Green Hills University Campus'}</div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="info-label-fac"><i class="fa-solid fa-city me-1 text-primary"></i> City</div>
                        <div class="info-value-fac">${not empty faculty.city ? faculty.city : 'Bhubaneswar'}</div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="info-label-fac"><i class="fa-solid fa-map-location-dot me-1 text-primary"></i> State</div>
                        <div class="info-value-fac">${not empty faculty.state ? faculty.state : 'Odisha'}</div>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <div class="info-label-fac"><i class="fa-solid fa-earth-americas me-1 text-primary"></i> Country</div>
                        <div class="info-value-fac">${not empty faculty.country ? faculty.country : 'India'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 2: Professional Information -->
            <div class="info-card-fac">
                <div class="section-title-fac">
                    <div class="bg-purple bg-opacity-10 text-white rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; background-color: #6366f1;">
                        <i class="fa-solid fa-briefcase"></i>
                    </div>
                    <span>2. Professional Information</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-id-badge me-1 text-purple" style="color: #6366f1;"></i> Employee / Faculty ID</div>
                        <div class="info-value-fac">${not empty faculty.registrationNumber ? faculty.registrationNumber : 'FAC-2026-500'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-building-columns me-1 text-purple" style="color: #6366f1;"></i> Department</div>
                        <div class="info-value-fac">${not empty faculty.department ? faculty.department : 'Computer Science & Engineering'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-user-tie me-1 text-purple" style="color: #6366f1;"></i> Designation</div>
                        <div class="info-value-fac">
                            <span class="badge bg-primary px-3 py-1 rounded-pill">
                                ${not empty faculty.designation ? faculty.designation : 'Professor'}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="info-label-fac"><i class="fa-solid fa-graduation-cap me-1 text-purple" style="color: #6366f1;"></i> Academic Qualification</div>
                        <div class="info-value-fac">${not empty faculty.qualification ? faculty.qualification : 'Ph.D. in Computer Science (MIT), M.Tech (Distinction)'}</div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="info-label-fac"><i class="fa-solid fa-microchip me-1 text-purple" style="color: #6366f1;"></i> Research / Specialization</div>
                        <div class="info-value-fac">${not empty faculty.specialization ? faculty.specialization : 'Cloud Architecture, Distributed Systems, Java Enterprise & AI'}</div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-timeline me-1 text-purple" style="color: #6366f1;"></i> Total Experience</div>
                        <div class="info-value-fac">${not empty faculty.experience ? faculty.experience : '12+ Years Teaching & Research'}</div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-calendar-plus me-1 text-purple" style="color: #6366f1;"></i> University Joining Date</div>
                        <div class="info-value-fac">${not empty faculty.joiningDate ? faculty.joiningDate : '2018-07-01'}</div>
                    </div>
                    <div class="col-12">
                        <div class="info-label-fac"><i class="fa-solid fa-quote-left me-1 text-purple" style="color: #6366f1;"></i> Faculty Bio & Research Overview</div>
                        <div class="info-value-fac fw-normal text-muted">${not empty faculty.bio ? faculty.bio : 'Senior Professor focusing on Distributed Systems, Cloud Computing Infrastructure, and enterprise Java development.'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 3: LMS Information -->
            <div class="info-card-fac">
                <div class="section-title-fac">
                    <div class="bg-warning bg-opacity-10 text-warning rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-chalkboard-user text-warning"></i>
                    </div>
                    <span>3. LMS Information</span>
                </div>

                <!-- Metric Highlights -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Courses Created</div>
                            <div class="fs-4 fw-bold text-primary">${totalCourses} Courses</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Total Students</div>
                            <div class="fs-4 fw-bold text-success">${totalStudents} Students</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Study Materials</div>
                            <div class="fs-4 fw-bold text-warning">${totalMaterials} Documents</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="text-muted small fw-semibold">Submissions Evaluated</div>
                            <div class="fs-4 fw-bold text-info">${totalSubmissions} Attempts</div>
                        </div>
                    </div>
                </div>

                <!-- Courses Created & Assigned Table -->
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h6 class="fw-bold text-navy mb-0"><i class="fa-solid fa-layer-group me-2 text-primary"></i> Courses Created & Assigned</h6>
                    <a href="/faculty/courses/create" class="btn btn-sm btn-primary rounded-pill px-3 py-1">
                        <i class="fa-solid fa-plus me-1"></i> New Course
                    </a>
                </div>
                <c:choose>
                    <c:when test="${not empty courses}">
                        <div class="table-responsive mb-4">
                            <table class="table table-hover align-middle border mb-0">
                                <thead class="table-light">
                                    <tr class="fs-8 text-uppercase text-muted">
                                        <th>Course Title</th>
                                        <th>Category</th>
                                        <th>Level</th>
                                        <th>Status</th>
                                        <th class="text-end">Builder</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${courses}">
                                        <tr>
                                            <td>
                                                <div class="fw-bold text-dark">${c.title}</div>
                                                <span class="small text-muted">${c.duration}</span>
                                            </td>
                                            <td><span class="badge bg-primary bg-opacity-10 text-primary">${c.category != null ? c.category.name : 'Computer Science'}</span></td>
                                            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">${c.level}</span></td>
                                            <td>
                                                <span class="badge ${c.published ? 'bg-success' : 'bg-warning'} bg-opacity-25 ${c.published ? 'text-success' : 'text-warning'} border ${c.published ? 'border-success' : 'border-warning'} rounded-pill px-2 py-1">
                                                    ${c.published ? 'Published' : 'Draft'}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <a href="/faculty/courses/${c.id}/builder" class="btn btn-sm btn-outline-primary rounded-pill px-3 py-1">
                                                    <i class="fa-solid fa-pen-ruler me-1"></i> Studio
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
                            No courses created yet. <a href="/faculty/courses/create" class="fw-bold text-primary">Create your first course</a>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Live Classrooms & Quizzes -->
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <div class="p-3 bg-light rounded-3 border h-100">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h6 class="fw-bold text-navy mb-0"><i class="fa-solid fa-video me-2 text-danger"></i> Live Classrooms</h6>
                                <a href="/faculty/live" class="small fw-bold text-primary">Manage</a>
                            </div>
                            <div class="small text-muted mb-2">Total live class sessions scheduled: <strong>${liveClasses.size()}</strong></div>
                            <c:forEach var="lc" items="${liveClasses}" varStatus="status">
                                <c:if test="${status.index < 2}">
                                    <div class="border bg-white rounded-2 p-2 mb-2">
                                        <div class="fw-bold small text-dark">${lc.title}</div>
                                        <span class="badge bg-danger bg-opacity-10 text-danger fs-8">${lc.status}</span>
                                        <span class="small text-muted ms-2">${lc.scheduledAt}</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 bg-light rounded-3 border h-100">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h6 class="fw-bold text-navy mb-0"><i class="fa-solid fa-spell-check me-2 text-warning"></i> Quizzes Created</h6>
                                <a href="/faculty/quizzes" class="small fw-bold text-primary">Manage</a>
                            </div>
                            <div class="small text-muted mb-2">Total interactive quizzes created: <strong>${quizzes.size()}</strong></div>
                            <c:forEach var="qz" items="${quizzes}" varStatus="status">
                                <c:if test="${status.index < 2}">
                                    <div class="border bg-white rounded-2 p-2 mb-2">
                                        <div class="fw-bold small text-dark">${qz.title}</div>
                                        <span class="small text-muted">Pass Mark: ${qz.passingScorePct}% &bull; Time: ${qz.timeLimitMinutes} min</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Student Performance Analytics -->
                <div class="row g-3 pt-2">
                    <div class="col-md-6">
                        <div class="info-label-fac"><i class="fa-solid fa-chart-pie me-1 text-primary"></i> Student Performance</div>
                        <div class="info-value-fac text-success">
                            <i class="fa-solid fa-circle-check me-1"></i> ${passRate}% Batch Pass Rate &bull; Avg Score: ${avgScore}%
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-label-fac"><i class="fa-solid fa-clock-rotate-left me-1 text-primary"></i> Last Login Session</div>
                        <div class="info-value-fac">${not empty faculty.lastLogin ? faculty.lastLogin : 'Active Now'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 4: Account Information -->
            <div class="info-card-fac">
                <div class="section-title-fac">
                    <div class="bg-danger bg-opacity-10 text-danger rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <span>4. Account Information</span>
                </div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-user-shield me-1 text-danger"></i> Email / Username</div>
                        <div class="info-value-fac">${faculty.email}</div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-key me-1 text-danger"></i> Password (Hashed)</div>
                        <div class="info-value-fac text-muted">•••••••• (BCrypt Hashed)</div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-circle-dot me-1 text-danger"></i> Account Status</div>
                        <div>
                            <span class="badge ${faculty.status == 'ACTIVE' ? 'bg-success' : 'bg-warning'} px-3 py-1.5 rounded-pill">
                                ${faculty.status}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="info-label-fac"><i class="fa-solid fa-calendar-check me-1 text-danger"></i> Account Created Date</div>
                        <div class="info-value-fac">${faculty.createdAt}</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- MODAL: Edit Faculty Profile -->
<div class="modal fade" id="editFacultyProfileModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-dark text-white border-0 rounded-top-4 p-3 px-4" style="background: linear-gradient(135deg, #1e1b4b, #312e81) !important;">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-pen me-2"></i> Edit Faculty Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/faculty/profile/update" method="POST">
                <div class="modal-body p-4">
                    <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-user me-2 text-primary"></i> Personal Details</h6>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Full Name *</label>
                            <input type="text" name="name" class="form-control rounded-3" value="${faculty.name}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Mobile Number</label>
                            <input type="text" name="mobile" class="form-control rounded-3" value="${faculty.mobile}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Date of Birth</label>
                            <input type="date" name="dob" class="form-control rounded-3" value="${faculty.dob}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Gender</label>
                            <select name="gender" class="form-select rounded-3">
                                <option value="Male" ${faculty.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${faculty.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${faculty.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Profile Photo URL</label>
                            <input type="text" name="profilePhoto" class="form-control rounded-3" value="${faculty.profilePhoto}" placeholder="https://... or avatar URL">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Address</label>
                            <input type="text" name="address" class="form-control rounded-3" value="${faculty.address}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">City</label>
                            <input type="text" name="city" class="form-control rounded-3" value="${faculty.city}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">State</label>
                            <input type="text" name="state" class="form-control rounded-3" value="${faculty.state}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Country</label>
                            <input type="text" name="country" class="form-control rounded-3" value="${not empty faculty.country ? faculty.country : 'India'}">
                        </div>
                    </div>

                    <h6 class="fw-bold text-navy mb-3"><i class="fa-solid fa-briefcase me-2 text-purple" style="color: #6366f1;"></i> Professional Details</h6>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="${faculty.department}" placeholder="e.g. Computer Science & Engineering">
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
                            <label class="form-label small fw-bold">Academic Qualification</label>
                            <input type="text" name="qualification" class="form-control rounded-3" value="${faculty.qualification}" placeholder="e.g. Ph.D. in Computer Science">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Specialization</label>
                            <input type="text" name="specialization" class="form-control rounded-3" value="${faculty.specialization}" placeholder="e.g. Cloud Computing & AI">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Experience</label>
                            <input type="text" name="experience" class="form-control rounded-3" value="${faculty.experience}" placeholder="e.g. 12+ Years">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Joining Date</label>
                            <input type="date" name="joiningDate" class="form-control rounded-3" value="${faculty.joiningDate}">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Bio / Research Focus</label>
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

<!-- MODAL: Change Faculty Password -->
<div class="modal fade" id="changeFacultyPasswordModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-dark text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-lock me-2 text-warning"></i> Change Password</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/faculty/profile/change-password" method="POST">
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

<jsp:include page="../footer.jsp" />
