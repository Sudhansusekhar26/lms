<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Live Class Scheduler - Faculty Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="fmenu.jsp">
                <jsp:param name="active" value="live" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-tower-broadcast me-2 text-danger"></i> Live Class Scheduler & Broadcaster</h4>
                        <p class="text-muted small mb-0">Schedule interactive webinars, start WebRTC live video streams, and monitor room status.</p>
                    </div>
                    <button type="button" class="btn btn-danger btn-sm px-3 py-2 fw-bold rounded-pill" data-bs-toggle="modal" data-bs-target="#scheduleLiveModal">
                        <i class="fa-solid fa-plus me-1"></i> Schedule Live Stream
                    </button>
                </div>

                <c:choose>
                    <c:when test="${not empty liveClasses}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle small mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Class Title</th>
                                        <th>Course</th>
                                        <th>Schedule Date & Time</th>
                                        <th>Duration</th>
                                        <th>Room ID</th>
                                        <th>Status</th>
                                        <th class="text-end">Broadcast Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="lc" items="${liveClasses}">
                                        <tr>
                                            <td class="fw-bold text-dark">${lc.title}</td>
                                            <td><span class="badge bg-primary bg-opacity-10 text-primary">${lc.course.title}</span></td>
                                            <td>${lc.scheduledAt}</td>
                                            <td>${lc.durationMinutes} mins</td>
                                            <td><code>${lc.roomId}</code></td>
                                            <td>
                                                <span class="badge ${lc.status == 'LIVE' ? 'bg-danger' : (lc.status == 'UPCOMING' ? 'bg-warning text-dark' : 'bg-secondary')} rounded-pill px-3 py-1">
                                                    ${lc.status}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <div class="d-inline-flex gap-2">
                                                    <a href="/faculty/live/${lc.id}/broadcast" class="btn btn-sm btn-danger rounded-pill px-3 fw-bold">
                                                        <i class="fa-solid fa-tower-broadcast me-1"></i> Start Broadcast
                                                    </a>
                                                    <form action="/faculty/live/${lc.id}/status" method="POST" class="d-inline">
                                                        <input type="hidden" name="status" value="${lc.status == 'LIVE' ? 'COMPLETED' : 'LIVE'}">
                                                        <button type="submit" class="btn btn-sm btn-outline-secondary rounded-pill">
                                                            ${lc.status == 'LIVE' ? 'Mark Completed' : 'Go Live'}
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-5 text-center bg-light rounded-4 text-muted">
                            <i class="fa-solid fa-video fs-1 mb-3 text-secondary"></i>
                            <h5 class="fw-bold">No live sessions scheduled</h5>
                            <p class="small mb-3">Schedule a real-time lecture with dynamic room tokens.</p>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#scheduleLiveModal">
                                Schedule First Class
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Schedule Live Modal -->
<div class="modal fade" id="scheduleLiveModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Schedule Live Classroom</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/faculty/live/schedule" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Associated Course</label>
                        <select name="courseId" class="form-select" required>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}">${c.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Session Title</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g. Live Q&A: Microservices Architecture" required>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-7">
                            <label class="form-label fw-semibold text-dark small">Date & Time</label>
                            <input type="datetime-local" name="scheduledAt" class="form-control" required>
                        </div>
                        <div class="col-5">
                            <label class="form-label fw-semibold text-dark small">Duration (Mins)</label>
                            <input type="number" name="durationMinutes" class="form-control" value="60" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Agenda Description</label>
                        <textarea name="description" class="form-control" rows="3" placeholder="Topic details and agenda..."></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Schedule Meeting</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
