<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
// Retrieve the role from the session
String role = (String) session.getAttribute("role");

// Check if the role is not admin
if (role == null || !role.equalsIgnoreCase("Admin")) {
    // Redirect to another page or display an error message
    response.sendRedirect("../login.jsp");
    return; // Added this line to prevent further execution of the page
}
%>
<jsp:include page="header.jsp" />


<div class="container">
  <div class="row">
    <div class="col-md-12">
      <table class="table text-center">
        <thead>
          <tr>
            <th>Image</th>
            <th>Brand</th>
            <th>Year</th>
            <th> </th>
            <th> </th>
            <th> </th>
          </tr>
        </thead>
        <tbody>
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
              String sql = "SELECT * FROM Cars";
              ResultSet resultSet = statement.executeQuery(sql);
              while (resultSet.next()) {
                String encodedId = URLEncoder.encode(resultSet.getString("C_ID"), "UTF-8");
          %>
          <tr>
            <td><img width="250px" src=<%=resultSet.getString("C_IMG") %>></td>
            <td style="padding-bottom:50px;padding-top:50px; font-size:30px"><%=resultSet.getString("C_BRAND") %></td>
          <td style="padding-bottom:50px;padding-top:50px; font-size:30px"><%=resultSet.getString("C_YEAR") %></td>
           <td style="padding-bottom:50px;padding-top:50px; font-size:30px"><a class="btn btn-primary" 	href="../carDetails.jsp?id=<%=encodedId %>">Check</a></td>
            <td style="padding-bottom:50px;padding-top:50px; font-size:30px"><a class="btn btn-primary"	 href="updateCarForm.jsp?id=<%=encodedId %>">Update</a></td>
            <td style="padding-bottom:50px;padding-top:50px; font-size:30px"><a  class="btn btn-primary"	href="deleteCar.jsp?id=<%=encodedId %>">Delete</a></td>
          </tr>
          <%
              }
              connection.close();
            } catch (Exception e) {
              e.printStackTrace();
            }
          %>
        </tbody>
      </table>
    </div>
  </div>
</div>
