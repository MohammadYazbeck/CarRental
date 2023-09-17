<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<jsp:include page="inc.jsp" />
<%
    String id = request.getParameter("userId");
    String driverName = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String dbName = "carrentaldb";
    String userId = "root";
    String password = "";

    try {
        Class.forName(driverName);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>

<%
    String CARID = request.getParameter("id");
%>
<div style="-webkit-box-shadow: -1px 4px 26px -4px rgba(0,0,0,0.75);
-moz-box-shadow: -1px 4px 26px -4px rgba(0,0,0,0.75);
box-shadow: -1px 4px 26px -4px rgba(0,0,0,0.75); border-radius: 30px; background-color: #fff;padding:40px; margin-left: auto; margin-right: auto; margin-top: 40px; width: 70% "> 
<%
    try {
        connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
        statement = connection.createStatement();
        String sql = "SELECT * FROM Cars WHERE C_ID = " + CARID;
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
%>
        
            <img width="100%" height="500px" src="<%= resultSet.getString("C_IMG") %>"/><br/><br/><br/><br/>
    
           <h1> Name:  <%= resultSet.getString("C_BRAND") %></h1><br/>
         <h3> Year Model:    <%= resultSet.getString("C_YEAR") %></h2><br/>
            <h3> Descreption :  <%= resultSet.getString("C_Desc") %></h2><br/>
            <h3> Status :   <%= resultSet.getString("C_Status") %></h2><br/>
               <h3> Price Per Day : <%= resultSet.getString("PD") %></h2><br/>
               <h3> Price Per Month :  <%= resultSet.getString("PM") %></h2><br/>
               <% String role1=(String) session.getAttribute("role");if(role1 !=null){ %>
<a style="background-color: #0095FF;" href="RentCar.jsp?id=<%= resultSet.getString("C_ID") %>">Rent</a>
<%}else{} %>
      </div>
     
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources in reverse order
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>
<jsp:include page="footer.jsp" />