<%@ page import="javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <style>
    body {
      margin: 0px;
      font-family: Arial;
      background-color: #F8F9FA;
    }
    ul {
      list-style-type: none;
      margin: 0;
      padding: 0;
      overflow: hidden;
      background-color: #333;
    }
    .grid-container {
      display: grid;
      grid-template-columns: auto auto auto;
      margin-top: 40px;
      width: 1200px;
    }
    .grid-item {
      background-color: #fff;
      border-radius: 30px;
      padding: 20px;
      width: 300px;
      -webkit-box-shadow: -1px 4px 26px -4px rgba(0,0,0,0.75);
      -moz-box-shadow: -1px 4px 26px -4px rgba(0,0,0,0.75);
      box-shadow: -1px 4px 26px -4px rgba(0,0,0,0.75);
    }
    li {
      float: left;
    }
    li a {
      display: block;
      color: white;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
    }
    a {
      display: block;
      color: white;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
    }
    li a:hover:not(.active) {
      background-color: #0095FF;
    }
    .active {
      background-color: #0095FF;
    }
  </style>
</head>
<body>
<%
  String selectedLanguage = "";
  Cookie[] cookies = request.getCookies();
  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if (cookie.getName().equals("language")) {
        selectedLanguage = cookie.getValue();
        break;
      }
    }
  }
  
  // Print the value of the cookie to the console
  System.out.println("Cookie value: " + selectedLanguage);
%>

<ul>  
  <li><img width="40px" src="logo.png"></li>
  <li><a href="index.jsp">Home</a></li>
  <li><a href="Cars.jsp">Cars</a></li>
  <li style="float:right">
    <% 
      String role = (String) session.getAttribute("role");
      if (role != null) { 
    %>
      <a class="active" href="logout.jsp">Logout</a>
    <% } else { %>
      <a class="active" href="login.jsp">Login</a>
    <% } %>
  </li>
  <li style="float:right">
    <a id="language-selector" href="#">Language: <%= selectedLanguage.toUpperCase() %></a>
    <div id="language-dropdown" style="display: none;">
      <a href="#" class="language-option" data-language="en">English</a>
      <a href="#" class="language-option" data-language="ar">Arabic</a>
    </div>
  </li>
</ul>

<script>
  // Language selector functionality
  var languageDropdown = document.getElementById("language-dropdown");
  var languageSelector = document.getElementById("language-selector");

  // Show/hide language dropdown on language selector click
  languageSelector.addEventListener("click", function(e) {
    e.preventDefault();
    if (languageDropdown.style.display === "none") {
      languageDropdown.style.display = "block";
    } else {
      languageDropdown.style.display = "none";
    }
  });

  // Store selected language in a cookie
  var languageOptions = document.getElementsByClassName("language-option");
  for (var i = 0; i < languageOptions.length; i++) {
    languageOptions[i].addEventListener("click", function(e) {
      e.preventDefault();
      var selectedLanguage = this.getAttribute("data-language");
      document.cookie = "language=" + selectedLanguage;
      location.reload(); // Reload the page after setting the cookie
    });
  }
</script>
</body>
</html>
