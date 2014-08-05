<%@ page contentType="text/html;charset=utf-8" import="java.util.*, javax.mail.*, javax.mail.internet.*"
import="java.lang.*, java.util.*, java.util.Date, java.text.*, java.text.SimpleDateFormat, java.text.ParseException" %>
<%!
public String kr(String s) {
	try {
		s = (s == null) ? "" : new String(s.getBytes("8859_1"),"KSC5601");
	}catch (java.io.UnsupportedEncodingException uee) {}
	return s;
}
%>
<%
request.setCharacterEncoding("utf-8");

String mailFrom = "webs.programming@gmail.com";
String Sender = "샘 윗 위키";
String mailTo = request.getParameter("EmailTo");
String title =   request.getParameter("EmailTitle");
String contents =  request.getParameter("EmailContents");
out.println(title);
out.print(contents);

// Session을 생성하기 위해 java.util.Properties 클래스를
// 생성하고 자신이 해당하는 SMTP 호스트 주소를 할당
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
}catch (MessagingException e) {
	out.println(e.getMessage());
}
%>