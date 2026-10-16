<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../header.jsp">
    <jsp:param name="title" value="Learning Analytics - Student Portal" />
</jsp:include>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container-fluid py-4 px-lg-5 bg-light min-vh-100">
    <div class="row g-4">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <jsp:include page="smenu.jsp">
                <jsp:param name="active" value="analytics" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="col-lg-9">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h4 class="fw-bold text-dark mb-1"><i class="fa-solid fa-chart-line me-2 text-info"></i> Learning Analytics & Competency Matrix</h4>
                <p class="text-muted small mb-4">Track your module completion rate, assessment accuracy, and academic milestones.</p>

                <!-- Metrics Row -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-primary mb-1">${totalCourses}</h3>
                            <span class="text-muted small">Enrolled Curricula</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-success mb-1">${completedCourses}</h3>
                            <span class="text-muted small">Completed Courses</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-warning mb-1">${totalQuizzesTaken}</h3>
                            <span class="text-muted small">Quizzes Evaluated</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-3 bg-light rounded-4 border text-center">
                            <h3 class="fw-extrabold text-info mb-1">${passedQuizzes}</h3>
                            <span class="text-muted small">Passed Assessments</span>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="card border rounded-4 p-4 shadow-none">
                            <h6 class="fw-bold text-dark mb-3">Course Completion Rates</h6>
                            <canvas id="courseProgressChart" height="220"></canvas>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card border rounded-4 p-4 shadow-none">
                            <h6 class="fw-bold text-dark mb-3">Assessment Score Distribution</h6>
                            <canvas id="quizScoresChart" height="220"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Course Progress Chart
    const courseCtx = document.getElementById('courseProgressChart').getContext('2d');
    const courseLabels = [];
    const courseData = [];

    <c:forEach var="enr" items="${enrollments}">
        courseLabels.push("${enr.course.title.length() > 20 ? enr.course.title.substring(0, 18).concat('...') : enr.course.title}");
        courseData.push(${enr.progressPct});
    </c:forEach>

    if (courseLabels.length === 0) {
        courseLabels.push("Sample Module");
        courseData.push(75);
    }

    new Chart(courseCtx, {
        type: 'bar',
        data: {
            labels: courseLabels,
            datasets: [{
                label: 'Progress %',
                data: courseData,
                backgroundColor: '#4f46e5',
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { min: 0, max: 100 }
            }
        }
    });

    // Quiz Score Chart
    const quizCtx = document.getElementById('quizScoresChart').getContext('2d');
    const quizLabels = [];
    const quizScores = [];

    <c:forEach var="sub" items="${submissions}">
        quizLabels.push("${sub.quiz.title.length() > 15 ? sub.quiz.title.substring(0, 12).concat('...') : sub.quiz.title}");
        quizScores.push(${sub.scorePct});
    </c:forEach>

    if (quizLabels.length === 0) {
        quizLabels.push("Distributed Systems Exam");
        quizScores.push(85);
    }

    new Chart(quizCtx, {
        type: 'line',
        data: {
            labels: quizLabels,
            datasets: [{
                label: 'Score %',
                data: quizScores,
                borderColor: '#10b981',
                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                fill: true,
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { min: 0, max: 100 }
            }
        }
    });
</script>

<jsp:include page="../footer.jsp" />
