<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
//한글 처리
request.setCharacterEncoding("utf-8");
			
// 드라이버를 로드한다.
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/samwitwiki?useUnicode=true&characterEncoding=utf8";
String DB_USER = "root";
String DB_PASSWORD= "greatwebs!";

Connection conn= null;
Statement stmt = null;
ResultSet rs   = null;

String uemail = new String(request.getParameter("uemail").getBytes("8859_1"),"euc-kr");

try {
    conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
    stmt = conn.createStatement();

    // ResultSet 가져와서 처리
    String QueryStr = "select * from member where email = '" + uemail + "'";
    rs = stmt.executeQuery(QueryStr);

	if(rs.next()){
		out.print("false");
	}else{
		out.print("true");
	}

	rs.close();  
    stmt.close(); 
    conn.close();

} catch (SQLException e) {
      out.println("Err:"+e.toString());
}
%>