<%@ page contentType="text/html;charset=utf-8" import="java.util.*, javax.mail.*, javax.mail.internet.*, java.sql.*"
import="java.lang.*, java.util.*, java.util.Date, java.text.*, java.text.SimpleDateFormat, java.text.ParseException" session="true" %>
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

String uemail = request.getParameter("uemail");
String unick = request.getParameter("unick");

try {
    conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
    stmt = conn.createStatement();

    // ResultSet 가져와서 처리
    String QueryStr = "select idx from member where nick = '" + unick + "' and email ='" + uemail + "'";
    rs = stmt.executeQuery(QueryStr);

		if(rs.next()){
			String RandomStr = "";
			for(int i = 0; i<20 ; i++){
				RandomStr += (char)((Math.random() * 26) + 97);
			}
			String QueryStr2 = "UPDATE member SET pw=password('"+RandomStr+"') WHERE idx='"+rs.getString(1)+"' ";

		    stmt.executeUpdate(QueryStr2);

			String mailFrom = "webs.programming@gmail.com";
			String Sender = "샘 윗 위키";
			String title = "Sam wit wiki 비밀번호 재설정 안내!";
			String Contents =  "<h1>샘 윗 위키에서 비밀번호 찾기를 이용하셨습니다.</h1><br>"
							+ "새로운 설정된 비밀번호 : " + RandomStr + "<br>"
							+ "발송된 임시 비밀번호로 로그인 하시여 비밀번호를 변경해주세요.";

			Properties props = new Properties();
			props.put("mail.smtp.host", "172.31.7.18");
			Session msgSession = Session.getDefaultInstance(props, null);
			try {
				// Message 클래스의 객체를 Session을 이용해 생성합니다.
				//session에 값을 설정해주고 보냄
				MimeMessage msg = new MimeMessage(msgSession);
				InternetAddress from = new InternetAddress(mailFrom, Sender, "euc-kr");
				msg.setFrom(from);
				InternetAddress to = new InternetAddress(uemail);
				msg.setRecipient(Message.RecipientType.TO, to);
				msg.setSubject(title, "EUC-KR");
				msg.setContent(Contents, "text/html; charset=EUC-KR");
				msg.setHeader("Content-Transfer-Encoding", "quoted-printable");
				
				Transport.send(msg);
				out.print("true");
			}catch (MessagingException e) {
				out.print("false");
			}
	}else{
		out.print("false");
	}

	rs.close();  
    stmt.close(); 
    conn.close();

} catch (SQLException e) {
      out.println("Err:"+e.toString());
}
%>