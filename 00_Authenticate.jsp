<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>

<!DOCTYPE html>
<html>
	<head>
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<link href="assets/css/custom-style.css" rel="stylesheet">
	</head>
	<body>
		<%@include file="header.jsp"%>
		<div class="container">

<%
request.setCharacterEncoding("utf-8");

//String email = request.getParameter("email");
//String AuthentiCode = request.getParameter("AuthentiCode");

String email = "rjsqor@gmail.com";
String AuthentiCode = "asdf";
Connection conn= null;
Statement stmt = null;
ResultSet rs   = null;

try {
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/samwitwiki?useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "greatwebs!";

		conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
		stmt = conn.createStatement();

		String sql1 = "select idx, nick from member where email = '" + email + "'";
		rs = stmt.executeQuery(sql1);

		if(rs.next()){
			//인증 성공
			String sql2 = "UPDATE member SET authentiCode='pass' WHERE idx='"+rs.getString(1)+"' ";
			
			out.println("<div class='alert alert-success col-md-4 col-md-offset-4 top_margin-10'><h3><span class='glyphicon glyphicon-ok-sign'></span> 인증 성공!</h3><br>"+rs.getString(2)+"님의 이메일 인증이 이루어졌습니다.<br>이제 정상적인 이용이 가능합니다.</div>");
			int Sql2Result = stmt.executeUpdate(sql2);
		}else{
			out.println("<div class='alert alert-warning col-md-4 col-md-offset-4 top_margin-10'><h3><span class='glyphicon glyphicon-minus-sign'></span> 인증 실패!</h3><br>이메일 인증이 실패했습니다.<br>이메일을 다시 확인해주세요</div>");
		}
				 
		stmt.close();
		conn.close();
		rs.close();

	}catch(ClassNotFoundException e) {
		out.println("클래스가 없어요");
		return;
	}catch(SQLException e) {
		out.println(e.toString());
		return;
	}
%>
		</div>
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>