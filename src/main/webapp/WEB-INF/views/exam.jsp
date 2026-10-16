<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <h2>Take the Exam</h2>
    <form action="/submitExam" method="post">
        <c:forEach var="q" items="${questions}">
            <p><strong>${q.question}</strong></p>
            <input type="radio" name="answer${q.id}" value="A"> ${q.optionA} <br>
            <input type="radio" name="answer${q.id}" value="B"> ${q.optionB} <br>
            <input type="radio" name="answer${q.id}" value="C"> ${q.optionC} <br>
            <input type="radio" name="answer${q.id}" value="D"> ${q.optionD} <br>
            <hr>
        </c:forEach>
        <button type="submit" class="btn btn-primary">Submit Exam</button>
    </form>
</div>