<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
<%
//한글 처리
			
String uid = request.getParameter("uid");
String upwd = request.getParameter("upwd");

// 드라이버를 로드한다.
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/samwitwiki?useUnicode=true&characterEncoding=utf8";
String DB_USER = "root";
String DB_PASSWORD= "greatwebs!";
 
Connection conn= null;
Statement stmt = null;
ResultSet rs   = null;

//try {
    // Connection 을 가져온다.
   // conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);

    // Statement 를 준비
   // stmt = conn.createStatement();

    // ResultSet 가져와서 처리
   // String CateQueryStr = "select idx, name from category order by idx";
   // rs = stmt.executeQuery(CateQueryStr);
%>
<!DOCTYPE html>
<html>
		<%@include file="header.jsp"%>

		<div class="row">
			<div class="jumbotron">
				<div class="container">
					<h1>Sam wit wiki</h1>
					<p>make shared knowledge</p>
					<div class="row">
						<div class="container">
							<ul class="nav nav-pills" role="tablist">
								<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> Category 1
									<span class="caret"></span></a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="#">아이고</a></li>
										<li><a href="#">아이고</a></li>
									</ul>
								</li>
								<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> Category 2
									<span class="caret"></span></a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="#">아이고</a></li>
										<li><a href="#">아이고</a></li>
									</ul>
								</li>
								<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> Category 3
									<span class="caret"></span></a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="#">아이고</a></li>
										<li><a href="#">아이고</a></li>
									</ul>
								</li>
								<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> Category 4
									<span class="caret"></span></a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="#">아이고</a></li>
										<li><a href="#">아이고</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>

<%
	//rs.close();  
    //stmt.close(); 
    //conn.close();

//} catch (SQLException e) {
//      out.println("Err:"+e.toString());
//}
%>