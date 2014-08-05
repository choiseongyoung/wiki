<%@ page  contentType="text/html;charset=utf-8" import="java.sql.*" session="true" %>
<%
request.setCharacterEncoding("utf-8");

String uemail = request.getParameter("uemail");
String upw = request.getParameter("upw");
Connection conn= null;
Statement stmt = null;
ResultSet rs   = null;

if(uemail == ""){ %>
	<jsp:forward page="01_Login.jsp?err='id_lose'"/>
<%
}else if(upw == ""){ %>
	<jsp:forward page="01_Login.jsp?err='pw_lose'"/>
<%
}else{
	//인자값에 이상이 없을 경우
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/samwitwiki?useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "greatwebs!";

		conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
		stmt = conn.createStatement();

		String QueryStr = "select idx, nick from member where email = '" + uemail + "' and pw = '" + upw + "'";
		rs = stmt.executeQuery(QueryStr);

		if(rs.next()){
			//로그인 성공 처리
			//기존의 세션이 있다면 버리고 새로 생성한다.
			//HttpSession session = request.getSession(true);
			if(session != null){
				session.invalidate();
			}
			session = request.getSession(true);
			session.setAttribute("useridx",rs.getString(1));
			session.setAttribute("usernick",rs.getString(2));
			response.sendRedirect("index.jsp");
		}else{
			//로그인 실패 처리
			response.sendRedirect("01_Login.jsp?err=failed"+uemail+"/"+upw);		
		}

		rs.close(); 
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
