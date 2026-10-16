<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="${liveClass.title} - Live Classroom" />
</jsp:include>

<div class="container-fluid py-3 px-lg-4 bg-dark text-white min-vh-100 d-flex flex-column">
    <!-- Live Header Bar -->
    <div class="card border-0 rounded-4 p-3 bg-black bg-opacity-50 border border-secondary border-opacity-25 mb-3 text-white">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <a href="/student/live" class="btn btn-outline-light btn-sm rounded-pill"><i class="fa-solid fa-arrow-left me-1"></i> Leave Room</a>
                <div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-danger rounded-pill"><i class="fa-solid fa-circle me-1 animate-pulse"></i> LIVE WEBRTC</span>
                        <h5 class="fw-bold mb-0 text-white">${liveClass.title}</h5>
                    </div>
                    <span class="text-secondary small">${liveClass.course.title} &bull; Instructor: ${liveClass.instructorEmail}</span>
                </div>
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="badge bg-secondary bg-opacity-50 text-white px-3 py-2 rounded-pill">
                    <i class="fa-solid fa-key me-1 text-warning"></i> Room: ${liveClass.roomId}
                </span>
            </div>
        </div>
    </div>

    <!-- WebRTC Virtual Classroom Embed Container -->
    <div class="row g-3 flex-grow-1">
        <div class="col-lg-9">
            <div class="card border-0 rounded-4 overflow-hidden bg-black shadow-lg h-100" style="min-height: 550px;">
                <div id="jitsi-container" class="w-100 h-100 position-relative">
                    <iframe src="https://meet.jit.si/LMS_Live_${liveClass.roomId}#userInfo.displayName=%22${userName}%22"
                            allow="camera; microphone; fullscreen; display-capture; autoplay"
                            class="w-100 h-100 border-0 rounded-4"
                            style="min-height: 550px;">
                    </iframe>
                </div>
            </div>
        </div>

        <!-- Class Agenda & Q&A Sidebar -->
        <div class="col-lg-3">
            <div class="card border-0 rounded-4 p-4 bg-black bg-opacity-40 border border-secondary border-opacity-25 text-white h-100 d-flex flex-column">
                <h6 class="fw-bold mb-3 text-cyan"><i class="fa-solid fa-chalkboard me-2"></i> Session Outline</h6>
                <p class="text-secondary small leading-relaxed mb-4">
                    ${liveClass.description != null ? liveClass.description : 'Live lecture and collaborative architectural coding session.'}
                </p>

                <div class="p-3 rounded-3 bg-white bg-opacity-5 border border-secondary border-opacity-25 mb-4 small">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-secondary">Expected Duration:</span>
                        <strong class="text-white">${liveClass.durationMinutes} Minutes</strong>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-secondary">Security Protocol:</span>
                        <span class="badge bg-success">End-to-End Encrypted</span>
                    </div>
                </div>

                <div class="mt-auto pt-3 border-top border-secondary border-opacity-25">
                    <a href="/student/courses/${liveClass.course.id}/learn" class="btn btn-outline-primary btn-sm w-100 rounded-pill mb-2">
                        <i class="fa-solid fa-book me-1"></i> Open Course Syllabus
                    </a>
                    <a href="/student/live" class="btn btn-danger btn-sm w-100 rounded-pill">
                        <i class="fa-solid fa-phone-slash me-1"></i> End Call & Exit
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
