<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Signup - Cloud LMS" />
</jsp:include>

<style>
    /* Animated Gradient Background matching Home Theme */
    .register-viewport {
        min-height: calc(100vh - 65px);
        background: linear-gradient(-45deg, #dbeafe, #e0f2fe, #eaf2fb, #f0f9ff, #f0f5fa);
        background-size: 400% 400%;
        animation: gradientBG 15s ease infinite;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2.5rem 1rem;
        position: relative;
        overflow: hidden;
    }

    @keyframes gradientBG {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* Floating Animated Geometric & Academic Glass Elements */
    .floating-anim-item {
        position: absolute;
        pointer-events: none;
        z-index: 1;
        opacity: 0.85;
    }

    .anim-orb-1 {
        width: 340px;
        height: 340px;
        background: radial-gradient(circle, rgba(29, 112, 184, 0.18) 0%, rgba(29, 112, 184, 0.02) 70%);
        border-radius: 50%;
        top: 6%;
        left: 8%;
        filter: blur(30px);
        animation: floatOrb1 12s ease-in-out infinite alternate;
    }

    .anim-orb-2 {
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(245, 158, 11, 0.15) 0%, rgba(245, 158, 11, 0.02) 70%);
        border-radius: 50%;
        bottom: 6%;
        right: 10%;
        filter: blur(30px);
        animation: floatOrb2 14s ease-in-out infinite alternate;
    }

    .anim-orb-3 {
        width: 220px;
        height: 220px;
        background: radial-gradient(circle, rgba(56, 189, 248, 0.2) 0%, transparent 70%);
        border-radius: 50%;
        top: 50%;
        right: 6%;
        filter: blur(25px);
        animation: floatOrb1 10s ease-in-out infinite alternate-reverse;
    }

    @keyframes floatOrb1 {
        0% { transform: translateY(0px) translateX(0px) scale(1); }
        50% { transform: translateY(-40px) translateX(25px) scale(1.08); }
        100% { transform: translateY(20px) translateX(-20px) scale(0.95); }
    }

    @keyframes floatOrb2 {
        0% { transform: translateY(0px) translateX(0px) scale(1); }
        50% { transform: translateY(35px) translateX(-30px) scale(1.1); }
        100% { transform: translateY(-25px) translateX(20px) scale(0.92); }
    }

    /* Floating Academic Badges in Background */
    .anim-badge-box {
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.9);
        box-shadow: 0 10px 25px rgba(15, 43, 92, 0.08);
        border-radius: 20px;
        padding: 0.9rem 1.1rem;
        display: flex;
        align-items: center;
        gap: 0.6rem;
        font-size: 0.85rem;
        font-weight: 700;
        color: #0f2b5c;
    }

    .badge-pos-1 {
        top: 12%;
        left: 6%;
        animation: floatBadge1 8s ease-in-out infinite alternate;
    }
    .badge-pos-2 {
        bottom: 15%;
        left: 8%;
        animation: floatBadge2 9s ease-in-out infinite alternate;
    }
    .badge-pos-3 {
        top: 18%;
        right: 6%;
        animation: floatBadge3 8.5s ease-in-out infinite alternate;
    }
    .badge-pos-4 {
        bottom: 12%;
        right: 8%;
        animation: floatBadge1 10s ease-in-out infinite alternate-reverse;
    }

    @keyframes floatBadge1 {
        0% { transform: translateY(0px) rotate(0deg); }
        100% { transform: translateY(-25px) rotate(4deg); }
    }
    @keyframes floatBadge2 {
        0% { transform: translateY(0px) rotate(0deg); }
        100% { transform: translateY(20px) rotate(-3deg); }
    }
    @keyframes floatBadge3 {
        0% { transform: translateY(0px) rotate(0deg); }
        100% { transform: translateY(-30px) rotate(-4deg); }
    }

    /* Animated Card Outer Glow Halo */
    .glass-card-container {
        position: relative;
        width: 100%;
        max-width: 480px;
        z-index: 5;
    }

    .glass-card-container::before {
        content: '';
        position: absolute;
        top: -3px;
        left: -3px;
        right: -3px;
        bottom: -3px;
        background: conic-gradient(from 0deg, #1d70b8, #38bdf8, #f59e0b, #1d70b8);
        border-radius: 26px;
        z-index: -1;
        opacity: 0.35;
        filter: blur(10px);
        animation: rotateHalo 12s linear infinite;
    }

    @keyframes rotateHalo {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Main Frosted White Glass Card */
    .glass-register-card {
        background: rgba(255, 255, 255, 0.92);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.95);
        border-radius: 24px;
        padding: 2.6rem 2.2rem;
        box-shadow: 0 20px 50px rgba(15, 43, 92, 0.12),
                    0 4px 15px rgba(15, 43, 92, 0.04);
        color: #0f2b5c;
    }

    /* Heading */
    .register-title {
        color: #0f2b5c;
        font-weight: 800;
        font-size: 1.85rem;
        letter-spacing: -0.5px;
        margin-bottom: 0.3rem;
        font-family: 'Outfit', sans-serif;
    }
    .register-subtitle {
        color: #64748b;
        font-size: 0.85rem;
        margin-bottom: 1.5rem;
    }

    /* Role Switch Pills */
    .role-switch-container {
        display: flex;
        background: #f1f5f9;
        padding: 4px;
        border-radius: 50px;
        border: 1px solid #e2e8f0;
        margin-bottom: 1.3rem;
    }
    .role-switch-btn {
        flex: 1;
        text-align: center;
        padding: 0.55rem;
        border-radius: 50px;
        font-size: 0.85rem;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.25s;
        color: #64748b;
    }
    .btn-check:checked + .role-switch-btn {
        background: #1d70b8;
        color: #ffffff;
        box-shadow: 0 2px 10px rgba(29, 112, 184, 0.3);
    }

    /* Clean Rounded Input Fields */
    .input-box {
        position: relative;
        margin-bottom: 1.15rem;
    }
    .input-box .form-control {
        background: #f8fafc;
        border: 1.5px solid #e2e8f0;
        border-radius: 50px;
        padding: 0.75rem 1.2rem 0.75rem 2.8rem;
        color: #0f2b5c;
        font-size: 0.9rem;
        font-weight: 500;
        transition: all 0.25s ease;
    }
    .input-box .form-control::placeholder {
        color: #94a3b8;
    }
    .input-box .form-control:focus {
        background: #ffffff;
        border-color: #1d70b8;
        box-shadow: 0 0 0 4px rgba(29, 112, 184, 0.15);
        color: #0f2b5c;
    }
    .input-icon {
        position: absolute;
        left: 1.1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #64748b;
        font-size: 0.95rem;
        z-index: 2;
        transition: color 0.2s;
    }
    .input-box .form-control:focus ~ .input-icon {
        color: #1d70b8;
    }
    .toggle-pass {
        position: absolute;
        right: 1.1rem;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: #94a3b8;
        cursor: pointer;
        padding: 0;
        z-index: 2;
    }
    .toggle-pass:hover {
        color: #1d70b8;
    }

    /* Home Page Royal Blue Submit Button */
    .btn-portal-submit {
        background: linear-gradient(135deg, #1d70b8 0%, #155a96 100%);
        color: #ffffff;
        font-weight: 800;
        font-size: 1rem;
        border: none;
        border-radius: 50px;
        padding: 0.85rem;
        width: 100%;
        letter-spacing: 0.3px;
        box-shadow: 0 6px 20px rgba(29, 112, 184, 0.35);
        transition: all 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .btn-portal-submit:hover {
        background: linear-gradient(135deg, #2284d8 0%, #1866aa 100%);
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(29, 112, 184, 0.45);
        color: #ffffff;
    }
    .btn-portal-submit:active {
        transform: translateY(1px);
        box-shadow: 0 4px 12px rgba(29, 112, 184, 0.35);
    }
</style>

<div class="register-viewport">
    <!-- Animated Light Ambient Glow Orbs -->
    <div class="floating-anim-item anim-orb-1"></div>
    <div class="floating-anim-item anim-orb-2"></div>
    <div class="floating-anim-item anim-orb-3"></div>

    <!-- Animated Floating Academic Badges (Desktop Only) -->
    <div class="floating-anim-item anim-badge-box badge-pos-1 d-none d-lg-flex">
        <i class="fa-solid fa-graduation-cap text-primary fs-5"></i>
        <span>10 Certified Programs</span>
    </div>
    <div class="floating-anim-item anim-badge-box badge-pos-2 d-none d-lg-flex">
        <i class="fa-solid fa-shield-halved text-success fs-5"></i>
        <span>Verified Reg. Gate</span>
    </div>
    <div class="floating-anim-item anim-badge-box badge-pos-3 d-none d-lg-flex">
        <i class="fa-solid fa-chalkboard-user text-warning fs-5"></i>
        <span>Faculty Studio</span>
    </div>
    <div class="floating-anim-item anim-badge-box badge-pos-4 d-none d-lg-flex">
        <i class="fa-solid fa-id-badge text-danger fs-5"></i>
        <span>Instant Verification</span>
    </div>

    <div class="glass-card-container">
        <div class="glass-register-card">
            <!-- Header -->
            <div class="text-center">
                <h2 class="register-title">Signup</h2>
                <p class="register-subtitle">Create your institutional account</p>
            </div>

            <!-- Error Alerts -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger py-2 px-3 rounded-4 small mb-3 border-0 shadow-sm" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-1"></i> ${errorMessage}
                </div>
            </c:if>

            <form action="/register" method="POST" id="regForm">
                <!-- Role Switch -->
                <div class="role-switch-container">
                    <input type="radio" class="btn-check" name="role" id="roleStudent" value="ROLE_STUDENT" ${enteredRole == null || enteredRole == 'ROLE_STUDENT' ? 'checked' : ''}>
                    <label class="role-switch-btn" for="roleStudent">
                        <i class="fa-solid fa-user-graduate me-1"></i> Student
                    </label>

                    <input type="radio" class="btn-check" name="role" id="roleFaculty" value="ROLE_FACULTY" ${enteredRole == 'ROLE_FACULTY' ? 'checked' : ''}>
                    <label class="role-switch-btn" for="roleFaculty">
                        <i class="fa-solid fa-chalkboard-user me-1"></i> Faculty
                    </label>
                </div>

                <!-- Registration / Roll Number -->
                <div class="input-box">
                    <input type="text" name="registrationNumber" id="regNumInput" value="${enteredRegNum}" class="form-control text-uppercase" placeholder="Registration Number" required>
                    <i class="fa-solid fa-hashtag input-icon"></i>
                </div>

                <!-- Full Name -->
                <div class="input-box">
                    <input type="text" name="name" value="${enteredName}" class="form-control" placeholder="Full Name" required>
                    <i class="fa-solid fa-user input-icon"></i>
                </div>

                <!-- Mobile Phone -->
                <div class="input-box">
                    <input type="text" name="mobile" value="${enteredMobile}" class="form-control" placeholder="Mobile Phone" required>
                    <i class="fa-solid fa-phone input-icon"></i>
                </div>

                <!-- Email -->
                <div class="input-box">
                    <input type="email" name="email" value="${enteredEmail}" class="form-control" placeholder="Email Address" required>
                    <i class="fa-solid fa-envelope input-icon"></i>
                </div>

                <!-- Password -->
                <div class="input-box mb-4">
                    <input type="password" name="password" id="regPasswordInput" class="form-control" placeholder="Password (Min. 6 chars)" required minlength="6">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <button type="button" class="toggle-pass" onclick="toggleRegPassword()" title="Show/Hide Password">
                        <i class="fa-solid fa-eye" id="regEyeIcon"></i>
                    </button>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-portal-submit mb-3">
                    Register
                </button>

                <!-- Login Link -->
                <div class="text-center" style="font-size: 0.85rem;">
                    <span class="text-muted">Already have an account?</span>
                    <a href="/login" class="fw-bold text-decoration-none ms-1" style="color: #1d70b8;">
                        Login
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleRegPassword() {
        const pass = document.getElementById('regPasswordInput');
        const eye = document.getElementById('regEyeIcon');
        if (pass.type === 'password') {
            pass.type = 'text';
            eye.classList.remove('fa-eye');
            eye.classList.add('fa-eye-slash');
        } else {
            pass.type = 'password';
            eye.classList.remove('fa-eye-slash');
            eye.classList.add('fa-eye');
        }
    }
</script>

</main>

<!-- Bootstrap 5.3 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>