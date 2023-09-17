<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<jsp:include page="inc.jsp" />

<style>
  body {
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }

  .slider {
    margin-bottom: 40px;
  }

  .slider .carousel-item {
    height: 600px;
  }

  .slider .carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .about-us {
    background-color: #f8f9fa;
    padding: 40px;
    margin-bottom: 40px;
  }

  .contact-us {
    background-color: #f8f9fa;
    padding: 40px;
    margin-bottom: 40px;
  }

  .footer {
    background-color: #333333;
    color: white;
    padding: 20px 0;
    text-align: center;
  }
</style>

<div class="container">
  <div id="slider" class="carousel slide slider" data-ride="carousel">
    <ol class="carousel-indicators">
      <%@page import="java.net.URLEncoder" %>

      <% 
        String id = request.getParameter("userId");
        String driverName = "com.mysql.jdbc.Driver";
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String dbName = "carrentaldb";
        String userId = "root";
        String password = "";

        try {
          Class.forName(driverName);
          Connection connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
          Statement statement = connection.createStatement();
          String sql = "SELECT * FROM Cars WHERE C_Status = 'Available' ORDER BY C_ID LIMIT 3";
          ResultSet resultSet = statement.executeQuery(sql);
          int slideIndex = 0;
          while (resultSet.next()) {
            String encodedId = URLEncoder.encode(resultSet.getString("C_ID"), "UTF-8");
      %>
      <li data-target="#slider" data-slide-to="<%=slideIndex %>" <%= slideIndex == 0 ? "class='active'" : "" %>></li>
      <% 
          slideIndex++;
        }
        connection.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
      %>
    </ol>

    <div class="carousel-inner">
      <% 
        try {
          Class.forName(driverName);
          Connection connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
          Statement statement = connection.createStatement();
          String sql = "SELECT * FROM Cars WHERE C_Status = 'Available' ORDER BY C_ID LIMIT 3";
          ResultSet resultSet = statement.executeQuery(sql);
          int slideIndex = 0;
          while (resultSet.next()) {
            String encodedId = URLEncoder.encode(resultSet.getString("C_ID"), "UTF-8");
      %>
      <div class="carousel-item <%= slideIndex == 0 ? "active" : "" %>">
        <img src="<%=resultSet.getString("C_IMG") %>" alt="Slide <%=slideIndex+1 %>">
      </div>
      <% 
          slideIndex++;
        }
        connection.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
      %>
    </div>

    <a class="carousel-control-prev" href="#slider" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#slider" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>

  <div class="about-us">
    <h2>About Us</h2>
    <p>Our website provides many choices to satisfy your preferences. We have the best cars for people with different preferences. Choose from a wide range of vehicles and enjoy a comfortable and reliable rental experience.</p>
  </div>

  <div class="contact-us">
    <h2>Contact Us</h2>
    <form>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" class="form-control" id="email" placeholder="Enter your email">
      </div>
      <div class="form-group">
        <label for="message">Message</label>
        <textarea class="form-control" id="message" rows="4" placeholder="Enter your message"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
  </div>


</div>
  <footer class="footer">
    <jsp:include page="footer.jsp" />
  </footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script>
  $(document).ready(function() {
    $('.carousel').carousel();
  });
</script>
