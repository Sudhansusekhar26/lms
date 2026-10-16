<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Admin Profile - Cloud LMS" />
</jsp:include>

<style>
    :root {
        --adm-navy: #0f2b5c;
        --adm-danger: #dc2626;
        --adm-blue: #1d70b8;
        --adm-card-bg: #ffffff;
        --adm-border: #e2e8f0;
    }
    .profile-hero-admin {
        background: linear-gradient(135deg, #09090b 0%, #18181b 40%, #0f2b5c 100%);
        border-radius: 20px;
        padding: 2.5rem 2rem;
        color: white;
        position: relative;
        overflow: hidden;
        margin-bottom: 2rem;
        box-shadow: 0 10px 30px rgba(9, 9, 11, 0.3);
    }
    .profile-hero-admin::before {
        content: '';
        position: absolute;
        width: 320px;
        height: 320px;
        background: radial-gradient(circle, rgba(220, 38, 38, 0.25) 0%, transparent 70%);
        top: -100px;
        right: -50px;
        border-radius: 50%;
    }
    .profile-avatar-box-adm {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        background: white;
        padding: 4px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }
    .profile-avatar-img-adm {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }
    .info-card-adm {
        background: white;
        border: 1px solid var(--adm-border);
        border-radius: 16px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 4px 16px rgba(15, 43, 92, 0.04);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .info-card-adm:hover {
        box-shadow: 0 8px 24px rgba(15, 43, 92, 0.08);
    }
    .section-title-adm {
        font-family: 'Outfit', sans-serif;
        font-weight: 700;
        font-size: 1.15rem;
        color: var(--adm-navy);
        display: flex;
        align-items: center;
        gap: 0.6rem;
        padding-bottom: 0.85rem;
        border-bottom: 2px solid #f1f5f9;
        margin-bottom: 1.25rem;
    }
    .info-label-adm {
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #64748b;
        margin-bottom: 0.2rem;
    }
    .info-value-adm {
        font-size: 0.95rem;
        font-weight: 700;
        color: #1e293b;
        word-break: break-word;
    }
    .stat-pill-adm {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.18);
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
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="profile" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">

            <!-- Hero Admin Profile Banner -->
            <div class="profile-hero-admin">
                <div class="row align-items-center g-4">
                    <div class="col-auto">
                        <div class="profile-avatar-box-adm">
                            <c:choose>
                                <c:when test="${not empty admin.profilePhoto}">
                                    <img src="${admin.profilePhoto}" alt="${admin.name}" class="profile-avatar-img-adm">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-danger text-white d-flex align-items-center justify-content-center w-100 h-100 fs-1 fw-bold">
                                        <i class="fa-solid fa-user-shield"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col">
                        <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                            <h2 class="h3 fw-bold mb-0 text-white">${admin.name}</h2>
                            <span class="badge bg-danger bg-opacity-75 text-white border border-light border-opacity-25 px-2.5 py-1 rounded-pill small">
                                <i class="fa-solid fa-shield-halved me-1"></i> ROLE_ADMIN
                            </span>
                            <span class="badge bg-success bg-opacity-75 text-white border border-light border-opacity-25 px-2.5 py-1 rounded-pill small">
                                <i class="fa-solid fa-circle-check me-1"></i> ${admin.status}
                            </span>
                        </div>
                        <p class="mb-2 text-white-50 fs-6">
                            <i class="fa-solid fa-briefcase me-1"></i> ${not empty admin.designation ? admin.designation : 'System Administrator'} 
                            &bull; <i class="fa-solid fa-building-columns me-1 ms-1"></i> ${not empty admin.department ? admin.department : 'Central IT & LMS Infrastructure'}
                        </p>
                        <p class="mb-0 text-white-50 small">
                            <i class="fa-solid fa-id-badge me-1"></i> Admin ID: <strong>${not empty admin.registrationNumber ? admin.registrationNumber : 'ADM-'}${empty admin.registrationNumber ? admin.id : ''}</strong>
                            &bull; <i class="fa-solid fa-envelope me-1 ms-2"></i> ${admin.email}
                        </p>
                    </div>
                    <div class="col-12 col-md-auto d-flex flex-md-column gap-2">
                        <button type="button" class="btn btn-light btn-sm fw-bold px-3 py-2 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#editAdminProfileModal">
                            <i class="fa-solid fa-user-pen me-1 text-primary"></i> Edit Profile
                        </button>
                        <button type="button" class="btn btn-outline-light btn-sm fw-bold px-3 py-2 rounded-pill" data-bs-toggle="modal" data-bs-target="#changeAdminPasswordModal">
                            <i class="fa-solid fa-key me-1"></i> Change Password
                        </button>
                    </div>
                </div>

                <!-- Live System Statistics -->
                <div class="row g-3 mt-3 pt-3 border-top border-light border-opacity-20">
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-adm">
                            <div class="fs-4 fw-extrabold text-white">${totalStudents}</div>
                            <div class="small text-white-50 fs-8">Students</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-adm">
                            <div class="fs-4 fw-extrabold text-white">${totalFaculty}</div>
                            <div class="small text-white-50 fs-8">Faculty</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-adm">
                            <div class="fs-4 fw-extrabold text-warning">${totalCourses}</div>
                            <div class="small text-white-50 fs-8">Courses</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-adm">
                            <div class="fs-4 fw-extrabold text-info text-light">${totalEnrollments}</div>
                            <div class="small text-white-50 fs-8">Enrollments</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-adm">
                            <div class="fs-4 fw-extrabold text-white">${totalQuizzes}</div>
                            <div class="small text-white-50 fs-8">Quizzes</div>
                        </div>
                    </div>
                    <div class="col-6 col-sm-4 col-md-2">
                        <div class="stat-pill-adm">
                            <div class="fs-4 fw-extrabold text-success text-light">${totalLiveClasses}</div>
                            <div class="small text-white-50 fs-8">Live Classes</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- SECTION 1: Personal Information -->
            <div class="info-card-adm">
                <div class="section-title-adm">
                    <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <span>1. Personal Information</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-id-card-clip me-1 text-primary"></i> Admin ID</div>
                        <div class="info-value-adm">${not empty admin.registrationNumber ? admin.registrationNumber : 'ADM-'}${empty admin.registrationNumber ? admin.id : ''}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-signature me-1 text-primary"></i> Full Name</div>
                        <div class="info-value-adm">${admin.name}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-image me-1 text-primary"></i> Profile Photo</div>
                        <div class="info-value-adm">${not empty admin.profilePhoto ? 'Custom Photo Set' : 'Default Admin Avatar'}</div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-envelope me-1 text-primary"></i> Email Address</div>
                        <div class="info-value-adm text-primary">${admin.email}</div>
                    </div>
                    <div class="col-md-6 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-phone me-1 text-primary"></i> Mobile Number</div>
                        <div class="info-value-adm">${not empty admin.mobile ? admin.mobile : '+91 98765 00001'}</div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="info-label-adm"><i class="fa-solid fa-location-dot me-1 text-primary"></i> Address</div>
                        <div class="info-value-adm">${not empty admin.address ? admin.address : 'Administrative Block, Floor 3, Innovation Campus'}</div>
                    </div>
                    <div class="col-md-2 col-sm-4">
                        <div class="info-label-adm"><i class="fa-solid fa-city me-1 text-primary"></i> City</div>
                        <div class="info-value-adm">${not empty admin.city ? admin.city : 'Bhubaneswar'}</div>
                    </div>
                    <div class="col-md-2 col-sm-4">
                        <div class="info-label-adm"><i class="fa-solid fa-map-location-dot me-1 text-primary"></i> State</div>
                        <div class="info-value-adm">${not empty admin.state ? admin.state : 'Odisha'}</div>
                    </div>
                    <div class="col-md-2 col-sm-4">
                        <div class="info-label-adm"><i class="fa-solid fa-earth-americas me-1 text-primary"></i> Country</div>
                        <div class="info-value-adm">${not empty admin.country ? admin.country : 'India'}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 2: Account Information -->
            <div class="info-card-adm">
                <div class="section-title-adm">
                    <div class="bg-danger bg-opacity-10 text-danger rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <span>2. Account Information</span>
                </div>
                <div class="row g-3 align-items-center">
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-user-shield me-1 text-danger"></i> Username / Email</div>
                        <div class="info-value-adm">${admin.email}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-key me-1 text-danger"></i> Password (Hashed)</div>
                        <div class="info-value-adm text-muted">•••••••• (BCrypt Hashed)</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-shield me-1 text-danger"></i> Role</div>
                        <div>
                            <span class="badge bg-danger px-3 py-1.5 rounded-pill">
                                <i class="fa-solid fa-lock me-1"></i> ADMIN (ROLE_ADMIN)
                            </span>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-circle-dot me-1 text-danger"></i> Account Status</div>
                        <div>
                            <span class="badge bg-success px-3 py-1.5 rounded-pill">
                                ${admin.status}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-clock-rotate-left me-1 text-danger"></i> Last Login</div>
                        <div class="info-value-adm">${not empty admin.lastLogin ? admin.lastLogin : 'Active Now'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-calendar-check me-1 text-danger"></i> Account Created Date</div>
                        <div class="info-value-adm">${admin.createdAt}</div>
                    </div>
                </div>
            </div>

            <!-- SECTION 3: Professional Information -->
            <div class="info-card-adm">
                <div class="section-title-adm">
                    <div class="bg-success bg-opacity-10 text-success rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                        <i class="fa-solid fa-briefcase"></i>
                    </div>
                    <span>3. Professional Information</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-user-tie me-1 text-success"></i> Designation</div>
                        <div class="info-value-adm">
                            <span class="badge bg-primary px-3 py-1 rounded-pill">
                                ${not empty admin.designation ? admin.designation : 'System Administrator'}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-building-columns me-1 text-success"></i> Department</div>
                        <div class="info-value-adm">${not empty admin.department ? admin.department : 'Central IT & LMS Infrastructure'}</div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="info-label-adm"><i class="fa-solid fa-calendar-plus me-1 text-success"></i> Joining Date</div>
                        <div class="info-value-adm">${not empty admin.joiningDate ? admin.joiningDate : '2020-01-10'}</div>
                    </div>
                    <div class="col-12">
                        <div class="info-label-adm"><i class="fa-solid fa-quote-left me-1 text-success"></i> Administrative Bio & Responsibilities</div>
                        <div class="info-value-adm fw-normal text-muted">${not empty admin.bio ? admin.bio : 'Chief Systems Administrator overseeing LMS curriculum, server infrastructure, data integrity, and institutional security governance.'}</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- MODAL: Edit Admin Profile -->
<div class="modal fade" id="editAdminProfileModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-dark text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-pen me-2"></i> Edit Admin Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/profile/update" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Full Name *</label>
                            <input type="text" name="name" class="form-control rounded-3" value="${admin.name}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Mobile Number</label>
                            <input type="text" name="mobile" class="form-control rounded-3" value="${admin.mobile}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Designation</label>
                            <input type="text" name="designation" class="form-control rounded-3" value="${admin.designation}" placeholder="System Administrator">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <input type="text" name="department" class="form-control rounded-3" value="${admin.department}" placeholder="Central IT & LMS Infrastructure">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Address</label>
                            <input type="text" name="address" class="form-control rounded-3" value="${admin.address}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">City</label>
                            <input type="text" name="city" class="form-control rounded-3" value="${admin.city}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">State</label>
                            <input type="text" name="state" class="form-control rounded-3" value="${admin.state}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Country</label>
                            <input type="text" name="country" class="form-control rounded-3" value="${not empty admin.country ? admin.country : 'India'}">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Profile Photo URL</label>
                            <input type="text" name="profilePhoto" class="form-control rounded-3" value="${admin.profilePhoto}" placeholder="https://... or avatar image URL">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Administrative Bio</label>
                            <textarea name="bio" class="form-control rounded-3" rows="3">${admin.bio}</textarea>
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

<!-- MODAL: Change Admin Password -->
<div class="modal fade" id="changeAdminPasswordModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-dark text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-lock me-2 text-danger"></i> Change Admin Password</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/profile/change-password" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Current Password *</label>
                        <input type="password" name="currentPassword" class="form-control rounded-3" required placeholder="Enter current admin password">
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
