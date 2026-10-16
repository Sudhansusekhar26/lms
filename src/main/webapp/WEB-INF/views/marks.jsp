<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Exam Results</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2 class="text-center mb-4">Exam Results</h2>

    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Total</th>
                <th>Correct</th>
                <th>Wrong</th>
                <th>Marks</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="r" items="${results}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.total}</td>
                    <td class="text-success">${r.correct}</td>
                    <td class="text-danger">${r.wrong}</td>
                    <td><b>${r.marks}</b></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="text-center">
        <a href="/exam" class="btn btn-primary">Back to Exam</a>
    </div>

</div>

</body>
</html>