<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
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

    try {
        Class.forName(driverName);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String CARID = request.getParameter("id");
%>

<%
try {
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    statement = connection.prepareStatement("UPDATE Cars SET C_IMG = ?, C_BRAND = ?, C_YEAR = ?, C_Desc = ?, C_Status = ?, U_ID = ?, PD = ?, PM = ? WHERE C_ID = ?");

    // Set the values for the parameters
    String C_IMG = request.getParameter("C_IMG");
    String C_BRAND = request.getParameter("C_BRAND");
    String C_YEAR = request.getParameter("C_YEAR");
    String C_Desc = request.getParameter("C_Desc");
    String C_Status = request.getParameter("C_Status");
    String PD = request.getParameter("PD");
    String PM = request.getParameter("PM");
    String U_ID = request.getParameter("U_ID");
    int carId = Integer.parseInt(CARID); // Convert CARID to an integer

    statement.setString(1, C_IMG);
    statement.setString(2, C_BRAND);
    statement.setString(3, C_YEAR);
    statement.setString(4, C_Desc);
    statement.setString(5, C_Status);
    statement.setString(6, U_ID);
    statement.setString(7, PD);
    statement.setString(8, PM);
    statement.setInt(9, carId); // Set the value for the C_ID parameter

    // Execute the statement
    int rowsAffected = statement.executeUpdate();

    // Redirect to another page if update is successful
    if (rowsAffected > 0) {
        response.sendRedirect("index.jsp"); // Replace "index.jsp" with the desired destination page
    } else {
        response.sendRedirect("failure.jsp"); // Replace "failure.jsp" with the desired destination page if no rows were updated
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

<%
try {
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    statement = connection.prepareStatement("SELECT * FROM Cars WHERE C_ID = ?");
    statement.setInt(1, Integer.parseInt(CARID)); // Convert the CARID to an integer and set the parameter

    resultSet = statement.executeQuery();
    while (resultSet.next()) {
%>
<br>
<h2 align="center"><font><strong> Update Car Information</strong></font></h2><br>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <form method="post" action="">
                    <table class="table">
                        <tr>
                            <td>
                                <label for="C_IMG">Image:</label>
                                <input type="text" name="C_IMG" id="C_IMG" class="form-control" value="<%= resultSet.getString("C_IMG") != null ? resultSet.getString("C_IMG") : "" %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="C_BRAND">Brand:</label>
                                <input type="text" name="C_BRAND" id="C_BRAND" class="form-control" value="<%= resultSet.getString("C_BRAND") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="C_YEAR">Year:</label>
                                <input type="text" name="C_YEAR" id="C_YEAR" class="form-control" value="<%= resultSet.getString("C_YEAR") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="C_Desc">Description:</label>
                                <input type="text" name="C_Desc" id="C_Desc" class="form-control" value="<%= resultSet.getString("C_Desc") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="C_Status">Status:</label>
                                <select name="C_Status" id="C_Status" class="form-control" required>
                                    <option value="Available" <%= resultSet.getString("C_Status").equals("Available") ? "selected" : "" %>>Available</option>
                                    <option value="Rented" <%= resultSet.getString("C_Status").equals("Rented") ? "selected" : "" %>>Rented</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="PD">Price Per Day:</label>
                                <input type="text" name="PD" id="PD" class="form-control" value="<%= resultSet.getString("PD") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="PM">Price Per Month:</label>
                                <input type="text" name="PM" id="PM" class="form-control" value="<%= resultSet.getString("PM") %>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" value="Submit" class="btn btn-primary">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden" name="U_ID" id="PM" value="<%= resultSet.getString("U_ID") %>" required>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
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
