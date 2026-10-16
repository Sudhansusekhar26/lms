<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Contact Us - Cloud LMS" />
</jsp:include>

<div class="py-5 bg-dark text-white border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #0f172a, #1e293b);">
    <div class="container text-center py-4">
        <span class="badge bg-primary bg-opacity-25 text-cyan mb-2">GET IN TOUCH</span>
        <h1 class="fw-extrabold mb-3">Academic Inquiries & Platform Support</h1>
        <p class="lead text-secondary max-w-2xl mx-auto">
            Have questions about enterprise enrollment, faculty onboarding, or institutional licensing? Reach out to our leads.
        </p>
    </div>
</div>

<div class="container py-5">
    <div class="row g-5">
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white">
                <h4 class="fw-bold mb-4 text-dark">Send a Message</h4>

                <c:if test="${not empty successMsg or param.success == 'true'}">
                    <div class="alert alert-success alert-dismissible fade show rounded-3" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i> ${not empty successMsg ? successMsg : 'Thank you! Your message has been received. Our academic team will get back to you shortly.'}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="/contact" method="POST">
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

        <div class="col-lg-5">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-light mb-4">
                <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-building-columns me-2 text-primary"></i> Academic Office</h5>
                <ul class="list-unstyled d-flex flex-column gap-3 small text-muted mb-0">
                    <li class="d-flex align-items-start gap-3">
                        <i class="fa-solid fa-location-dot fs-5 text-primary mt-1"></i>
                        <div>
                            <strong class="text-dark">CLOUD TECH</strong><br>
                         DLF CYBER CITY, Chandaka Industrial Estate, Patia, Bhubaneswar, Odisha 751024
                        </div>
                    </li>
                    <li class="d-flex align-items-center gap-3">
                        <i class="fa-solid fa-envelope fs-5 text-primary"></i>
                        <div>
                            <strong class="text-dark">Direct Support:</strong><br>
                            admissions@lms.edu | support@lms.edu
                        </div>
                    </li>
                    <li class="d-flex align-items-center gap-3">
                        <i class="fa-solid fa-phone fs-5 text-primary"></i>
                        <div>
                            <strong class="text-dark">Toll Free Helpline:</strong><br>
                            +91 9876543210 (Mon - Fri, 9am - 6pm EST)
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
