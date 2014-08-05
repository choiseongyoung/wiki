<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//로그인 관련
String UserIdx = (String)session.getAttribute("useridx");
String UserNick = (String)session.getAttribute("usernick");
%>
<!DOCTYPE html>
<html>
	<head>
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<link href="assets/css/custom-style.css" rel="stylesheet">
		<meta name="google" content="notranslate" />
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
	</body>
</html>