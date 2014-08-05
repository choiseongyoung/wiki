<%@ page contentType="text/html;charset=utf-8" import="java.util.*, javax.mail.*, javax.mail.internet.*"
import="java.lang.*, java.util.*, java.util.Date, java.text.*, java.text.SimpleDateFormat, java.text.ParseException" %>

<%
request.setCharacterEncoding("utf-8");
String AuthentiCode = request.getParameter("AuthentiCode");
String mailFrom = "webs.programming@gmail.com";
String Sender = "샘 윗 위키";
String mailTo = request.getParameter("EmailTo");
String title = "Sam wit wiki 이메일 주소 인증";
String Contents = "이메일 주소를 인증하시려면 아래 버튼을 클릭해 주세요.<br>" 
							+ "<input type='button' value='이메일 주소 인증' 
							+ "onclick='location.href=samwitwiki.org/wiki/00_Authenticate.jsp?AuthentiCode=" + AuthentiCode
							+ "&email=" + EmailTo + "/><br>"
							+ "위 버튼을 클릭해 이메일 주소를 인증하실 수 없는 경우, 아래 링크를 클릭하거나, "
							+ "복사하여 웹 브라우저의 주소창에 붙여넣으세요.<br>";
							+ "http://54.92.39.109/00_Authenticate.jsp?email="+ EmailTo +"&AuthentiCode="+AuthentiCode;

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
