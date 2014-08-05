<%@ page contentType="text/html;charset=euc-kr" import="java.util.*, javax.mail.*, javax.mail.internet.*"

public String kr(String s) {
	try {
		s = (s == null) ? "" : new String(s.getBytes("8859_1"),"KSC5601");
	}catch (java.io.UnsupportedEncodingException uee) {}
	return s;
}
String mailFrom = "webs.programming@gmail.com";
String mailTo = kr(request.getParameter("EmailTo"));
String title =  kr(request.getParameter("EmailTitle"));
String contents =  kr(request.getParameter("EmailContents"));

// Session을 생성하기 위해 java.util.Properties 클래스를
// 생성하고 자신이 해당하는 SMTP 호스트 주소를 할당
Properties props = new Properties();
props.put("mail.smtp.host", "mail.samwitwiki.org");
Session msgSession = Session.getDefaultInstance(props, null);

try {
	// Message 클래스의 객체를 Session을 이용해 생성합니다.
	//session에 값을 설정해주고 보냄
	MimeMessage msg = new MimeMessage(msgSession);
	InternetAddress from = new InternetAddress(mailFrom);
	msg.setFrom(from);
	InternetAddress to = new InternetAddress(mailTo);
	msg.setRecipient(Message.RecipientType.TO, to);
	msg.setSubject(title);
	msg.setContent(contents, "text/html; charset=EUC-KR");

	Transport.send(msg);
}catch (MessagingException e) {
	out.println(e.getMessage());
}