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
<!DOCTYPE html>
<html>

<head>
   <link rel="shortcut icon" href="../img/baker-removebg-preview.png" />
   <meta charset="utf-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
   <title>Admin</title>
   <link rel="stylesheet" href="css/bootstrap.min.css" />
   <link rel="stylesheet" href="css/font-awesome.min.css" />
   <link rel="stylesheet" href="main.css" />
</head>

<body>
   <label for="trigger" class="lab">
      <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-justify" fill="currentColor"
         xmlns="http://www.w3.org/2000/svg">
         <path fill-rule="evenodd"
            d="M2 12.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z" />
      </svg>
   </label>
   <div class="container-fluid">
      <div class="row">
         <input id="trigger" type="checkbox">
         <div class="col-xl-2 col-lg-3 col-md-4  sidebar shadow-lg">
            <ul class="m-2 p-2">
               <li><a href="index.jsp">Cars</a></li>
                <li><a href="insertCar.jsp">Insert Cars</a></li>
               <li><a href="Users.jsp"> </i>Users</a></li>
               <li><a href="rentedCars.jsp"> </i>Rented Cars</a></li>
       <li><a href="../logout.jsp"> </i>Logout</a></li>



            </ul>
         </div>
         <div class="col-xl-10 col-lg-9 col-md-8 ml-auto main1 ">
            <div class="container-fluid">





     