<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/bower_components/bootstrap/dist/css/bootstrap.min.css">
		  <!-- Font Awesome -->
		  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/bower_components/font-awesome/css/font-awesome.min.css">
		  <!-- Ionicons -->
		  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/bower_components/Ionicons/css/ionicons.min.css">
		  <!-- Theme style -->
		  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/AdminLTE.min.css">
		  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
		        page. However, you can choose any other skin. Make sure you
		        apply the skin class to the body tag so the changes take effect. -->
		  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/skins/skin-blue.min.css">
		
	</head>
	<body>
		<section class="content">
      <div class="error-page">
        <h2 class="headline text-yellow"> 404</h2>

        <div class="error-content">
          <h3><i class="fa fa-warning text-yellow"></i> Oops! Page not found.</h3>

          <p>
            We could not find the page you were looking for.
            Meanwhile, you may <a href="../../index.html">return to dashboard</a> or try using the search form.
          </p>

          <form class="search-form">
            <div class="input-group">
              <input type="text" name="search" class="form-control" placeholder="Search">

              <div class="input-group-btn">
                <button type="submit" name="submit" class="btn btn-warning btn-flat"><i class="fa fa-search"></i>
                </button>
              </div>
            </div>
            <!-- /.input-group -->
          </form>
        </div>
        <!-- /.error-content -->
      </div>
      <!-- /.error-page -->
    </section>
	</body>
</html>