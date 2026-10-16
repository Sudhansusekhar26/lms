<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Contact Inquiries - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="messages" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-inbox me-2 text-primary"></i> Guest Contact & Support Inquiries</h4>
                <p class="text-muted small mb-4">Messages submitted by public visitors and prospective learners from the contact portal.</p>

                <c:choose>
                    <c:when test="${not empty messages}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle small mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Mobile</th>
                                        <th>Message</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="msg" items="${messages}">
                                        <tr>
                                            <td class="fw-bold text-dark">${msg.name}</td>
                                            <td><code>${msg.email}</code></td>
                                            <td>${msg.mobile}</td>
                                            <td style="max-width: 250px;">${msg.message}</td>
                                            <td>
                                                <span class="badge ${msg.status == 'RESOLVED' ? 'bg-success' : 'bg-warning text-dark'} rounded-pill px-3 py-1">
                                                    ${msg.status}
                                                </span>
                                            </td>
                                            <td class="text-muted">${msg.createdAt}</td>
                                            <td class="text-end">
                                                <c:if test="${msg.status != 'RESOLVED'}">
                                                    <form action="/admin/messages/${msg.id}/resolve" method="POST" class="d-inline">
                                                        <button type="submit" class="btn btn-sm btn-outline-success rounded-pill px-3">
                                                            <i class="fa-solid fa-check me-1"></i> Resolve
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="p-4 text-center bg-light rounded-4 text-muted">
                            <p class="mb-0">No contact inquiries received yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
