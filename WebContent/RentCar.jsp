<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%
// Get the car ID from the request parameter
String carId = request.getParameter("id");

// Get the user ID from the session (assuming it is stored as "userId")
String userId = (String) session.getAttribute("username");

// Check if carId and userId are not null or empty
if (carId != null && !carId.isEmpty() && userId != null && !userId.isEmpty()) {
    try {
        // Establish a database connection (assuming you have set up your MySQL connection)
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/carrentaldb", "root", "");
        
        // Create the SQL update statement
        String updateQuery = "UPDATE Cars SET C_Status = ?, U_ID = ? WHERE C_ID = ?";
        
        // Prepare the statement
        PreparedStatement statement = connection.prepareStatement(updateQuery);
        
        // Set the values for the statement
        statement.setString(1, "Rented");
        statement.setString(2, userId);
        statement.setString(3, carId);
        
        // Execute the update statement
        statement.executeUpdate();
        
        // Close the statement and database connection
        statement.close();
        connection.close();
        
        // Redirect to index.jsp
        response.sendRedirect("index.jsp");
        
    } catch (SQLException e) {
        e.printStackTrace(); // Handle or log any exceptions
    }
} else {
    // Handle invalid carId or userId values
    // Redirect to an error page or display an error message
    response.sendRedirect("error.jsp");
}
%>
