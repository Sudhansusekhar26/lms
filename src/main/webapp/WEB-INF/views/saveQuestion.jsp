<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<div class="card p-4 shadow">
    <h3>Add Question</h3>
    <form action="${pageContext.request.contextPath}/saveQuestion" method="post">
        <div class="mb-3">
            <label>Question</label>
            <input type="text" name="question" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Option A</label><input type="text" name="optionA" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Option B</label><input type="text" name="optionB" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Correct Answer</label>
            <select name="correctAnswer" class="form-control" required>
                <option value="A">Option A</option>
                <option value="B">Option B</option>
                <option value="C">Option C</option>
                <option value="D">Option D</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Save Question</button>
    </form>
</div>