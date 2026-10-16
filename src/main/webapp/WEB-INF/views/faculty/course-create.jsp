<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="New Course Studio - Faculty Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="create-course" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white">
                <div class="d-flex align-items-center gap-3 mb-4">
                    <a href="/faculty/courses" class="btn btn-outline-secondary btn-sm rounded-circle"><i class="fa-solid fa-arrow-left"></i></a>
                    <div>
                        <h4 class="fw-bold text-dark mb-0">Author New Curriculum Course</h4>
                        <p class="text-muted small mb-0">Define course taxonomy, duration, pricing, and media metadata.</p>
                    </div>
                </div>

                <form action="/faculty/courses/create" method="POST">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label fw-semibold text-dark small">Course Name *</label>
                            <input type="text" name="title" class="form-control" placeholder="e.g. Java Programming" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Category *</label>
                            <select name="categoryId" class="form-select" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Duration *</label>
                            <input type="text" name="duration" class="form-control" placeholder="e.g. 8 Weeks, 10 Weeks, 16 Weeks" value="8 Weeks" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Level *</label>
                            <select name="level" class="form-select" required>
                                <option value="Beginner" selected>Beginner</option>
                                <option value="Intermediate">Intermediate</option>
                                <option value="Advanced">Advanced</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold text-dark small">Price</label>
                            <input type="text" name="price" class="form-control" placeholder="e.g. Free or $49" value="Free" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold text-dark small">Thumbnail Image URL (Cloud / Unsplash / S3)</label>
                            <input type="url" name="thumbnailUrl" class="form-control" placeholder="https://images.unsplash.com/photo-..." value="https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&auto=format&fit=crop&q=60">
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold text-dark small">Course Description *</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="Learn Java fundamentals, OOP, exception handling, collections and basic problem solving..." required></textarea>
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-brand btn-lg w-100 py-3 fw-bold">
                                <i class="fa-solid fa-arrow-right me-2"></i> Save & Proceed to Syllabus Studio (Modules & Materials)
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
