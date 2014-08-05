<%@ page  contentType="text/html;charset=utf-8" 
import="java.lang.*, java.util.*, java.util.Date, java.text.*, java.text.SimpleDateFormat, java.text.ParseException"
import="java.sql.*, java.net.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" session="true"
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

		Connection conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String sql1 = "select idx from member where email = '" + email + "' and authentiCode = '" + AuthentiCode + "'";
		rs = stmt.executeQuery(QueryStr);

		if(rs.next()){
			//인증 성공
			String sql2 = "UPDATE member SET authentiCode='' WHERE idx='24' ";
			int Sql2Result = stmt.executeUpdate(sql2);
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