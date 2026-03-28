<jsp:include page="header.jsp"></jsp:include>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-6">

      <div class="bg-white p-4 rounded shadow-sm">

        <h3 class="text-center mb-4">Contact Us</h3>

        <form action="/contact" method="post">

          <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Mobile</label>
            <input type="text" name="mobile" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Message</label>
            <textarea name="message" rows="4" class="form-control" required></textarea>
          </div>

          <div class="d-grid">
            <button type="submit" class="btn btn-dark" >Send Message</button>
          </div>

        </form>

      </div>

    </div>
  </div>
</div>
${con}

<jsp:include page="footer.jsp"></jsp:include>
