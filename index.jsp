<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
<%
//한글 처리
request.setCharacterEncoding("utf-8");
			
String uid = request.getParameter("uid");
String upwd = request.getParameter("up<center></center>wd");

//로그인 관련
String UserIdx = (String)session.getAttribute("useridx");
String UserNick = (String)session.getAttribute("usernick");

// 드라이버를 로드한다.
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/samwitwiki?useUnicode=true&characterEncoding=utf8";
String DB_USER = "root";
String DB_PASSWORD= "greatwebs!";
 
Connection conn= null;
Statement stmt = null;
ResultSet rs   = null;

try {
    // Connection 을 가져온다.
    conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);

    // Statement 를 준비
    stmt = conn.createStatement();

    // ResultSet 가져와서 처리
    String CateQueryStr = "select idx, name from category order by idx";
    rs = stmt.executeQuery(CateQueryStr);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Wiki page</title>

<link href="index.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <div id="_WholeWrap">
    	<div id="_top_margin_div">
        </div>
        <header id="Header">
			<div id="LoginSection">
			<% if(UserIdx == null){ %>
				<a href="01_Login.jsp">로그인</a>
			<%} else {%>
				<a href="#"> <%=UserNick%>님</a>
				&nbsp;&nbsp;&nbsp;&nbsp
				<a href="02_Logout.jsp">로그아웃</a>
			<%}%>
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="00_JoinToMember.jsp">회원가입</a></div>
            <div id="Title">Wiki Page </div>
            <div id="SubTitle">make shared knowledge </div>
            <div id="NaviWrap">
                <nav id="Navi">
                    <ul id="NaviFirst">
<%
                        while(rs.next()){
                            out.print("<li id='NaviFirstLi'> <a href='#'>" + rs.getString("name") + "</a></li>");
                        }
%>
                    </ul>
              </nav>
          </div>
    </header>
        <div id="_contentWrap">
            <div id="contants_1_wrap">
                <section id="contants_1_1">1.1</span>
                <section id="contants_1_2">1.2</span>
                <section id="contants_1_3">1.3</span>
            </div>
            <div id="contants_2_wrap">
                <section id="contents_2_1">2.1</section>
            </div>
        </div>
</div>
</body>
</html>

<%
	rs.close();  
    stmt.close(); 
    conn.close();

} catch (SQLException e) {
      out.println("Err:"+e.toString());
}
%>