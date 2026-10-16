<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Certificate - ${certId}" />
</jsp:include>

<style>
    .cert-frame {
        background: #ffffff;
        border: 12px double #0f2b5c;
        box-shadow: 0 15px 45px rgba(15, 43, 92, 0.12);
        padding: 45px 55px;
        position: relative;
        background-image: radial-gradient(#f0f5fa 1px, transparent 1px);
        background-size: 20px 20px;
    }
    .cert-seal {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        background: linear-gradient(135deg, #f59e0b, #d97706);
        color: white;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 6px 16px rgba(217, 119, 6, 0.35);
        border: 3px solid #ffffff;
    }
    @media print {
        body * {
            visibility: hidden;
        }
        .cert-print-area, .cert-print-area * {
            visibility: visible;
        }
        .cert-print-area {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            margin: 0;
            padding: 20px;
            box-shadow: none;
            border: 8px double #0f2b5c;
        }
        .no-print {
            display: none !important;
        }
    }
</style>

<div class="container py-5">
    <c:choose>
        <c:when test="${valid}">
            <!-- Action Bar -->
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4 no-print">
                <a href="/verify-certificate" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                    <i class="fa-solid fa-arrow-left me-1"></i> Verify Another Certificate
                </a>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-outline-primary btn-sm rounded-pill px-3" onclick="copyLink()">
                        <i class="fa-solid fa-share-nodes me-1"></i> Copy Link
                    </button>
                    <button type="button" class="btn btn-portal-primary btn-sm rounded-pill px-4 fw-bold" onclick="window.print()">
                        <i class="fa-solid fa-print me-1"></i> Print / Download PDF
                    </button>
                </div>
            </div>

            <!-- Authentic Certificate Frame -->
            <div class="cert-frame rounded-4 text-center cert-print-area">
                <!-- Certificate Header -->
                <div class="d-flex align-items-center justify-content-between mb-4 border-bottom pb-3">
                    <div class="d-flex align-items-center gap-2">
                        <div class="bg-primary text-white rounded-3 p-2 d-flex align-items-center justify-content-center" style="width: 42px; height: 42px; background-color: #1d70b8 !important;">
                            <i class="fa-solid fa-graduation-cap fs-5"></i>
                        </div>
                        <div class="text-start">
                            <h4 class="fw-extrabold mb-0" style="color: #0f2b5c; font-family: 'Outfit', sans-serif;">CLOUD LMS ACADEMY</h4>
                            <span class="fs-8 text-muted text-uppercase tracking-wider">Accredited Higher Education & Cloud Computing Registry</span>
                        </div>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${isVerified}">
                                <span class="badge bg-success bg-opacity-15 text-success border border-success px-3 py-2 rounded-pill fw-bold">
                                    <i class="fa-solid fa-circle-check me-1"></i> VERIFIED & AUTHENTIC
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning bg-opacity-25 text-warning-emphasis border border-warning px-3 py-2 rounded-pill fw-bold">
                                    <i class="fa-solid fa-clock me-1"></i> ENROLLED & IN PROGRESS
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <p class="text-uppercase text-muted fw-semibold small letter-spacing-2 mb-2" style="letter-spacing: 2px;">
                    This official credential certifies that
                </p>
                <h1 class="display-5 fw-extrabold mb-3" style="color: #0f2b5c; font-family: 'Outfit', sans-serif;">
                    ${student.name}
                </h1>
                
                <c:if test="${not empty student.registrationNumber}">
                    <p class="text-muted small mb-3">
                        Registration ID: <strong>${student.registrationNumber}</strong>
                        <c:if test="${not empty student.department}"> &bull; Department of <strong>${student.department}</strong></c:if>
                    </p>
                </c:if>

                <p class="text-muted max-w-2xl mx-auto mb-4" style="font-size: 1.05rem;">
                    has successfully satisfied all rigorous curriculum modules, laboratory practicums, and assessment benchmarks for the certified program
                </p>

                <div class="p-3 rounded-4 bg-light d-inline-block px-5 mb-4 border">
                    <h3 class="fw-bold mb-1" style="color: #1d70b8; font-family: 'Outfit', sans-serif;">
                        ${course.title}
                    </h3>
                    <span class="badge bg-secondary bg-opacity-25 text-dark small">${course.level} Level &bull; ${course.duration}</span>
                </div>

                <!-- Signatures & Seal Row -->
                <div class="row align-items-center justify-content-between pt-4 mt-3 border-top g-4">
                    <div class="col-md-4 text-md-start">
                        <div class="fw-bold fs-6 text-dark" style="font-family: cursive; font-size: 1.25rem;">
                            ${not empty course.instructorName ? course.instructorName : 'Senior Dean'}
                        </div>
                        <div class="border-top pt-1 mt-1 small text-muted">
                            <strong>${course.instructorName}</strong><br>
                            Authorized Faculty Instructor
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="cert-seal mb-2">
                            <i class="fa-solid fa-award fs-1"></i>
                        </div>
                        <div class="small fw-bold text-uppercase" style="color: #0f2b5c; letter-spacing: 1px;">Official Academy Seal</div>
                        <div class="fs-8 text-muted">Verified Registry Record</div>
                    </div>

                    <div class="col-md-4 text-md-end">
                        <div class="text-md-end">
                            <div class="fw-bold fs-7 text-dark mb-1">CREDENTIAL IDENTIFIER</div>
                            <code class="px-2 py-1 bg-light border rounded small fw-bold text-primary">${certId}</code>
                            <div class="fs-8 text-muted mt-2">
                                Issued: <strong>${enrollment != null ? enrollment.enrolledAt.toLocalDate() : 'Verified Graduate'}</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Invalid Certificate Display -->
            <div class="card portal-card p-5 text-center max-w-lg mx-auto shadow-sm">
                <div class="rounded-circle bg-danger bg-opacity-10 d-inline-flex p-3 text-danger mx-auto mb-3" style="width: 70px; height: 70px;">
                    <i class="fa-solid fa-triangle-exclamation fs-2"></i>
                </div>
                <h4 class="fw-bold text-dark mb-2">Certificate Record Not Found</h4>
                <p class="text-muted small mb-4">
                    We could not locate an authenticated credential matching ID <code>${certId}</code>. Please check the spelling or format.
                </p>
                <div class="d-flex justify-content-center gap-2">
                    <a href="/verify-certificate" class="btn btn-outline-secondary rounded-pill px-4">Try Another ID</a>
                    <a href="/" class="btn btn-portal-primary rounded-pill px-4">Return Home</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function copyLink() {
        navigator.clipboard.writeText(window.location.href).then(function() {
            alert('Certificate verification link copied to clipboard!');
        });
    }
</script>

<jsp:include page="footer.jsp" />
