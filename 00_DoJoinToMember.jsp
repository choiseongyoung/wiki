<%@ page contentType="text/html;charset=utf-8" 
import="java.lang.*, java.util.*, java.util.Date, java.text.*, java.text.SimpleDateFormat, java.text.ParseException" 
import="java.sql.*, java.net.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" session="true" %>
<%!
public boolean mailSend(String MailTo, String AuthentiCode){
	String mailFrom = "webs.programming@gmail.com";
	String Sender = "샘 윗 위키";
	String title = "Sam wit wiki 이메일 주소 인증";
	String Contents = "이메일 주소를 인증하시려면 아래 버튼을 클릭해 주세요.<br>" 
								+ "<input type='button' value='이메일 주소 인증' 
								+ "onclick='location.href=samwitwiki.org/wiki/00_Authenticate.jsp?AuthentiCode=" + AuthentiCode
								+ "&email=" + EmailTo + "/><br>"
								+ "위 버튼을 클릭해 이메일 주소를 인증하실 수 없는 경우, 아래 링크를 클릭하거나, "
								+ "복사하여 웹 브라우저의 주소창에 붙여넣으세요.<br>";
								+ "http://54.92.39.109/00_Authenticate.jsp?email="+ EmailTo +"&AuthentiCode=" + AuthentiCode;

	Properties props = new Properties();
	props.put("mail.smtp.host", "172.31.7.18");
	Session msgSession = Session.getDefaultInstance(props, null);
	try {
		// Message 클래스의 객체를 Session을 이용해 생성합니다.
		//session에 값을 설정해주고 보냄
		MimeMessage msg = new MimeMessage(msgSession);
		InternetAddress from = new InternetAddress(mailFrom, Sender, "euc-kr");
		msg.setFrom(from);
		InternetAddress to = new InternetAddress(mailTo);
		msg.setRecipient(Message.RecipientType.TO, to);
		msg.setSubject(title, "EUC-KR");
		msg.setContent(contents, "text/html; charset=EUC-KR");
		msg.setHeader("Content-Transfer-Encoding", "quoted-printable");

		Transport.send(msg);
		return true;
	}catch (MessagingException e) {
		return false;
	}
}
%>
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
		for(int i = 0; i<20 ; i++){
			AuthentiCode += (char)((Math.random() * 26) + 97);
		}

		String sql1 = "INSERT INTO member(pw, email, nick, photo, authentiCode) VALUES "
					+ "('"+pw+"', '"+email+"', '"+nick+"', 'nopicture.jpg', '"+AuthentiCode+"')";
		int result = stmt.executeUpdate(sql1);

		if(result == 1){ // 회원가입 성공시
			if(mailSend(email,AuthentiCode)){
				out.print("sign up succ");
			}else{
				out.print("email send fail");
			}
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