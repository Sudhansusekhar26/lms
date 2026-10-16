<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Live Class Management - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <c:if test="${not empty param.msg}">
        <div class="alert alert-success alert-dismissible fade show rounded-4 shadow-sm border-0 d-flex align-items-center gap-3 p-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check fs-4 text-success"></i>
            <div><strong>Success!</strong> ${param.msg}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="live" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-video text-danger me-2"></i> Live Class Management</h4>
                        <p class="text-muted small mb-0">Schedule institutional webinars, monitor faculty live schedules, and manage broadcast sessions.</p>
                    </div>
                    <button type="button" class="btn btn-danger rounded-pill px-4 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#scheduleLiveModal">
                        <i class="fa-solid fa-video-camera me-1"></i> Schedule Live Session
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Session Title</th>
                                <th>Course & Faculty</th>
                                <th>Scheduled Time</th>
                                <th>Duration</th>
                                <th>Status</th>
                                <th class="text-end">Manage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lc" items="${liveClasses}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${lc.title}</div>
                                        <div class="small text-muted">${lc.description}</div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark fs-7">${lc.course.title}</div>
                                        <span class="small text-muted">${lc.instructorEmail}</span>
                                    </td>
                                    <td class="small text-muted fw-bold">${lc.scheduledAt}</td>
                                    <td class="small text-muted">${lc.durationMinutes} min</td>
                                    <td>
                                        <span class="badge ${lc.status == 'LIVE' ? 'bg-danger' : (lc.status == 'COMPLETED' ? 'bg-success' : 'bg-primary')} px-2.5 py-1 rounded-pill">
                                            ${lc.status}
                                        </span>
                                    </td>
                                    <td class="text-end">
                                        <form action="/admin/live/${lc.id}/status" method="POST" class="d-inline">
                                            <select name="status" class="form-select form-select-sm d-inline-block w-auto rounded-3" onchange="this.form.submit()">
                                                <option value="UPCOMING" ${lc.status == 'UPCOMING' ? 'selected' : ''}>Upcoming</option>
                                                <option value="LIVE" ${lc.status == 'LIVE' ? 'selected' : ''}>Live Now</option>
                                                <option value="COMPLETED" ${lc.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                                <option value="CANCELLED" ${lc.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL: Schedule Live Class -->
<div class="modal fade" id="scheduleLiveModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header bg-danger text-white border-0 rounded-top-4 p-3 px-4">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-video me-2"></i> Schedule Live Broadcast Session</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/live/schedule" method="POST">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Course *</label>
                            <select name="courseId" class="form-select rounded-3" required>
                                <c:forEach var="c" items="${courses}">
                                    <option value="${c.id}">${c.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Faculty Instructor *</label>
                            <select name="instructorEmail" class="form-select rounded-3" required>
                                <c:forEach var="f" items="${facultyList}">
                                    <option value="${f.email}">${f.name} (${f.email})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Live Session Title *</label>
                            <input type="text" name="title" class="form-control rounded-3" placeholder="e.g. Live Q&A and Architecture Review" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Description</label>
                            <textarea name="description" class="form-control rounded-3" rows="2" placeholder="Agenda and topics to cover..."></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Scheduled Date & Time *</label>
                            <input type="datetime-local" name="scheduledAt" class="form-control rounded-3" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Duration (Minutes)</label>
                            <input type="number" name="durationMinutes" class="form-control rounded-3" value="60" min="15" max="240">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light border-0 rounded-bottom-4 p-3">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger rounded-pill px-4 fw-bold">
                        <i class="fa-solid fa-calendar-check me-1"></i> Schedule Session
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
