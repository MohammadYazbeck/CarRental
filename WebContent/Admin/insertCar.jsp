<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
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
%>
<%
    String driverName = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String dbName = "carrentaldb";
    String username = "root";
    String password = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    if (request.getMethod().equalsIgnoreCase("post")) {
        String C_IMG = request.getParameter("C_IMG");
        String C_BRAND = request.getParameter("C_BRAND");
        String C_YEAR = request.getParameter("C_YEAR");
        String C_Desc = request.getParameter("C_Desc");
        String C_Status = request.getParameter("C_Status");
        String PD = request.getParameter("PD");
        String PM = request.getParameter("PM");
        try {
            Class.forName(driverName);
            conn = DriverManager.getConnection(connectionUrl + dbName, username, password);

            String sql = "INSERT INTO cars (C_IMG, C_BRAND, C_YEAR, C_Desc,C_Status ,U_ID ,PD ,PM  ) VALUES (?, ?, ? ,? ,? ,?,?,?)";
            pstmt = conn.prepareStatement(sql);

            // Set values for the parameters
            pstmt.setString(1, C_IMG);
            pstmt.setString(2, C_BRAND);
            pstmt.setString(3, C_YEAR);
            pstmt.setString(4, C_Desc);
            pstmt.setString(5, C_Status);
            pstmt.setString(6, "0");
            pstmt.setString(7, PD);
            pstmt.setString(8, PM);

            // Execute the query
            pstmt.executeUpdate();

            // Redirect to a success page or display a success message
            response.sendRedirect("index.jsp");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
<html>
<head>
    <title>Insert Form</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
<br>
<h2 align="center"><font><strong> Insert Car</strong></font></h2><br>
<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <form method="post" action="">
                <div class="form-group">
                    <label for="C_IMG">Image:</label>
                    <input type="text" name="C_IMG" id="C_IMG" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="C_BRAND">Brand:</label>
                    <input type="text" name="C_BRAND" id="C_BRAND" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="C_YEAR">Year:</label>
                    <input type="text" name="C_YEAR" id="C_YEAR" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="C_Desc">Description:</label>
                    <input type="text" name="C_Desc" id="C_Desc" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="C_Status">Status:</label>
                    <input type="text" name="C_Status" id="C_Status" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="PD">Price Per Day:</label>
                    <input type="text" name="PD" id="PD" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="PM">Price Per Month:</label>
                    <input type="text" name="PM" id="PM" class="form-control" required>
                </div>
                <div class="form-group">
                    <input type="submit" value="Submit" class="btn btn-primary">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>