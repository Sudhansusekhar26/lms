<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Security Audit Logs - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="audit" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-clipboard-list me-2 text-danger"></i> System & Security Audit Trail</h4>
                <p class="text-muted small mb-4">Immutable log of security events, administrative updates, and user activities.</p>

                <div class="table-responsive">
                    <table class="table table-hover align-middle small mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Actor Email</th>
                                <th>Action Type</th>
                                <th>Details</th>
                                <th>IP Address</th>
                                <th>Timestamp</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${logs}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
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
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
