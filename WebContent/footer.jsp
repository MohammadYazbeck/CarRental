<style>
  .footer {
    background-color: #333333;
    padding: 40px 0;
    color: white;
  }

  .footer-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
  }

  .footer-section {
    flex-basis: 50%;
    margin-bottom: 30px;
  }

  .footer-section h3 {
    font-size: 20px;
    margin-bottom: 20px;
  }

  .footer-section p {
    margin-bottom: 10px;
    display: flex;
    align-items: center;
  }

  .footer-section p .label {
    margin-right: 5px;
    color: white;
  }

  .social-icons {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .social-icons li {
    margin-right: 10px;
  }

  .social-icons a {
    color: white;
    display: flex;
    align-items: center;
    text-decoration: none;
  }
</style>

<div class="footer">
  <div class="container">
    <div class="footer-content">
      <div class="footer-section">
        <h3>Contact Information</h3>
        <p><span class="label">Email:</span> <a href="mailto:plproject@aiu.edu">plproject@aiu.edu</a></p>
        <p><span class="label">Phone:</span> 123-456-7890</p>
        <p><span class="label">Address:</span> Damascus, Syria</p>
      </div>
      <div class="footer-section">
        <h3>Social Accounts</h3>
        <ul class="social-icons">
          <li><a href="#"><i class="fab fa-facebook"></i> Facebook</a></li>
          <li><a href="#"><i class="fab fa-twitter"></i> Twitter</a></li>
          <li><a href="#"><i class="fab fa-instagram"></i> Instagram</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
