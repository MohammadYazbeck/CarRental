<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<jsp:include page="header.jsp" />

<%
    // Retrieve the role from the session
    String role = (String) session.getAttribute("role");

    // Check if the role is not admin
    if (role == null || !role.equalsIgnoreCase("Admin")) {
        // Redirect to another page or display an error message
        response.sendRedirect("../login.jsp");
        return; // Added this line to prevent further execution of the page
    }

    String id = request.getParameter("userId");
    String driverName = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String dbName = "carrentaldb";
    String userId = "root";
    String password = "";

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName(driverName);
        connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
        statement = connection.createStatement();
        String sql = "SELECT * FROM Cars WHERE C_Status = 'Rented'";
        resultSet = statement.executeQuery(sql);
%>
<br>
<h2 align="center"><font><strong> Rented Cars</strong></font></h2><br>
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
    <%
        while (resultSet.next()) {
    %>
        <tr>
            <td><img width="200px" src=<%=resultSet.getString("C_IMG") %> /></td>
            <td><%=resultSet.getString("C_BRAND") %></td>
            <td><%=resultSet.getString("C_YEAR") %></td>
            <td><a href="../carDetails.jsp?id=<%=resultSet.getString("C_ID") %>">Check</a></td>
            <td><a href="updateCarForm.jsp?id=<%=resultSet.getString("C_ID") %>">Update</a></td>
            <td><a href="deleteCar.jsp?id=<%=resultSet.getString("C_ID") %>">Delete</a></td>
        </tr>
    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
    // End of try-catch-finally block
%>
    </tbody>
</table>
</body>
</html>
