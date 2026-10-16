<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Governance Dashboard - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="dashboard" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <!-- Welcome Header -->
            <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 text-white" style="background: linear-gradient(135deg, #18181b, #27272a);">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <span class="badge bg-danger bg-opacity-25 text-danger mb-2 border border-danger border-opacity-25">PLATFORM GOVERNANCE CONTROL</span>
                        <h2 class="fw-bold mb-1">System Administration: ${sessionScope.userName != null ? sessionScope.userName : 'Admin'}</h2>
                        <p class="text-secondary small mb-0">Oversee user verifications, manage RBAC security clearance, monitor system audit logs, and govern course categories.</p>
                    </div>
                    <div class="col-md-4 text-md-end mt-3 mt-md-0">
                        <a href="/admin/users" class="btn btn-danger btn-sm px-3 py-2 fw-bold"><i class="fa-solid fa-users-gear me-1"></i> User Governance</a>
                    </div>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="row g-3 mb-4">
                <div class="col-6 col-md-4 col-xl-2">
                    <div class="p-3 bg-white rounded-4 border shadow-sm text-center">
                        <h4 class="fw-extrabold text-primary mb-1">${totalUsers}</h4>
                        <span class="text-muted fs-8">Total Users</span>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl-2">
                    <div class="p-3 bg-white rounded-4 border shadow-sm text-center">
                        <h4 class="fw-extrabold text-success mb-1">${totalStudents}</h4>
                        <span class="text-muted fs-8">Active Students</span>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl-2">
                    <div class="p-3 bg-white rounded-4 border shadow-sm text-center">
                        <h4 class="fw-extrabold text-purple mb-1" style="color: #8b5cf6;">${totalFaculty}</h4>
                        <span class="text-muted fs-8">Faculty Staff</span>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl-2">
                    <div class="p-3 bg-white rounded-4 border shadow-sm text-center">
                        <h4 class="fw-extrabold text-info mb-1">${totalCourses}</h4>
                        <span class="text-muted fs-8">Global Courses</span>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl-2">
                    <div class="p-3 bg-white rounded-4 border shadow-sm text-center">
                        <h4 class="fw-extrabold text-warning mb-1">${totalEnrollments}</h4>
                        <span class="text-muted fs-8">Enrollments</span>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-xl-2">
                    <div class="p-3 bg-white rounded-4 border shadow-sm text-center">
                        <h4 class="fw-extrabold text-danger mb-1">${totalSubmissions}</h4>
                        <span class="text-muted fs-8">Quiz Attempts</span>
                    </div>
                </div>
            </div>

            <!-- Recent Security Audit Logs -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-clipboard-list me-2 text-danger"></i> Recent Security & System Audit Trail</h5>
                    <a href="/admin/audit-logs" class="btn btn-sm btn-outline-secondary">View All Logs</a>
                </div>

                <c:choose>
                    <c:when test="${not empty recentLogs}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle small mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Actor Email</th>
                                        <th>Action Code</th>
                                        <th>Action Details</th>
                                        <th>IP Address</th>
                                        <th>Timestamp</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="log" items="${recentLogs}">
                                        <tr>
                                            <td class="fw-bold text-dark">${log.actorEmail}</td>
                                            <td><span class="badge bg-dark">${log.action}</span></td>
                                            <td>${log.details}</td>
                                            <td><code>${log.ipAddress}</code></td>
                                            <td class="text-muted">${log.timestamp}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted small mb-0">No audit logs recorded yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
