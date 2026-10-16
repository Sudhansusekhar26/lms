<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Study Material Management - Admin - Cloud LMS" />
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
                <jsp:param name="active" value="materials" />
            </jsp:include>
        </div>

        <!-- Main Content Area -->
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 p-4 mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
                    <div>
                        <h4 class="fw-bold text-navy mb-1"><i class="fa-solid fa-file-pdf text-danger me-2"></i> Study Material Management</h4>
                        <p class="text-muted small mb-0">Monitor, audit, and moderate lecture notes, PDF study guides, video embeds, and documents across all courses.</p>
                    </div>
                    <span class="badge bg-primary bg-opacity-10 text-primary fs-7 fw-bold px-3 py-2 rounded-pill">
                        <i class="fa-solid fa-folder-open me-1"></i> ${lessons.size()} Material Items
                    </span>
                </div>

                <!-- Material Items Table -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle border mb-0">
                        <thead class="table-light">
                            <tr class="fs-8 text-uppercase text-muted">
                                <th>Lesson / Course</th>
                                <th>Attached PDF / Document</th>
                                <th>Video URL</th>
                                <th>Duration</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${lessons}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-dark">${l.title}</div>
                                        <div class="small text-muted">${l.section.course.title} &bull; ${l.section.title}</div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty l.materialUrl}">
                                                <a href="${l.materialUrl}" target="_blank" class="badge bg-danger bg-opacity-10 text-danger text-decoration-none px-2.5 py-1.5 rounded-pill">
                                                    <i class="fa-solid fa-file-pdf me-1"></i> ${not empty l.materialName ? l.materialName : 'Syllabus-Notes.pdf'}
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-muted border">No PDF Attached</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty l.videoUrl}">
                                                <a href="${l.videoUrl}" target="_blank" class="badge bg-primary bg-opacity-10 text-primary text-decoration-none px-2.5 py-1.5 rounded-pill">
                                                    <i class="fa-solid fa-video me-1"></i> Lecture Stream
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-muted border">Text Only</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small text-muted fw-bold">${l.durationMinutes} min</td>
                                    <td class="text-end">
                                        <div class="d-inline-flex gap-1">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-2.5" data-bs-toggle="modal" data-bs-target="#editMaterialModal${l.id}" title="Edit Material">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </button>
                                            <form action="/admin/materials/${l.id}/delete" method="POST" class="d-inline" onsubmit="return confirm('Remove material for lesson: ${l.title}?');">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2.5" title="Remove Material">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>

                                        <!-- Edit Material Modal -->
                                        <div class="modal fade text-start" id="editMaterialModal${l.id}" tabindex="-1">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow-lg rounded-4">
                                                    <div class="modal-header bg-primary text-white p-3 px-4 rounded-top-4">
                                                        <h6 class="modal-title fw-bold"><i class="fa-solid fa-pen-to-square me-2"></i> Update Material: ${l.title}</h6>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="/admin/materials/${l.id}/update" method="POST">
                                                        <div class="modal-body p-4">
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-bold">Document Name</label>
                                                                <input type="text" name="materialName" class="form-control rounded-3" value="${l.materialName}" placeholder="e.g. Java-M1-LectureNotes.pdf">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-bold">Document / PDF URL</label>
                                                                <input type="text" name="materialUrl" class="form-control rounded-3" value="${l.materialUrl}" placeholder="https://.../notes.pdf">
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer bg-light border-0 p-3 rounded-bottom-4">
                                                            <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Save Changes</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
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

<jsp:include page="../footer.jsp" />
