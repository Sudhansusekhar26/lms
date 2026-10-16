<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Taxonomy & Categories - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="categories" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-tags me-2 text-warning"></i> Curriculum Taxonomy</h4>
                        <p class="text-muted small mb-0">Organize and structure course classifications and department categories.</p>
                    </div>
                    <button type="button" class="btn btn-primary btn-sm px-3 py-2 fw-bold rounded-pill" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                        <i class="fa-solid fa-plus me-1"></i> Add Category
                    </button>
                </div>

                <div class="row g-4">
                    <c:forEach var="cat" items="${categories}">
                        <div class="col-md-6">
                            <div class="card h-100 border rounded-4 p-4 shadow-none">
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                        <i class="fa-solid ${cat.icon} fs-4"></i>
                                    </div>
                                    <div>
                                        <h5 class="fw-bold mb-0 text-dark">${cat.name}</h5>
                                        <span class="badge bg-light text-muted border">${cat.courses.size()} Active Courses</span>
                                    </div>
                                </div>
                                <p class="text-muted small mb-0">${cat.description}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Create Academic Category</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/categories/add" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Category Name</label>
                        <input type="text" name="name" class="form-control" placeholder="e.g. Cybersecurity & Zero Trust" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">FontAwesome Icon Class</label>
                        <input type="text" name="icon" class="form-control" placeholder="e.g. fa-shield-halved" value="fa-book">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Description</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Category focus and department scope..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Create Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
