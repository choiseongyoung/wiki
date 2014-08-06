<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
<%
request.setCharacterEncoding("utf-8");

String email = request.getParameter("email");
String AuthentiCode = request.getParameter("AuthentiCode");
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

		String sql1 = "select idx from member where email = '" + email + "' and authentiCode = '" + AuthentiCode + "'";
		rs = stmt.executeQuery(sql1);

		if(rs.next()){
			//인증 성공
			String sql2 = "UPDATE member SET authentiCode='' WHERE idx='"+rs.getString(1)+"' ";
			int Sql2Result = stmt.executeUpdate(sql2);
			
			response.sendRedirect("
");
		}else{
			//인증 실패
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