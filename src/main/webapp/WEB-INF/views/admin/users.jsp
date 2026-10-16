<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="User Governance - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="users" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-users-gear me-2 text-primary"></i> User Governance & RBAC</h4>
                        <p class="text-muted small mb-0">Manage credentials, suspend/verify accounts, and adjust RBAC role assignments.</p>
                    </div>

                    <!-- Role Filter -->
                    <div class="d-flex gap-2">
                        <a href="/admin/users" class="btn btn-sm ${selectedRole == null ? 'btn-primary' : 'btn-outline-secondary'}">All</a>
                        <a href="/admin/users?role=ROLE_STUDENT" class="btn btn-sm ${selectedRole == 'ROLE_STUDENT' ? 'btn-primary' : 'btn-outline-secondary'}">Students</a>
                        <a href="/admin/users?role=ROLE_FACULTY" class="btn btn-sm ${selectedRole == 'ROLE_FACULTY' ? 'btn-primary' : 'btn-outline-secondary'}">Faculty</a>
                        <a href="/admin/users?role=ROLE_ADMIN" class="btn btn-sm ${selectedRole == 'ROLE_ADMIN' ? 'btn-primary' : 'btn-outline-secondary'}">Admins</a>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle small mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Name</th>
                                <th>Registration No.</th>
                                <th>Email</th>
                                <th>Mobile</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Registered</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr>
                                    <td class="fw-bold text-dark">${u.name != null ? u.name : 'User'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty u.registrationNumber}">
                                                <span class="badge bg-warning bg-opacity-25 text-dark border border-warning border-opacity-25 fw-bold">
                                                    ${u.registrationNumber}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted small">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><code>${u.email}</code></td>
                                    <td>${u.mobile != null ? u.mobile : '-'}</td>
                                    <td>
                                        <span class="badge ${u.role == 'ROLE_ADMIN' ? 'bg-danger' : (u.role == 'ROLE_FACULTY' ? 'bg-purple text-white' : 'bg-success')}" style="${u.role == 'ROLE_FACULTY' ? 'background-color: #8b5cf6;' : ''}">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${u.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'} rounded-pill px-3 py-1">
                                            ${u.status}
                                        </span>
                                    </td>
                                    <td class="text-muted">${u.createdAt}</td>
                                    <td class="text-end">
                                        <div class="d-inline-flex gap-1">
                                            <!-- Toggle Status -->
                                            <form action="/admin/users/${u.id}/status" method="POST" class="d-inline">
                                                <input type="hidden" name="status" value="${u.status == 'ACTIVE' ? 'SUSPENDED' : 'ACTIVE'}">
                                                <button type="submit" class="btn btn-sm ${u.status == 'ACTIVE' ? 'btn-outline-warning' : 'btn-outline-success'}" title="${u.status == 'ACTIVE' ? 'Suspend Account' : 'Activate Account'}">
                                                    <i class="fa-solid ${u.status == 'ACTIVE' ? 'fa-ban' : 'fa-check'}"></i>
                                                </button>
                                            </form>

                                            <!-- Change Role Trigger -->
                                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#roleModal_${u.id}" title="Change Role">
                                                <i class="fa-solid fa-user-shield"></i>
                                            </button>

                                            <!-- Delete User -->
                                            <form action="/admin/users/${u.id}/delete" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to delete user ${u.email}?');">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete User">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Role Edit Modal -->
                                <div class="modal fade" id="roleModal_${u.id}" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered modal-sm">
                                        <div class="modal-content rounded-4 border-0">
                                            <div class="modal-header bg-dark text-white p-3">
                                                <h6 class="modal-title fw-bold">Update Role: ${u.email}</h6>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="/admin/users/${u.id}/role" method="POST">
                                                <div class="modal-body p-3">
                                                    <label class="form-label fw-semibold small">Assign Role</label>
                                                    <select name="role" class="form-select">
                                                        <option value="ROLE_STUDENT" ${u.role == 'ROLE_STUDENT' ? 'selected' : ''}>Student</option>
                                                        <option value="ROLE_FACULTY" ${u.role == 'ROLE_FACULTY' ? 'selected' : ''}>Faculty</option>
                                                        <option value="ROLE_ADMIN" ${u.role == 'ROLE_ADMIN' ? 'selected' : ''}>Administrator</option>
                                                    </select>
                                                </div>
                                                <div class="modal-footer bg-light p-2">
                                                    <button type="submit" class="btn btn-primary btn-sm w-100 fw-bold">Save Role</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />