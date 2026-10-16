<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="System Management - Admin - Cloud LMS" />
</jsp:include>

<div class="container py-4">
    <div class="row">
        <!-- Sidebar Navigation Menu -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="system" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-sliders text-secondary me-2"></i> System Management & Infrastructure</h4>
                        <p class="text-muted small mb-0">Platform configuration, operational health, role governance, taxonomy, and system status.</p>
                    </div>
                    <span class="badge bg-success bg-opacity-10 text-success fs-7 fw-bold px-3 py-2 rounded-pill">
                        <i class="fa-solid fa-circle-check me-1"></i> System Operational (100% Up)
                    </span>
                </div>

                <!-- System Health Indicators -->
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="d-flex align-items-center justify-content-between mb-1">
                                <span class="small fw-bold text-muted">LMS Application Engine</span>
                                <span class="badge bg-success rounded-pill">Online</span>
                            </div>
                            <div class="fs-5 fw-bold text-navy">Spring Boot 3.4.1</div>
                            <div class="fs-8 text-muted">Java 17 &bull; Port: 8082</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="d-flex align-items-center justify-content-between mb-1">
                                <span class="small fw-bold text-muted">Relational Database</span>
                                <span class="badge bg-success rounded-pill">Connected</span>
                            </div>
                            <div class="fs-5 fw-bold text-navy">MySQL Database</div>
                            <div class="fs-8 text-muted">HikariCP Pool Active</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded-3 border">
                            <div class="d-flex align-items-center justify-content-between mb-1">
                                <span class="small fw-bold text-muted">Security Engine</span>
                                <span class="badge bg-success rounded-pill">Protected</span>
                            </div>
                            <div class="fs-5 fw-bold text-navy">Spring Security 6</div>
                            <div class="fs-8 text-muted">BCrypt Encryption Enabled</div>
                        </div>
                    </div>
                </div>

                <!-- Fast Governance Actions -->
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-bolt me-2 text-warning"></i> Quick System Utilities</h5>
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded-3 border h-100">
                            <h6 class="fw-bold text-navy mb-1"><i class="fa-solid fa-tags text-warning me-1"></i> Course Taxonomy</h6>
                            <p class="small text-muted mb-2">Total active categories: <strong>${categories.size()}</strong></p>
                            <a href="/admin/categories" class="btn btn-sm btn-outline-primary rounded-pill px-3">Manage Categories</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded-3 border h-100">
                            <h6 class="fw-bold text-navy mb-1"><i class="fa-solid fa-bullhorn text-info me-1"></i> Broadcast Notifications</h6>
                            <p class="small text-muted mb-2">Total announcements: <strong>${announcements.size()}</strong></p>
                            <a href="/admin/announcements" class="btn btn-sm btn-outline-info rounded-pill px-3">Post Announcement</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 bg-light rounded-3 border h-100">
                            <h6 class="fw-bold text-navy mb-1"><i class="fa-solid fa-shield-halved text-danger me-1"></i> Security Audit Logs</h6>
                            <p class="small text-muted mb-2">Track user logins, updates, and role changes.</p>
                            <a href="/admin/audit-logs" class="btn btn-sm btn-outline-danger rounded-pill px-3">View Audit Trail</a>
                        </div>
                    </div>
                </div>

                <!-- Recent Security Audit Trail -->
                <h5 class="fw-bold text-navy mb-3"><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i> Recent Audit Log Activity</h5>
                <div class="table-responsive">
                    <table class="table table-sm table-hover align-middle border mb-0 bg-white">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Timestamp</th>
                                <th>Actor</th>
                                <th>Action Event</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${auditLogs}" varStatus="st">
                                <c:if test="${st.index < 6}">
                                    <tr>
                                        <td class="small text-muted">${log.timestamp}</td>
                                        <td class="fw-bold small text-dark">${log.actorEmail}</td>
                                        <td><span class="badge bg-primary bg-opacity-10 text-primary fs-8">${log.action}</span></td>
                                        <td class="small text-muted">${log.details}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
