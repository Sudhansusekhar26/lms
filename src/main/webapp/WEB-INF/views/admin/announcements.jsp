<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Platform Announcements - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="announcements" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-bullhorn me-2 text-info"></i> Platform Announcements</h4>
                        <p class="text-muted small mb-0">Broadcast notices to all users, student cohorts, or faculty members.</p>
                    </div>
                    <button type="button" class="btn btn-primary btn-sm px-3 py-2 fw-bold rounded-pill" data-bs-toggle="modal" data-bs-target="#addAnnouncementModal">
                        <i class="fa-solid fa-plus me-1"></i> New Notice
                    </button>
                </div>

                <div class="d-flex flex-column gap-3">
                    <c:forEach var="ann" items="${announcements}">
                        <div class="p-4 rounded-4 border bg-light">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="fw-bold text-dark mb-0">${ann.title}</h6>
                                <span class="badge bg-secondary bg-opacity-10 text-secondary">${ann.targetRole}</span>
                            </div>
                            <p class="text-muted small mb-2">${ann.content}</p>
                            <span class="text-muted fs-8"><i class="fa-regular fa-clock me-1"></i> Posted by ${ann.authorEmail} on ${ann.createdAt}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Announcement Modal -->
<div class="modal fade" id="addAnnouncementModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Broadcast Platform Notice</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/announcements/add" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Notice Title</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g. Scheduled Maintenance & Upgrades" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Target Audience</label>
                        <select name="targetRole" class="form-select">
                            <option value="ALL">All Users</option>
                            <option value="STUDENT">Students Only</option>
                            <option value="FACULTY">Faculty Only</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Announcement Message</label>
                        <textarea name="content" class="form-control" rows="4" placeholder="Enter message text..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Broadcast Now</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
