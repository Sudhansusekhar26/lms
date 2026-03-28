<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">

    <div class="card shadow p-4">
        <h3 class="text-center mb-4">My Profile</h3>

        <form action="updateProfile" method="post" enctype="multipart/form-data">

            <div class="text-center mb-3">
                <img src="images/${user.photo}" 
                     class="rounded-circle" 
                     width="120" height="120">
            </div>

            <div class="mb-3">
                <label>Upload Photo</label>
                <input type="file" name="photoFile" class="form-control">
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>Name</label>
                    <input type="text" name="name" 
                           value="${user.name}" 
                           class="form-control">
                </div>

                <div class="col-md-6 mb-3">
                    <label>Roll No</label>
                    <input type="text" name="rollNo" 
                           value="${user.rollNo}" 
                           class="form-control">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>Branch</label>
                    <input type="text" name="branch" 
                           value="${user.branch}" 
                           class="form-control">
                </div>

                <div class="col-md-6 mb-3">
                    <label>Course</label>
                    <input type="text" name="course" 
                           value="${user.course}" 
                           class="form-control">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>Age</label>
                    <input type="number" name="age" 
                           value="${user.age}" 
                           class="form-control">
                </div>

                <div class="col-md-6 mb-3">
                    <label>Blood Group</label>
                    <input type="text" name="bloodGroup" 
                           value="${user.bloodGroup}" 
                           class="form-control">
                </div>
            </div>

            <div class="text-center mt-4">
                <button class="btn btn-primary">
                    Update Profile
                </button>
            </div>

        </form>
    </div>

</div>

</body>
</html>
