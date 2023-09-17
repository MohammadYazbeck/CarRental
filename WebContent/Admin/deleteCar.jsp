<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%
try {
    // Register JDBC driver
    Class.forName("com.mysql.jdbc.Driver");
    
    // Open a connection
    String dbUrl = "jdbc:mysql://localhost:3306/carrentaldb";
    String dbUsername = "root";
    String dbPassword = "";
    Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
    
    String CARID = request.getParameter("id");

    // Create a SQL statement
    String sql = "DELETE FROM Cars WHERE C_ID = " + CARID;
    Statement statement = conn.createStatement();
    
    // Execute the statement
    int rowsAffected = statement.executeUpdate(sql);
    
    // Clean up resources
    statement.close();
    conn.close();
    
    // Redirect to another page if deletion is successful
    if (rowsAffected > 0) {
        response.sendRedirect("index.jsp"); // Replace "success.jsp" with the desired destination page
    } else {
         // Replace "failure.jsp" with the desired destination page if no rows were deleted
    }
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
}
%>
