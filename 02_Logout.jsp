<%@page contentType="text/html;charset=euc-kr" session="true"  import="java.sql.*"%>
<%
	session.invalidate();
	response.sendRedirect("index.jsp");

%>