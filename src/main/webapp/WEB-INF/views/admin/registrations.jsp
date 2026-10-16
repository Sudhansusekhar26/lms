<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Authorized Registration Numbers - Admin Console" />
</jsp:include>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="aheader.jsp">
                <jsp:param name="active" value="registrations" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-id-card-clip me-2 text-warning"></i> Authorized Student & Faculty Registration Numbers</h4>
                        <p class="text-muted small mb-0">Enter valid registration numbers into this MySQL database table. When a student or faculty attempts to register, their entered registration number MUST match this database table to create an account.</p>
                    </div>
                    <button type="button" class="btn btn-warning text-dark fw-bold btn-sm px-3 py-2 rounded-pill" data-bs-toggle="modal" data-bs-target="#addRegModal">
                        <i class="fa-solid fa-plus me-1"></i> Add Registration Number
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle small mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Registration No.</th>
                                <th>Role</th>
                                <th>Pre-Allocated Name</th>
                                <th>Department</th>
                                <th>Claim Status</th>
                                <th>Claimed By Email</th>
                                <th>Date Added</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${registrations}">
                                <tr>
                                    <td class="fw-bold text-dark"><code>${r.registrationNumber}</code></td>
                                    <td>
                                        <span class="badge ${r.role == 'ROLE_FACULTY' ? 'bg-purple text-white' : 'bg-primary'}" style="${r.role == 'ROLE_FACULTY' ? 'background-color: #8b5cf6;' : ''}">
                                            ${r.role == 'ROLE_FACULTY' ? 'FACULTY' : 'STUDENT'}
                                        </span>
                                    </td>
                                    <td>${r.allocatedName != null ? r.allocatedName : '-'}</td>
                                    <td><span class="badge bg-light text-dark border">${r.department != null ? r.department : 'General'}</span></td>
                                    <td>
                                        <span class="badge ${r.used ? 'bg-secondary' : 'bg-success'} rounded-pill px-3 py-1">
                                            <i class="fa-solid ${r.used ? 'fa-lock' : 'fa-check'} me-1"></i> ${r.used ? 'CLAIMED / USED' : 'AVAILABLE'}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.used and not empty r.usedByEmail}">
                                                <code>${r.usedByEmail}</code>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-muted">${r.createdAt}</td>
                                    <td class="text-end">
                                        <form action="/admin/registrations/${r.id}/delete" method="POST" class="d-inline" onsubmit="return confirm('Delete registration number ${r.registrationNumber}?');">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
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

<!-- Add Registration Modal -->
<div class="modal fade" id="addRegModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-dark text-white p-3">
                <h5 class="modal-title fw-bold">Authorize New Registration Number</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/registrations/add" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Registration Number / Roll No.</label>
                        <input type="text" name="registrationNumber" class="form-control" placeholder="e.g. STU-2026-200 or FAC-2026-600" required>
                        <span class="text-muted fs-8">Must be unique (e.g. STU-2026-XXX for student, FAC-2026-XXX for faculty)</span>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Authorized Role</label>
                        <select name="role" class="form-select" required>
                            <option value="ROLE_STUDENT">Student</option>
                            <option value="ROLE_FACULTY">Faculty</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Pre-Allocated Candidate Name (Optional)</label>
                        <input type="text" name="allocatedName" class="form-control" placeholder="e.g. Admitted Student Name">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-dark small">Department / Program</label>
                        <input type="text" name="department" class="form-control" placeholder="e.g. Computer Science & Engineering" value="Computer Science">
                    </div>
                </div>
                <div class="modal-footer bg-light p-3">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">Save Authorized ID</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
