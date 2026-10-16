<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Question Management</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

    <!-- Add Question Form -->
    <div class="card p-4 shadow">
        <h3 class="mb-3">Add Question</h3>

        <form action="${pageContext.request.contextPath}/saveQuestion" method="post">

            <div class="mb-3">
                <label>Question</label>
                <input type="text" name="question" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Option A</label>
                <input type="text" name="optionA" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Option B</label>
                <input type="text" name="optionB" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Option C</label>
                <input type="text" name="optionC" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Option D</label>
                <input type="text" name="optionD" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Correct Answer</label>
                <select name="correctAnswer" class="form-control" required>
                    <option value="">-- Select --</option>
                    <option value="A">Option A</option>
                    <option value="B">Option B</option>
                    <option value="C">Option C</option>
                    <option value="D">Option D</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success">Save Question</button>
        </form>
    </div>

    <!-- Question List -->
    <div class="card p-4 shadow mt-4">
        <h3 class="mb-3">All Questions</h3>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Question</th>
                    <th>A</th>
                    <th>B</th>
                    <th>C</th>
                    <th>D</th>
                    <th>Answer</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="q" items="${questions}">
                    <tr>
                        <td>${q.id}</td>
                        <td>${q.question}</td>
                        <td>${q.optionA}</td>
                        <td>${q.optionB}</td>
                        <td>${q.optionC}</td>
                        <td>${q.optionD}</td>
                        <td><b>${q.correctAnswer}</b></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/editQuestion/${q.id}" 
                               class="btn btn-warning btn-sm">Edit</a>

                            <a href="${pageContext.request.contextPath}/deleteQuestion/${q.id}" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </div>

</div>

</body>
</html>