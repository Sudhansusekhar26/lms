<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Instructor Broadcast Studio - ${liveClass.title}" />
</jsp:include>

<div class="container-fluid py-3 px-lg-4 bg-dark text-white min-vh-100 d-flex flex-column">
    <!-- Live Header Bar -->
    <div class="card border-0 rounded-4 p-3 bg-black bg-opacity-50 border border-secondary border-opacity-25 mb-3 text-white">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <a href="/faculty/live" class="btn btn-outline-light btn-sm rounded-pill"><i class="fa-solid fa-arrow-left me-1"></i> Exit Studio</a>
                <div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-danger rounded-pill"><i class="fa-solid fa-tower-broadcast me-1 animate-pulse"></i> INSTRUCTOR BROADCAST</span>
                        <h5 class="fw-bold mb-0 text-white">${liveClass.title}</h5>
                    </div>
                    <span class="text-secondary small">${liveClass.course.title} &bull; Room: <code>${liveClass.roomId}</code></span>
                </div>
            </div>
            <div class="d-flex align-items-center gap-2">
                <form action="/faculty/live/${liveClass.id}/status" method="POST" class="d-inline">
                    <input type="hidden" name="status" value="COMPLETED">
                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3">
                        <i class="fa-solid fa-stop me-1"></i> End Stream & Complete
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- WebRTC Broadcaster Studio Container -->
    <div class="row g-3 flex-grow-1">
        <div class="col-lg-9">
            <div class="card border-0 rounded-4 overflow-hidden bg-black shadow-lg h-100" style="min-height: 550px;">
                <div id="jitsi-container" class="w-100 h-100 position-relative">
                    <iframe src="https://meet.jit.si/LMS_Live_${liveClass.roomId}#userInfo.displayName=%22Prof.%20${userName}%22"
                            allow="camera; microphone; fullscreen; display-capture; autoplay"
                            class="w-100 h-100 border-0 rounded-4"
                            style="min-height: 550px;">
                    </iframe>
                </div>
            </div>
        </div>

        <div class="col-lg-3">
            <div class="card border-0 rounded-4 p-4 bg-black bg-opacity-40 border border-secondary border-opacity-25 text-white h-100 d-flex flex-column">
                <h6 class="fw-bold mb-3 text-cyan"><i class="fa-solid fa-sliders me-2"></i> Broadcast Controls</h6>
                <p class="text-secondary small leading-relaxed mb-4">
                    As the host instructor, you can share screen slides, record the session, and manage attendee participants.
                </p>

                <div class="p-3 rounded-3 bg-white bg-opacity-5 border border-secondary border-opacity-25 mb-4 small">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-secondary">Meeting URL:</span>
                        <a href="https://meet.jit.si/LMS_Live_${liveClass.roomId}" target="_blank" class="text-cyan text-decoration-none">Direct Link <i class="fa-solid fa-up-right-from-square fs-8"></i></a>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-secondary">Stream Status:</span>
                        <span class="badge bg-danger">ON AIR</span>
                    </div>
                </div>

                <div class="mt-auto">
                    <a href="/faculty/courses/${liveClass.course.id}/builder" class="btn btn-outline-primary btn-sm w-100 rounded-pill">
                        <i class="fa-solid fa-book me-1"></i> Course Syllabus Studio
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
