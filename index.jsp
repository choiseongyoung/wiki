<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
<%
//한글 처리
request.setCharacterEncoding("utf-8");
			
String uid = request.getParameter("uid");
String upwd = request.getParameter("upwd");

//로그인 관련
String UserIdx = (String)session.getAttribute("useridx");
String UserNick = (String)session.getAttribute("usernick");

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
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Wiki page</title>
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<link href="assets/css/custom-style.css" rel="stylesheet">
	</head>
	<body>
		<header class="navbar navbar-static-top bs-docs-nav navbar-inverse" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="index.jsp">샘 윗 위키</a>
				</div>
				<form class="navbar-form navbar-left" role="search">
					<div class="form-group">
						<div class="input-group">
							  <input type="text" class="form-control">
							  <span class="input-group-btn">
								<button class="btn btn-default" type="button">Go!</button>
							  </span>
						</div>
					</div>
				</form>

				<ul class="nav navbar-nav navbar-right">
<%				if(UserIdx == null){
					out.println("<li><a href='01_Login.jsp'>로그인</a></li>");
				}else{
					out.println("<li><a href='#'>"+UserNick+"님</a></li>");
					//TODO:마이 페이지 구현시 링크
					out.println("<li><a href='02_Logout.jsp'>로그아웃</a></li>");
				} %>
					<li><a href="00_JoinToMember.jsp">회원가입</a></li>
				</ul>
			</div>
		</header>

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