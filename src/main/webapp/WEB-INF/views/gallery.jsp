<jsp:include page="header.jsp"></jsp:include>


  <style>
    .gallery-img {
      width: 100%;
      height: 230px;
      object-fit: cover;
      border-radius: 8px;
      transition: transform 0.3s ease;
      cursor: pointer;
    }

    .gallery-img:hover {
      transform: scale(1.05);
    }
  </style>


<div class="container py-5">

  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
    <div class="col">
      <img src="images/image1.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image2.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image3.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image4.jpeg" class="gallery-img" alt="">
    </div>
    <div class="col">
      <img src="images/image1.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image2.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image3.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image4.jpeg" class="gallery-img" alt="">
    </div>
    <div class="col">
      <img src="images/image1.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image2.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image3.jpg" class="gallery-img" alt="">
    </div>

    <div class="col">
      <img src="images/image4.jpeg" class="gallery-img" alt="">
    </div>
    

<!-- <div class="container py-4"> -->

  <!-- ROW IS REQUIRED -->
  <!-- <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

    <div class="col">
      <div class="card shadow-sm">
        <img src="images/image.jpg" class="card-img-top"
             height="225" style="object-fit:cover;" alt="">
      </div>
    </div>

    <div class="col">
      <div class="card shadow-sm">
        <img src="images/image1.jpeg" class="card-img-top"
             height="225" style="object-fit:cover;" alt="">
        
      </div>
    </div>

    <div class="col">
      <div class="card shadow-sm">
        <img src="images/image2.jpeg" class="card-img-top"
             height="225" style="object-fit:cover;" alt="">
        
      </div>
    </div> -->

  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>