<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Virtual Campus Gallery - Cloud LMS" />
</jsp:include>

<div class="py-5 bg-dark text-white border-bottom border-secondary border-opacity-25" style="background: linear-gradient(135deg, #0f172a, #1e293b);">
    <div class="container text-center py-4">
        <span class="badge bg-primary bg-opacity-25 text-cyan mb-2">CAMPUS & LEARNING HIGHLIGHTS</span>
        <h1 class="fw-extrabold mb-3">Academic Showcase & Virtual Labs</h1>
        <p class="lead text-secondary max-w-2xl mx-auto">
            A visual glimpse into our live hackathons, cloud labs, faculty studios, and collaborative workshops.
        </p>
    </div>
</div>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <img src="https://images.unsplash.com/photo-1531482615713-2afd69097998?w=800&auto=format&fit=crop&q=60" class="card-img-top object-fit-cover" style="height: 240px;" alt="Hackathon">
                <div class="card-body p-3">
                    <h6 class="fw-bold mb-1">Global Cloud Hackathon 2026</h6>
                    <p class="text-muted small mb-0">Students building microservices on Kubernetes.</p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <img src="https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&auto=format&fit=crop&q=60" class="card-img-top object-fit-cover" style="height: 240px;" alt="Faculty Lecture">
                <div class="card-body p-3">
                    <h6 class="fw-bold mb-1">Interactive Faculty Masterclasses</h6>
                    <p class="text-muted small mb-0">Professors delivering live broadcasts and Q&A sessions.</p>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <img src="https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&auto=format&fit=crop&q=60" class="card-img-top object-fit-cover" style="height: 240px;" alt="Tech Workshop">
                <div class="card-body p-3">
                    <h6 class="fw-bold mb-1">Distributed Systems Lab</h6>
                    <p class="text-muted small mb-0">Hands-on Spring Boot & Kafka event streaming labs.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />