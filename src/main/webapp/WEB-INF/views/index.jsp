<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Cloud LMS - Enterprise Academic Portal" />
</jsp:include>

<!-- 1. Hero Section (Clean Light Ice-Blue Institutional Theme) -->
<section id="hero" class="py-5 position-relative overflow-hidden" style="background: linear-gradient(180deg, #dbeafe 0%, #eaf2fb 60%, #ffffff 100%);">
    <div class="container py-lg-4">
        <div class="row align-items-center g-5">
            <div class="col-lg-7">
                <div class="d-inline-flex align-items-center gap-2 px-3 py-1 rounded-pill bg-white border border-primary border-opacity-25 text-primary mb-3 shadow-sm">
                    <span class="badge rounded-pill text-white px-2 py-1" style="background-color: #1d70b8; font-size: 0.75rem;">OFFICIAL PORTAL</span>
                    <span class="small fw-bold" style="color: #0f2b5c;">Institutional Learning & Verified Roll Number Gateway</span>
                </div>
                
                <h1 class="display-4 fw-extrabold tracking-tight mb-3" style="color: #0f2b5c; line-height: 1.15;">
                    Empowering <span style="color: #f59e0b;">Knowledge</span><br>
                    Enabling <span style="color: #1d70b8;">Success</span>
                </h1>
                
                <p class="lead text-muted mb-4 leading-relaxed" style="color: #475569 !important; font-size: 1.1rem;">
                    Enterprise academic learning portal engineered to deliver real-time WebRTC live lectures, structured modular syllabi, downloadable study materials, and automated timed quiz evaluations.
                </p>

                <!-- Search Bar -->
                <div class="card border-0 shadow-sm rounded-4 p-2 bg-white mb-4" style="max-width: 580px; box-shadow: 0 4px 20px rgba(15, 43, 92, 0.08) !important;">
                    <form action="/catalog" method="GET" class="d-flex gap-2">
                        <input type="text" name="search" class="form-control border-0 px-3 shadow-none" placeholder="Search for certified courses, syllabus, and modules..." style="font-size: 0.95rem;">
                        <button type="submit" class="btn btn-portal-primary px-4 fw-bold" style="border-radius: 10px; flex-shrink: 0;">
                            <i class="fa-solid fa-magnifying-glass me-1"></i> Search
                        </button>
                    </form>
                </div>

                <div class="d-flex flex-wrap gap-3">
                    <a href="#courses" class="btn btn-portal-primary btn-lg px-4 py-3 fw-bold"><i class="fa-solid fa-book-bookmark me-2"></i> Explore All Courses</a>
                    <a href="/register" class="btn btn-portal-outline btn-lg px-4 py-3 fw-bold"><i class="fa-solid fa-id-card me-2"></i> Register with Reg. Number</a>
                </div>
            </div>

            <!-- Hero Student Visual Card -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden bg-white p-3" style="box-shadow: 0 10px 30px rgba(15, 43, 92, 0.1) !important; border: 1px solid #e2e8f0;">
                    <div class="position-relative rounded-3 overflow-hidden mb-3 bg-light">
                        <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800&auto=format&fit=crop&q=80" class="img-fluid w-100 object-fit-cover" style="height: 240px; border-radius: 12px;" alt="Students">
                        <div class="position-absolute top-0 start-0 m-3">
                            <span class="badge bg-white text-dark shadow-sm px-3 py-2 rounded-pill fw-bold border">
                                <i class="fa-solid fa-circle-check text-success me-1"></i> Verified Academic Hub
                            </span>
                        </div>
                    </div>
                    
                    <div class="p-2">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-3 py-1">WebRTC 2.0 Live Rooms</span>
                            <span class="text-danger small fw-bold"><i class="fa-solid fa-circle me-1 animate-pulse"></i> LIVE READY</span>
                        </div>
                        <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Interactive Virtual Classrooms</h6>
                        <p class="text-muted small mb-3">Join high-definition broadcast lectures with screen share, live chat, and instant faculty Q&A.</p>
                        
                        <div class="d-flex gap-2">
                            <a href="/login" class="btn btn-sm btn-portal-primary w-100 py-2"><i class="fa-solid fa-arrow-right-to-bracket me-1"></i> Student Login</a>
                            <a href="/login" class="btn btn-sm btn-outline-secondary w-100 py-2"><i class="fa-solid fa-chalkboard-user me-1"></i> Faculty Portal</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 2. Announcement Ribbon Strip (Continuous Running Infinite Marquee - No Scrollbar) -->
<div class="announcement-ribbon py-2 bg-white">
    <div class="container d-flex align-items-center gap-3">
        <div class="ribbon-label rounded-3 shadow-sm flex-shrink-0">
            <i class="fa-solid fa-bullhorn me-2"></i> Announcement
        </div>
        
        <div class="marquee-wrapper">
            <div class="marquee-content">
                <!-- Track Part 1 -->
                <div class="d-inline-flex align-items-center gap-5 pe-5">
                    <c:choose>
                        <c:when test="${not empty announcements}">
                            <c:forEach var="ann" items="${announcements}">
                                <div class="d-inline-flex align-items-center gap-2">
                                    <span class="badge-new">New</span>
                                    <span class="text-dark small fw-semibold" style="color: #1e293b;">${ann.title}: <span class="text-muted fw-normal">${ann.content}</span></span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="d-inline-flex align-items-center gap-2">
                                <span class="badge-new">New</span>
                                <span class="text-dark small fw-semibold">Academic enrollment open for verified student registration numbers 2026-2027.</span>
                            </div>
                            <div class="d-inline-flex align-items-center gap-2">
                                <span class="badge-new">New</span>
                                <span class="text-dark small fw-semibold">Java Programming & Spring Boot Development live classrooms scheduled.</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Track Part 2 (Duplicated for Continuous Seamless Infinite Loop) -->
                <div class="d-inline-flex align-items-center gap-5 pe-5">
                    <c:choose>
                        <c:when test="${not empty announcements}">
                            <c:forEach var="ann" items="${announcements}">
                                <div class="d-inline-flex align-items-center gap-2">
                                    <span class="badge-new">New</span>
                                    <span class="text-dark small fw-semibold" style="color: #1e293b;">${ann.title}: <span class="text-muted fw-normal">${ann.content}</span></span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="d-inline-flex align-items-center gap-2">
                                <span class="badge-new">New</span>
                                <span class="text-dark small fw-semibold">Academic enrollment open for verified student registration numbers 2026-2027.</span>
                            </div>
                            <div class="d-inline-flex align-items-center gap-2">
                                <span class="badge-new">New</span>
                                <span class="text-dark small fw-semibold">Java Programming & Spring Boot Development live classrooms scheduled.</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 3. Key Performance Metrics Banner -->
<section id="stats" class="py-4 bg-white border-bottom shadow-sm">
    <div class="container">
        <div class="row g-4 text-center">
            <div class="col-6 col-md-3">
                <div class="p-2 border-end">
                    <h3 class="fw-extrabold mb-0" style="color: #1d70b8; font-family: 'Outfit', sans-serif;">${totalCourses}+</h3>
                    <p class="text-muted small mb-0 fw-semibold">Certified Curricula</p>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="p-2 border-end">
                    <h3 class="fw-extrabold mb-0" style="color: #10b981; font-family: 'Outfit', sans-serif;">${totalStudents}+</h3>
                    <p class="text-muted small mb-0 fw-semibold">Verified Students</p>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="p-2 border-end">
                    <h3 class="fw-extrabold mb-0" style="color: #8b5cf6; font-family: 'Outfit', sans-serif;">${totalFaculty}+</h3>
                    <p class="text-muted small mb-0 fw-semibold">Distinguished Faculty</p>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="p-2">
                    <h3 class="fw-extrabold mb-0" style="color: #f59e0b; font-family: 'Outfit', sans-serif;">100%</h3>
                    <p class="text-muted small mb-0 fw-semibold">Cloud High-Availability</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 4. Academic Streams / Categories Section -->
<section id="categories" class="py-5" style="background-color: #f0f5fa;">
    <div class="container py-4">
        <div class="text-center max-w-700 mx-auto mb-5">
            <span class="badge bg-white border border-primary text-primary fw-bold text-uppercase px-3 py-1 mb-2 shadow-sm">Academic Streams</span>
            <h2 class="fw-bold mb-2" style="color: #0f2b5c;">Explore Learning Disciplines</h2>
            <p class="text-muted small">Specialized curriculum pathways engineered from core computer programming to cloud software architecture.</p>
        </div>

        <div class="row g-3">
            <c:forEach var="cat" items="${categories}">
                <div class="col-xl-3 col-lg-4 col-md-6">
                    <div class="card h-100 border-0 rounded-4 p-3 portal-card" style="cursor: pointer;" onclick="filterCategory('${cat.name}')">
                        <div class="d-flex align-items-center gap-3">
                            <div class="text-white rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; background-color: #1d70b8; flex-shrink: 0;">
                                <i class="fa-solid ${cat.icon != null ? cat.icon : 'fa-code'} fs-5"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1" style="color: #0f2b5c;">${cat.name}</h6>
                                <p class="text-muted fs-8 mb-0 line-clamp-2">${cat.description}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- 5. Academic Courses Catalog (All 10 Courses) -->
<section id="courses" class="py-5 bg-white border-top border-bottom">
    <div class="container py-4">
        <div class="d-flex flex-wrap justify-content-between align-items-end mb-4 gap-3">
            <div>
                <span class="badge bg-primary bg-opacity-10 text-primary fw-bold text-uppercase px-3 py-1 mb-2">Curriculum Catalog</span>
                <h2 class="fw-bold mb-1" style="color: #0f2b5c;">Standard Academic Programs (${courses.size()} Courses)</h2>
                <p class="text-muted small mb-0">Browse through all certified courses with modular syllabi, video lectures, PDF notes, and quizzes.</p>
            </div>
            
            <!-- Category Filter Buttons & Live Search -->
            <div class="d-flex flex-wrap align-items-center gap-2">
                <div class="input-group input-group-sm rounded-pill overflow-hidden border bg-light me-1" style="width: 220px;">
                    <span class="input-group-text bg-light border-0 ps-3 text-muted"><i class="fa-solid fa-magnifying-glass"></i></span>
                    <input type="text" id="courseLiveSearch" class="form-control bg-light border-0 shadow-none px-2 small" placeholder="Filter courses..." oninput="filterCourses()">
                </div>
                <button type="button" class="btn btn-sm btn-portal-primary filter-btn active" onclick="setCategoryFilter('ALL')">All Streams</button>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3 filter-btn" onclick="setCategoryFilter('Programming')">Programming</button>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3 filter-btn" onclick="setCategoryFilter('Backend Development')">Backend</button>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3 filter-btn" onclick="setCategoryFilter('Web Development')">Web</button>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3 filter-btn" onclick="setCategoryFilter('Database')">Database</button>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3 filter-btn" onclick="setCategoryFilter('Computer Science')">Computer Science</button>
            </div>
        </div>

        <div class="row g-4" id="coursesGrid">
            <c:forEach var="course" items="${courses}">
                <div class="col-lg-4 col-md-6 course-item" data-category="${course.category != null ? course.category.name : ''}">
                    <div class="card h-100 portal-card overflow-hidden">
                        <div class="position-relative">
                            <img src="${course.thumbnailUrl}" class="card-img-top object-fit-cover" style="height: 190px;" alt="${course.title}">
                            <div class="position-absolute top-0 end-0 m-3 d-flex flex-column align-items-end gap-1">
                                <span class="badge bg-dark bg-opacity-75 text-white px-3 py-1 rounded-pill small">
                                    ${course.level}
                                </span>
                                <c:if test="${course.upcoming}">
                                    <span class="badge bg-warning text-dark fw-bold px-3 py-1 rounded-pill shadow-sm animate-pulse">
                                        <i class="fa-solid fa-sparkles me-1"></i> UPCOMING BATCH
                                    </span>
                                </c:if>
                            </div>
                            <c:if test="${not empty course.category}">
                                <span class="position-absolute bottom-0 start-0 m-3 badge px-3 py-1 rounded-pill text-white" style="background-color: #1d70b8;">
                                    <i class="fa-solid ${course.category.icon} me-1"></i> ${course.category.name}
                                </span>
                            </c:if>
                        </div>
                        <div class="card-body p-4 d-flex flex-column">
                            <div class="d-flex align-items-center gap-2 mb-2 text-muted small">
                                <i class="fa-solid fa-user-tie text-primary"></i>
                                <span class="fw-semibold">${course.instructorName != null ? course.instructorName : course.instructorEmail}</span>
                            </div>
                            <h5 class="card-title fw-bold mb-2" style="color: #0f2b5c;">
                                ${course.title}
                                <c:if test="${course.upcoming}">
                                    <span class="badge bg-warning bg-opacity-25 text-warning-emphasis fs-8 ms-1">Opening Soon</span>
                                </c:if>
                            </h5>
                            <p class="card-text text-muted small mb-3 flex-grow-1 line-clamp-3">
                                ${course.description}
                            </p>
                            <div class="d-flex justify-content-between align-items-center mb-3 small text-muted">
                                <span><i class="fa-regular fa-clock me-1 text-primary"></i> <strong>${course.duration}</strong></span>
                                <c:choose>
                                    <c:when test="${course.upcoming}">
                                        <span class="badge bg-warning bg-opacity-25 text-warning-emphasis fw-bold px-2 py-1"><i class="fa-regular fa-calendar-check me-1"></i> Upcoming</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold px-2 py-1">${course.price}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                <div class="text-muted small">
                                    <i class="fa-regular fa-folder-open me-1 text-primary"></i>
                                    <span>${course.totalLessons} Lessons</span>
                                </div>
                                <c:choose>
                                    <c:when test="${course.upcoming}">
                                        <a href="/courses/${course.id}" class="btn btn-sm btn-warning fw-bold px-3 text-dark shadow-sm">
                                            <i class="fa-solid fa-bullhorn me-1"></i> Upcoming Syllabus <i class="fa-solid fa-chevron-right ms-1"></i>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/courses/${course.id}" class="btn btn-sm btn-portal-primary px-3 fw-bold">
                                            View Syllabus <i class="fa-solid fa-chevron-right ms-1"></i>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- 6. Educational Services & Platform Capabilities -->
<section id="services" class="py-5" style="background-color: #f0f5fa;">
    <div class="container py-4">
        <div class="text-center max-w-700 mx-auto mb-5">
            <span class="badge bg-white border border-primary text-primary fw-bold text-uppercase px-3 py-1 mb-2 shadow-sm">Core Capabilities</span>
            <h2 class="fw-bold mb-2" style="color: #0f2b5c;">Enterprise Educational Services</h2>
            <p class="text-muted small">Built on modern Spring Boot micro-services with zero technical debt and secure role isolation.</p>
        </div>

        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="card portal-card p-4 h-100">
                    <div class="text-white rounded-3 p-3 d-inline-flex mb-3" style="width: 52px; height: 52px; background-color: #1d70b8; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-video fs-4"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color: #0f2b5c;">WebRTC Live Classrooms</h5>
                    <p class="text-muted small mb-0">
                        Low-latency live interactive broadcasting with high-definition video feeds, microphone, desktop screen sharing, and participant chat.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card portal-card p-4 h-100">
                    <div class="text-white rounded-3 p-3 d-inline-flex mb-3" style="width: 52px; height: 52px; background-color: #10b981; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-stopwatch-20 fs-4"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color: #0f2b5c;">Timed Auto-Grading Quizzes</h5>
                    <p class="text-muted small mb-0">
                        Automated online testing engine with live countdown timers, auto-submission on timeout, instant scorecards, and question recap.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card portal-card p-4 h-100">
                    <div class="text-white rounded-3 p-3 d-inline-flex mb-3" style="width: 52px; height: 52px; background-color: #8b5cf6; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-file-pdf fs-4"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color: #0f2b5c;">Syllabus & PDF Note Viewer</h5>
                    <p class="text-muted small mb-0">
                        Modular syllabus player with embedded lesson videos, comprehensive notes, and integrated modal viewers for PDF learning materials.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card portal-card p-4 h-100">
                    <div class="text-dark rounded-3 p-3 d-inline-flex mb-3" style="width: 52px; height: 52px; background-color: #f59e0b; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-id-card fs-4 text-white"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color: #0f2b5c;">Verified Registration Gate</h5>
                    <p class="text-muted small mb-0">
                        Strict MySQL verification of student roll numbers and faculty IDs before account creation is authorized, guaranteeing institutional security.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card portal-card p-4 h-100">
                    <div class="text-white rounded-3 p-3 d-inline-flex mb-3" style="width: 52px; height: 52px; background-color: #ef4444; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-chart-line fs-4"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color: #0f2b5c;">Analytics & Progress Tracking</h5>
                    <p class="text-muted small mb-0">
                        Dynamic module completion percentages, gradebook metrics, telemetry tracking, and personalized performance cards.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="card portal-card p-4 h-100">
                    <div class="text-white rounded-3 p-3 d-inline-flex mb-3" style="width: 52px; height: 52px; background-color: #0f2b5c; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-shield-halved fs-4"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color: #0f2b5c;">Multi-Tier RBAC Guards</h5>
                    <p class="text-muted small mb-0">
                        Spring Security 6 with salted password hashing, isolated Student, Faculty, and Admin portals, and immutable audit trails.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 7. About the Platform & Institutional Mission -->
<section id="about" class="py-5 bg-white border-top border-bottom">
    <div class="container py-4">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <span class="badge bg-primary bg-opacity-10 text-primary fw-bold text-uppercase px-3 py-1 mb-2">Institutional Mission</span>
                <h2 class="fw-bold mb-3" style="color: #0f2b5c;">Next-Generation Academic Infrastructure</h2>
                <p class="text-muted leading-relaxed mb-4">
                    Cloud LMS was designed to streamline higher education delivery. By integrating live WebRTC lectures, modular curricula, automated timed testing, and verifiable institutional roll numbers into one unified portal, educators and students collaborate with zero friction.
                </p>

                <div class="d-flex flex-column gap-3 mb-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; flex-shrink: 0;">
                            <i class="fa-solid fa-check"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Industry-Aligned Technical Curriculum</h6>
                            <p class="text-muted small mb-0">From Core Java, Spring Boot, and Full Stack to Algorithms and QA Testing.</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start gap-3">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; flex-shrink: 0;">
                            <i class="fa-solid fa-check"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Verified Institutional Roll Number Identification</h6>
                            <p class="text-muted small mb-0">Registration roll numbers validate against the database and display prominently across portals.</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start gap-3">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; flex-shrink: 0;">
                            <i class="fa-solid fa-check"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Faculty Broadcast & Gradebook Studio</h6>
                            <p class="text-muted small mb-0">Empowers instructors to manage syllabi, upload PDF notes, host webinars, and review quizzes.</p>
                        </div>
                    </div>
                </div>

                <a href="/register" class="btn btn-portal-primary px-4 py-2 fw-bold"><i class="fa-solid fa-user-plus me-1"></i> Register as Student or Faculty</a>
            </div>

            <div class="col-lg-6">
                <div class="card portal-card p-4 p-lg-5">
                    <h4 class="fw-bold mb-3" style="color: #0f2b5c;"><i class="fa-solid fa-award text-warning me-2"></i> Institutional Standards</h4>
                    <p class="text-muted small mb-4">Our architectural framework complies with strict high-availability and pedagogical standards.</p>
                    
                    <div class="p-3 rounded-3 bg-light mb-3 border">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong class="small" style="color: #0f2b5c;">Course Completion & Progress Tracking</strong>
                            <span class="text-primary fw-bold small">100% Real-Time</span>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar" role="progressbar" style="width: 100%; background-color: #1d70b8;"></div>
                        </div>
                    </div>

                    <div class="p-3 rounded-3 bg-light mb-3 border">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong class="small" style="color: #0f2b5c;">Automated Evaluation Precision</strong>
                            <span class="text-success fw-bold small">Instant Scoring</span>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 100%;"></div>
                        </div>
                    </div>

                    <div class="p-3 rounded-3 bg-light border">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong class="small" style="color: #0f2b5c;">Role-Based Security Integrity</strong>
                            <span class="text-danger fw-bold small">Multi-Tier RBAC</span>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-danger" role="progressbar" style="width: 100%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 8. Institute Official Notice Board -->
<section id="announcements" class="py-5" style="background-color: #f0f5fa;">
    <div class="container py-4">
        <div class="d-flex flex-wrap justify-content-between align-items-end mb-4 gap-2">
            <div>
                <span class="badge bg-white border border-primary text-primary fw-bold text-uppercase px-3 py-1 mb-2 shadow-sm">Notice Board</span>
                <h2 class="fw-bold mb-1" style="color: #0f2b5c;">Official Institute Announcements</h2>
                <p class="text-muted small mb-0">Stay updated with academic notices, semester timetables, and live webinar schedules.</p>
            </div>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty announcements}">
                    <c:forEach var="ann" items="${announcements}">
                        <div class="col-lg-6">
                            <div class="p-4 rounded-4 portal-card border-start border-4 shadow-sm h-100 d-flex flex-column justify-content-between" style="border-left-color: #1d70b8 !important;">
                                <div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h5 class="fw-bold mb-0" style="color: #0f2b5c;">${ann.title}</h5>
                                        <span class="badge bg-secondary bg-opacity-10 text-secondary fs-8">${ann.targetRole}</span>
                                    </div>
                                    <p class="text-muted small mb-3">${ann.content}</p>
                                </div>
                                <div class="d-flex justify-content-between align-items-center pt-2 border-top text-muted fs-8">
                                    <span><i class="fa-solid fa-user-pen me-1 text-primary"></i> ${ann.authorEmail}</span>
                                    <span><i class="fa-regular fa-calendar-check me-1 text-success"></i> Active Notice</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-4">
                        <p class="text-muted">No notices currently posted.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- 9. Direct Contact & Admissions Inquiries Section -->
<section id="contact" class="py-5 bg-white border-top">
    <div class="container py-4">
        <div class="text-center max-w-700 mx-auto mb-5">
            <span class="badge bg-primary bg-opacity-10 text-primary fw-bold text-uppercase px-3 py-1 mb-2">Direct Contact</span>
            <h2 class="fw-bold mb-2" style="color: #0f2b5c;">Get in Touch with Academic Support</h2>
            <p class="text-muted small">Have questions regarding student registration numbers, faculty onboarding, or course syllabi? Reach out directly.</p>
        </div>

        <div class="row g-5">
            <div class="col-lg-5">
                <div class="card portal-card p-4 h-100">
                    <h5 class="fw-bold mb-4" style="color: #0f2b5c;">Contact Information</h5>
                    
                    <div class="d-flex gap-3 mb-4">
                        <div class="text-white rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 46px; height: 46px; background-color: #1d70b8; flex-shrink: 0;">
                            <i class="fa-solid fa-location-dot fs-5"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Campus Location</h6>
                            <p class="text-muted small mb-0"><strong>CLOUD TECH</strong><br>DLF CYBER CITY, Chandaka Industrial Estate, Patia, Bhubaneswar, Odisha 751024</p>
                        </div>
                    </div>

                    <div class="d-flex gap-3 mb-4">
                        <div class="text-white rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 46px; height: 46px; background-color: #10b981; flex-shrink: 0;">
                            <i class="fa-solid fa-phone fs-5"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Admissions Hotline</h6>
                            <p class="text-muted small mb-0">+91 9876543210 (Mon - Fri: 9:00 AM - 6:00 PM EST)</p>
                        </div>
                    </div>

                    <div class="d-flex gap-3 mb-4">
                        <div class="text-white rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 46px; height: 46px; background-color: #8b5cf6; flex-shrink: 0;">
                            <i class="fa-solid fa-envelope fs-5"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1" style="color: #0f2b5c;">Academic Inquiries</h6>
                            <p class="text-muted small mb-0">admissions@lms.edu | support@lms.edu</p>
                        </div>
                    </div>

                    <div class="p-3 rounded-3 bg-light border mt-auto">
                        <div class="d-flex align-items-center gap-2 small fw-semibold" style="color: #0f2b5c;">
                            <i class="fa-solid fa-id-card text-warning"></i> Need a Verified Registration Number?
                        </div>
                        <p class="text-muted fs-8 mb-0 mt-1">Contact your department administrator to receive your authorized registration code.</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="card portal-card p-4 p-md-5">
                    <h5 class="fw-bold mb-3" style="color: #0f2b5c;">Send Us a Direct Inquiry</h5>
                    
                    <c:if test="${not empty contactSuccess}">
                        <div class="alert alert-success alert-dismissible fade show rounded-3 small mb-4" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> ${contactSuccess}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="/contact" method="POST">
                        <input type="hidden" name="source" value="home">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark small">Your Full Name</label>
                                <input type="text" name="name" class="form-control" placeholder="Enter Your Name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark small">Email Address</label>
                                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold text-dark small">Mobile Phone Number</label>
                                <input type="text" name="mobile" class="form-control" placeholder="+91 9876543210" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold text-dark small">Inquiry Message</label>
                                <textarea name="message" class="form-control" rows="5" placeholder="Describe your requirement, course suggestion, or support request..." required></textarea>
                            </div>
                            <div class="col-12 mt-4">
                                <button type="submit" class="btn btn-portal-primary btn-lg w-100 py-3 fw-bold">
                                    <i class="fa-solid fa-paper-plane me-2"></i> Submit Inquiry
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Client-side Category & Live Keyword Filter Script -->
<script>
    let activeCategory = 'ALL';

    function setCategoryFilter(categoryName) {
        activeCategory = categoryName;
        const buttons = document.querySelectorAll('.filter-btn');

        buttons.forEach(btn => {
            const btnText = btn.innerText.trim().toLowerCase();
            const targetText = categoryName.trim().toLowerCase();
            
            if (btnText === targetText || 
               (targetText === 'all' && (btnText === 'all' || btnText === 'all streams')) ||
               (targetText === 'backend development' && btnText === 'backend') ||
               (targetText === 'web development' && btnText === 'web')) {
                btn.classList.add('btn-portal-primary', 'active');
                btn.classList.remove('btn-outline-secondary');
            } else {
                btn.classList.remove('btn-portal-primary', 'active');
                btn.classList.add('btn-outline-secondary');
            }
        });

        filterCourses();

        const target = document.getElementById('courses');
        if (target && categoryName !== 'ALL') {
            target.scrollIntoView({ behavior: 'smooth' });
        }
    }

    function filterCourses() {
        const query = (document.getElementById('courseLiveSearch') ? document.getElementById('courseLiveSearch').value : '').toLowerCase().trim();
        const items = document.querySelectorAll('.course-item');

        items.forEach(item => {
            const cat = (item.getAttribute('data-category') || '').toLowerCase();
            const cardText = item.innerText.toLowerCase();

            const matchesCategory = (activeCategory === 'ALL' || cat.includes(activeCategory.toLowerCase()));
            const matchesQuery = (!query || cardText.includes(query));

            if (matchesCategory && matchesQuery) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });
    }

    // Keep backwards compatibility for any inline onclick="filterCategory(...)"
    function filterCategory(categoryName) {
        setCategoryFilter(categoryName);
    }
</script>

<!-- Upcoming Course Announcement Popup Ad Modal -->
<c:if test="${not empty upcomingCourse}">
<div class="modal fade" id="upcomingCourseModal" tabindex="-1" aria-labelledby="upcomingCourseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 rounded-4 shadow-2xl overflow-hidden" style="box-shadow: 0 25px 60px rgba(15, 43, 92, 0.35) !important;">
            <!-- Modal Header Banner -->
            <div class="position-relative p-4 text-white" style="background: linear-gradient(135deg, #0f2b5c 0%, #1d70b8 60%, #2563eb 100%);">
                <div class="d-flex justify-content-between align-items-start">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge rounded-pill px-3 py-2 text-dark fw-extrabold shadow-sm animate-pulse" style="background-color: #f59e0b; font-size: 0.8rem; letter-spacing: 0.5px;">
                            <i class="fa-solid fa-sparkles me-1"></i> ADMISSION ANNOUNCEMENT
                        </span>
                        <span class="badge bg-white bg-opacity-20 text-white rounded-pill px-3 py-2 small fw-semibold">
                            Upcoming Batch 2026-27
                        </span>
                    </div>
                    <button type="button" class="btn-close btn-close-white shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <h3 class="fw-extrabold mt-3 mb-1 text-white tracking-tight" style="font-family: 'Outfit', sans-serif;">
                    ${upcomingCourse.title}
                </h3>
                <p class="text-white text-opacity-80 small mb-0">
                    Flagship Certified Masterclass • Comprehensive Modular Curriculum
                </p>
            </div>

            <!-- Modal Body -->
            <div class="modal-body p-4 p-md-5 bg-white">
                <div class="row g-4 align-items-center">
                    <div class="col-md-5 text-center">
                        <div class="position-relative rounded-4 overflow-hidden shadow-sm border mb-3">
                            <img src="${upcomingCourse.thumbnailUrl}" class="img-fluid w-100 object-fit-cover" style="height: 200px;" alt="${upcomingCourse.title}">
                            <div class="position-absolute top-0 end-0 m-2">
                                <span class="badge bg-dark bg-opacity-75 text-white rounded-pill px-2 py-1 small">${upcomingCourse.level}</span>
                            </div>
                            <div class="position-absolute bottom-0 start-0 m-2">
                                <span class="badge bg-warning text-dark fw-bold rounded-pill px-2 py-1 small">
                                    <i class="fa-solid fa-clock me-1"></i> ${upcomingCourse.duration}
                                </span>
                            </div>
                        </div>
                        <div class="p-2 rounded-3 bg-light border text-start small">
                            <div class="d-flex align-items-center gap-2 text-muted mb-1">
                                <i class="fa-solid fa-chalkboard-user text-primary"></i>
                                <span class="fw-bold" style="color: #0f2b5c;">${upcomingCourse.instructorName != null ? upcomingCourse.instructorName : 'Senior Faculty'}</span>
                            </div>
                            <div class="d-flex align-items-center gap-2 text-muted">
                                <i class="fa-regular fa-folder-open text-primary"></i>
                                <span>${upcomingCourse.totalLessons} Structured Lessons</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-7">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <span class="badge bg-danger bg-opacity-10 text-danger fw-bold px-2 py-1 small">
                                <i class="fa-solid fa-lock me-1"></i> ENROLLMENT OPENING SOON
                            </span>
                        </div>
                        <h5 class="fw-bold mb-2" style="color: #0f2b5c;">What You'll Master in this Program</h5>
                        <p class="text-muted small mb-3 leading-relaxed">
                            ${upcomingCourse.description}
                        </p>

                        <!-- Key Highlights Grid -->
                        <div class="row g-2 mb-4 small">
                            <div class="col-12 col-sm-6">
                                <div class="d-flex align-items-start gap-2 p-2 rounded-2 bg-light border">
                                    <i class="fa-solid fa-code text-primary mt-1"></i>
                                    <div>
                                        <strong class="d-block text-dark">Core & Adv Java</strong>
                                        <span class="text-muted fs-8">OOP, Collections, Streams</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="d-flex align-items-start gap-2 p-2 rounded-2 bg-light border">
                                    <i class="fa-solid fa-leaf text-success mt-1"></i>
                                    <div>
                                        <strong class="d-block text-dark">Spring Boot 3</strong>
                                        <span class="text-muted fs-8">REST APIs & Microservices</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="d-flex align-items-start gap-2 p-2 rounded-2 bg-light border">
                                    <i class="fa-solid fa-database text-warning mt-1"></i>
                                    <div>
                                        <strong class="d-block text-dark">MySQL & JPA</strong>
                                        <span class="text-muted fs-8">Hibernate & Transactions</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="d-flex align-items-start gap-2 p-2 rounded-2 bg-light border">
                                    <i class="fa-solid fa-award text-danger mt-1"></i>
                                    <div>
                                        <strong class="d-block text-dark">LMS Final Project</strong>
                                        <span class="text-muted fs-8">Verified Certification</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Notification Banner -->
                        <div class="alert alert-warning py-2 px-3 rounded-3 small mb-0 d-flex align-items-center gap-2 border-0" style="background-color: #fef3c7; color: #92400e;">
                            <i class="fa-solid fa-bullhorn fs-5 text-warning flex-shrink-0"></i>
                            <div>
                                Direct enrollment will unlock soon! Keep your institutional roll number ready.
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer p-3 bg-light border-top d-flex justify-content-between align-items-center">
                <button type="button" class="btn btn-outline-secondary px-4 py-2 rounded-pill fw-semibold" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark me-1"></i> Remind Me Later
                </button>
                <a href="/courses/${upcomingCourse.id}" class="btn btn-warning text-dark px-4 py-2 rounded-pill fw-bold shadow-sm">
                    <i class="fa-solid fa-book-open-reader me-1"></i> View Full 16-Week Syllabus <i class="fa-solid fa-chevron-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>
</div>
</c:if>

<script>
    (function() {
        function showUpcomingModal() {
            var modalEl = document.getElementById('upcomingCourseModal');
            if (modalEl && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
                var myModal = bootstrap.Modal.getOrCreateInstance(modalEl, {
                    backdrop: true,
                    keyboard: true
                });
                myModal.show();
            } else if (modalEl) {
                setTimeout(showUpcomingModal, 300);
            }
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', function() {
                setTimeout(showUpcomingModal, 400);
            });
        } else {
            setTimeout(showUpcomingModal, 400);
        }
    })();
</script>

<jsp:include page="footer.jsp" />