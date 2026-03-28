 <!-- <jsp:include page="header.jsp"></jsp:include>

 <form action="/register" method="post">
    name: <input type="text" name="name" />
    <br />
    Email: <input type="text" name="email" />
    <br />
    Mobile: <input type="text" name="mobile" />
    <br />
    Password: <input type="text" name="password" />
    <br />
    Role: <input type="radio" name="role" value="student"/> Student
    <input type="radio" name="role" value="faculty"/> Faculty
    <br />
    <input type="submit" value="save" /> 
  </form>

  ${sms}
<jsp:include page="footer.jsp"></jsp:include> -->





<jsp:include page="header.jsp"></jsp:include>

<style>
  .btn-register {
    font-size: 0.9rem;
    letter-spacing: 0.05rem;
    padding: 0.75rem 1rem;
  }

  .btn-google {
    color: white !important;
    background-color: #ea4335;
  }

  .btn-facebook {
    color: white !important;
    background-color: #3b5998;
  }
</style>

<div class="container">
  <div class="row">
    <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
      <div class="card border-0 shadow rounded-3 my-5">
        <div class="card-body p-4 p-sm-5">
          <h5 class="card-title text-center mb-5 fw-light fs-5">Sign-Up</h5>

      <form action="/register" method="post">

            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="floatingName" name="name" placeholder="Full Name">
              <label for="floatingName">Full Name</label>
            </div>

            <div class="form-floating mb-3">
              <input type="email" class="form-control" id="floatingEmail" name="email"  placeholder="name@example.com">
              <label for="floatingEmail">Email address</label>
            </div>
            <div class="form-floating mb-3">
              <input type="mobile" class="form-control" id="floatingEmail" name="mobile"  placeholder="name@example.com">
              <label for="floatingMobile">Phone Number</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" id="floatingPassword"  name="password" placeholder="Password">
              <label for="floatingPassword">Password</label>
            </div>

  <div class="form-floating mb-3">
 Role: <input type="radio" name="role" value="student"/> Student
    <input type="radio" name="role" value="faculty"/> Faculty
               </div>


               ${sms}


            <div class="d-grid">
              <button class="btn btn-primary btn-register text-uppercase fw-bold" type="submit">
                Register
              </button>
            </div>
          
            <hr class="my-4">

            <div class="d-grid mb-2">
              <button class="btn btn-google btn-register text-uppercase fw-bold" type="submit">
                <i class="fab fa-google me-2"></i> Sign up with Google
              </button>
            </div>

            <div class="d-grid">
              <button class="btn btn-facebook btn-register text-uppercase fw-bold" type="submit">
                <i class="fab fa-facebook-f me-2"></i> Sign up with Facebook
              </button>
            </div>

            <div class="text-center mt-3">
              <small>
                Already have an account?
                <a href="login.jsp">Sign In</a>
              </small>
            </div>

          </form>

        </div>
      </div>
    </div>
  </div>
</div>

  ${sms} 