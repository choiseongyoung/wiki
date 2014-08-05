<%@ page  contentType="text/html;charset=utf-8" 
import="java.lang.*, java.util.*, java.util.Date, java.text.*, java.text.SimpleDateFormat, java.text.ParseException" 
import="java.sql.*, java.net.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" session="true" %>
<%

request.setCharacterEncoding("utf-8");

String id = request.getParameter("uid");
String nick = request.getParameter("unick");
String pw = request.getParameter("upw");
String pw2 = request.getParameter("upw2");
String email = request.getParameter("uemail");

if(id == ""){
	out.print("id null");
}else if(nick == ""){
	out.print("nick null");
}else if(pw == ""){
	out.print("pw null");
}else if(pw2 == ""){
	out.print("pw2 null");
}else if(email == ""){
	out.print("email null");
}else if(!pw.equals(pw2)){
	out.print("pw conflict");
}else{
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/samwitwiki?useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "greatwebs!";

		Connection conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String AuthentiCode = "";
		for(int i = 0; i<8 ; i++){
			AuthentiCode += (char)((Math.random() * 26) + 97);
		}

		String sql1 = "INSERT INTO member(pw, email, nick, photo, authentiCode) VALUES "
					+ "('"+pw+"', '"+email+"', '"+nick+"', 'nopicture.jpg', '"+AuthentiCode+"')";
		int result = stmt.executeUpdate(sql1);

		if(result == 1){ // 회원가입 성공시
			out.print(AuthentiCode);
		}else{ // 회원가입 실패시
			out.print("sign up fail");
		} 
		stmt.close();
		conn.close();

	}catch(ClassNotFoundException e) {
		out.println("클래스가 없어요");
		return;
	}catch(SQLException e) {
		out.println(e.toString());
		return;
	}
}
%>