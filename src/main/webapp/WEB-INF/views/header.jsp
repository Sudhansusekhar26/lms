<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'Cloud LMS - Enterprise Learning Platform'}</title>
    <!-- Bootstrap 5.3 CSS & JS Bundle -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- FontAwesome 6 Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts: Plus Jakarta Sans & Outfit for Clean Institutional Portal Feel -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --portal-primary: #1d70b8;
            --portal-primary-hover: #155a96;
            --portal-navy: #0f2b5c;
            --portal-navy-dark: #0a1c3d;
            --portal-accent-gold: #f59e0b;
            --portal-bg-light: #f0f5fa;
            --portal-bg-ice: #dbeafe;
            --portal-card-bg: #ffffff;
            --portal-text-dark: #1e293b;
            --portal-text-muted: #64748b;
            --portal-border: #e2e8f0;
        }
        
        html {
            scroll-behavior: smooth;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f0f5fa;
            color: var(--portal-text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
        }

        h1, h2, h3, h4, h5, h6, .brand-font {
            font-family: 'Outfit', 'Plus Jakarta Sans', sans-serif;
            color: var(--portal-navy);
            letter-spacing: -0.3px;
        }

        /* Main Navigation Bar (Clean White Style) */
        .navbar-custom {
            background-color: #ffffff;
            border-bottom: 1px solid var(--portal-border);
            box-shadow: 0 2px 12px rgba(15, 43, 92, 0.04);
            padding-top: 0.75rem;
            padding-bottom: 0.75rem;
        }
        .navbar-brand {
            font-family: 'Outfit', sans-serif;
            font-weight: 800;
            font-size: 1.45rem;
            letter-spacing: -0.5px;
            color: var(--portal-navy) !important;
        }
        .brand-gradient {
            color: var(--portal-primary);
        }
        .nav-link {
            color: #1e293b !important;
            font-weight: 600;
            font-size: 0.95rem;
            padding: 0.5rem 0.95rem !important;
            transition: all 0.2s ease;
            border-radius: 6px;
        }
        .nav-link:hover, .nav-link.active {
            color: var(--portal-primary) !important;
            background-color: #f1f5f9;
        }

        /* Portal Action Buttons */
        .btn-portal-primary {
            background-color: var(--portal-primary);
            color: #ffffff !important;
            font-weight: 700;
            border: none;
            padding: 0.5rem 1.4rem;
            border-radius: 50px;
            box-shadow: 0 4px 10px rgba(29, 112, 184, 0.25);
            transition: all 0.2s;
        }
        .btn-portal-primary:hover {
            background-color: var(--portal-primary-hover);
            transform: translateY(-1px);
            box-shadow: 0 6px 14px rgba(29, 112, 184, 0.35);
        }

        .btn-portal-outline {
            border: 1.5px solid var(--portal-primary);
            color: var(--portal-primary) !important;
            font-weight: 700;
            background-color: transparent;
            padding: 0.45rem 1.3rem;
            border-radius: 50px;
            transition: all 0.2s;
        }
        .btn-portal-outline:hover {
            background-color: var(--portal-primary);
            color: #ffffff !important;
            transform: translateY(-1px);
        }

        .btn-brand {
            background-color: var(--portal-primary);
            color: white;
            font-weight: 600;
            border: none;
            padding: 0.55rem 1.3rem;
            border-radius: 50px;
            transition: all 0.2s;
        }
        .btn-brand:hover {
            background-color: var(--portal-primary-hover);
            color: white;
        }

        /* Continuous Running Announcement Marquee */
        .announcement-ribbon {
            background-color: #ffffff;
            border-top: 1px solid var(--portal-border);
            border-bottom: 2px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            overflow: hidden;
        }
        .ribbon-label {
            background-color: var(--portal-primary);
            color: #ffffff;
            font-weight: 800;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 0.6rem 1.2rem;
            display: inline-flex;
            align-items: center;
            position: relative;
            z-index: 2;
        }
        .badge-new {
            background-color: #ef4444;
            color: #ffffff;
            font-size: 0.7rem;
            font-weight: 700;
            padding: 0.2rem 0.5rem;
            border-radius: 50px;
        }
        .marquee-wrapper {
            overflow: hidden;
            white-space: nowrap;
            position: relative;
            flex-grow: 1;
        }
        .marquee-content {
            display: inline-flex;
            align-items: center;
            white-space: nowrap;
            animation: marqueeScroll 30s linear infinite;
        }
        .marquee-content:hover,
        .marquee-wrapper:hover .marquee-content {
            animation-play-state: paused;
            cursor: pointer;
        }
        @keyframes marqueeScroll {
            0% {
                transform: translateX(0%);
            }
            100% {
                transform: translateX(-50%);
            }
        }

        /* Card Shadows & Borders */
        .portal-card {
            background-color: #ffffff;
            border: 1px solid var(--portal-border);
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(15, 43, 92, 0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .portal-card:hover {
            box-shadow: 0 8px 24px rgba(15, 43, 92, 0.09);
        }
    </style>
</head>
<body>

<!-- Main Clean White Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="/">
            <div class="bg-primary text-white rounded-3 p-2 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; background-color: var(--portal-primary) !important;">
                <i class="fa-solid fa-graduation-cap fs-5"></i>
            </div>
            <div>
                <span class="fw-extrabold" style="color: var(--portal-navy);">Cloud<span style="color: var(--portal-primary);">LMS</span></span>
            </div>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <i class="fa-solid fa-bars fs-4 text-dark"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4 gap-lg-1">
                <li class="nav-item"><a class="nav-link" href="/"><i class="fa-solid fa-house me-1 text-primary"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/#courses"><i class="fa-solid fa-book-open me-1 text-primary"></i> Courses</a></li>
                <li class="nav-item"><a class="nav-link" href="/#services"><i class="fa-solid fa-layer-group me-1 text-primary"></i> Services</a></li>
                <li class="nav-item"><a class="nav-link" href="/#about"><i class="fa-solid fa-circle-info me-1 text-primary"></i> About</a></li>
                <li class="nav-item"><a class="nav-link" href="/contact"><i class="fa-solid fa-envelope me-1 text-primary"></i> Contact Us</a></li>
                <li class="nav-item"><a class="nav-link" href="/verify-certificate"><i class="fa-solid fa-award me-1 text-warning"></i> Verify Certificate</a></li>
            </ul>

            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.email}">
                        <div class="dropdown">
                            <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center gap-2 rounded-pill px-3 py-1 fw-semibold" type="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-circle-user"></i>
                                <span>${sessionScope.userName != null ? sessionScope.userName : sessionScope.email}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2 p-2">
                                <li><h6 class="dropdown-header text-uppercase fs-8 text-muted">Session Account</h6></li>
                                <li><span class="dropdown-item-text fw-bold text-dark">${sessionScope.email}</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item fw-semibold" href="/dashboard"><i class="fa-solid fa-gauge-high me-2 text-primary"></i> My Portal Dashboard</a></li>
                                <li><a class="dropdown-item fw-semibold" href="/profile"><i class="fa-solid fa-id-card me-2 text-info"></i> My Profile</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger fw-semibold" href="/logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Sign Out</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="/login" class="btn btn-portal-primary"><i class="fa-solid fa-arrow-right-to-bracket me-1"></i> Login</a>
                        <a href="/register" class="btn btn-portal-outline"><i class="fa-solid fa-user-plus me-1"></i> Apply / Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow-1">