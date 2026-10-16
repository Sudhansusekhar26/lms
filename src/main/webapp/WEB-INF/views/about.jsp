<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="About Us - Cloud LMS" />
</jsp:include>

<div class="py-5 bg-dark text-white border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #0f172a, #1e293b);">
    <div class="container text-center py-4">
        <span class="badge bg-primary bg-opacity-25 text-cyan mb-2">ABOUT THE PLATFORM</span>
        <h1 class="fw-extrabold mb-3">Pioneering Next-Generation Cloud Education</h1>
        <p class="lead text-secondary max-w-2xl mx-auto">
            Architected with zero technical debt, strict role-based access control, and high fault tolerance to empower students, faculty, and institutions worldwide.
        </p>
    </div>
</div>

<div class="container py-5">
    <div class="row g-5 align-items-center mb-5">
        <div class="col-lg-6">
            <span class="badge bg-primary bg-opacity-10 text-primary fw-bold text-uppercase px-3 py-1 mb-2">Our Mission</span>
            <h2 class="fw-bold mb-3">Bridging Academic Rigor & Cloud Scale</h2>
            <p class="text-muted leading-relaxed mb-4">
                CloudLMS was engineered to eliminate fragmented learning portals. We unify live real-time video classrooms, structured syllabi with downloadable PDF lecture notes, automated quiz evaluation engines, and granular role governance in a single cohesive platform.
            </p>
            <div class="row g-3">
                <div class="col-6">
                    <div class="p-3 bg-light rounded-3 border">
                        <h4 class="fw-bold text-primary mb-1">99.99%</h4>
                        <p class="text-muted small mb-0">Uptime SLA Architecture</p>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-3 bg-light rounded-3 border">
                        <h4 class="fw-bold text-success mb-1">Sub-100ms</h4>
                        <p class="text-muted small mb-0">WebRTC Live Latency</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&auto=format&fit=crop&q=60" class="card-img-top object-fit-cover" style="height: 340px;" alt="Students collaborating">
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
