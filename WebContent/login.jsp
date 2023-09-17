<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<% String role1=(String) session.getAttribute("role");
  if(role1!=null){ 
	  response.sendRedirect("index.jsp");
	  
  }%>
    <jsp:include page="inc.jsp" /> 
<%
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
    PreparedStatement statement = null;
    ResultSet resultSet = null;
%>

<%
    String username = request.getParameter("username");
    String password1 = request.getParameter("password");

    try {
        connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
        statement = connection.prepareStatement("SELECT * FROM Users WHERE username = ? AND password = ?");
        statement.setString(1, username);
        statement.setString(2, password1);

        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            // Authentication successful
            String role = resultSet.getString("role");
            // Save the role to the session
            session.setAttribute("role", role);
            session.setAttribute("username", username);
            // Redirect to the appropriate page based on the role
            if (role.equals("Admin")) {
                response.sendRedirect("Admin/index.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
            return; // Stop further execution of the page
        } else {
            // Authentication failed
           
        }
    } catch (Exception e) {
       
    } finally {
        // Close resources in reverse order
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (Exception e) {
                
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (Exception e) {
              
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (Exception e) {
               
            }
        }
    }
%>

<html>
<head>
    <title>Login Page</title>
    <style>
    <style>
body {font-family: Arial, Helvetica, sans-serif;}


input[type=text], input[type=password] {
  width: 700px;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
  
}

button {
  background-color: #0095FF;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 200px;
  margin-left: auto;
  margin-right:auto;
  display: block;
}

button:hover {
  opacity: 0.8;
}




.container {
  padding: 50px;
    margin-left: auto;
  margin-right:auto;
  width:700px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

    </style>
</head>
<body>

     <div class="container">
    <form method="post" action="">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required><br>

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required><br>

          <button type="submit">Login</button>
    </form></div>
</body>
</html>
<jsp:include page="footer.jsp" />