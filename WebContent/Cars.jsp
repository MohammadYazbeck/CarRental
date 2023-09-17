<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<jsp:include page="inc.jsp" />

<head>

<style>
  .container {
    width: 1000px;
    margin-left: auto;
    margin-right: auto;
  }

  .row {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }

  .grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    grid-gap: 20px;
    justify-items: center;
    margin-top: 20px;
  }

  .grid-item {
    width: 100%;
    padding: 20px;
    background-color: #f8f8f8;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
  }

  .grid-item:hover {
    transform: translateY(-5px);
  }

  .car-image {
    height: 200px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 10px;
  }

  .car-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: cover;
  }

  .car-details h3 {
    margin-top: 0;
    font-size: 40px;
  }

  .car-details p {
    margin: 5px 0;
  }

  .car-details a {
    display: inline-block;
    padding: 8px 16px;
    background-color: #0095FF;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
  }

  .car-details a:hover {
    background-color: #0076d6;
  }
</style>

</head>
<div style="width:1000px; margin-left: auto;margin-right: auto"class="container">
  <div class="row">
     <div class="grid-container">
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
              String sql = "SELECT * FROM Cars Where C_Status = 'Available'";
              ResultSet resultSet = statement.executeQuery(sql);
              while (resultSet.next()) {
                String encodedId = URLEncoder.encode(resultSet.getString("C_ID"), "UTF-8");
          %>
			<div class="grid-item">
			  <div class="car-image">
			    <img src="<%=resultSet.getString("C_IMG") %>" alt="Car Image">
			  </div>
			  <div class="car-details">
			    <h3><%=resultSet.getString("C_BRAND") %></h3>
			    <p>Year: <%=resultSet.getString("C_YEAR") %></p>
			    <a href="carDetails.jsp?id=<%=encodedId %>">Check</a>
			  </div>
			</div>

          <%
              }
              connection.close();
            } catch (Exception e) {
              e.printStackTrace();
            }
          %>
          



</div>
          
     
  </div>
</div>
<footer>
<jsp:include page="footer.jsp" />
</footer>
