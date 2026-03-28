<jsp:include page="aheader.jsp"></jsp:include>

<div class="container py-5">
  <h2 class="text-center mb-4">Frequently Asked Questions</h2>

  <div class="accordion" id="faqAccordion">

    <div class="accordion-item">
      <h2 class="accordion-header">
        <button class="accordion-button" type="button"
          data-bs-toggle="collapse" data-bs-target="#faq1">
          What services do you provide?
        </button>
      </h2>
      <div id="faq1" class="accordion-collapse collapse show"
           data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          We provide web development, design, and IT-related services.
        </div>
      </div>
    </div>

    <div class="accordion-item">
      <h2 class="accordion-header">
        <button class="accordion-button collapsed" type="button"
          data-bs-toggle="collapse" data-bs-target="#faq2">
          How can I contact you?
        </button>
      </h2>
      <div id="faq2" class="accordion-collapse collapse"
           data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          You can contact us using the Contact page form or email us directly.
        </div>
      </div>
    </div>

    <div class="accordion-item">
      <h2 class="accordion-header">
        <button class="accordion-button collapsed" type="button"
          data-bs-toggle="collapse" data-bs-target="#faq3">
          Do you support after project delivery?
        </button>
      </h2>
      <div id="faq3" class="accordion-collapse collapse"
           data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          Yes, we provide support and maintenance after delivery.
        </div>
      </div>
    </div>

    <div class="accordion-item">
      <h2 class="accordion-header">
        <button class="accordion-button collapsed" type="button"
          data-bs-toggle="collapse" data-bs-target="#faq4">
          Is your service paid or free?
        </button>
      </h2>
      <div id="faq4" class="accordion-collapse collapse"
           data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          Our services are paid, pricing depends on project requirements.
        </div>
      </div>
    </div>

  </div>
</div>

<jsp:include page="afooter.jsp"></jsp:include>
