<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//로그인 관련
String UserIdx = (String)session.getAttribute("useridx");
String UserNick = (String)session.getAttribute("usernick");
%>
<!DOCTYPE html>
<html>
	<head>
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<link href="assets/css/custom-style.css" rel="stylesheet">
	</head>
<script>
var LoginXhr;
var LoginXhrResult;
var emailRegex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;  

function LoginErr(){
<%
String errCode = request.getParameter("err");
if(errCode == null){
}else if(errCode.equals("id_lose")){
	out.print("alert('이메일을 확인해주세요');");
}else if(errCode.equals("pw_lose")){
	out.print("alert('비밀번호를 확인해주세요');");
}else if(errCode.equals("failed")){
	out.print("alert('일치하는 정보가 없습니다.');");
}
%>
}
function goJoin() {
	location.href="00_JoinToMember.jsp";
}
function DoLogin(){
	var uemail = document.getElementById("uemail").value;
	var upw = document.getElementById("upw").value;
	
	if(uemail == ""){
		alert("Email를 입력해주세요");
	}else if(emailRegex.test(uemail) === false){
		alert("잘못된 이메일 형식입니다.");  
		document.getElementById("uemail").focus;
	}else if(upw == ""){
		alert("비밀번호를 입력해주세요");
	}else{

		document.getElementById("LoginForm").submit();
	}
}

</script>
	<body onLoad="LoginErr()">
		<header class="navbar navbar-static-top bs-docs-nav navbar-inverse" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="index.jsp">샘 윗 위키</a>
				</div>
				<form class="navbar-form navbar-left" role="search">
					<div class="form-group">
						<div class="input-group">
							  <input type="text" class="form-control">
							  <span class="input-group-btn">
								<button class="btn btn-default" type="button">Go!</button>
							  </span>
						</div>
					</div>
				</form>

				<ul class="nav navbar-nav navbar-right">
<%				if(UserIdx == null){
					out.println("<li><a href='01_Login.jsp'>로그인</a></li>");
				}else{
					out.println("<li><a href='#'>"+UserNick+"님</a></li>");
					//TODO:마이 페이지 구현시 링크
					out.println("<li><a href='02_Logout.jsp'>로그아웃</a></li>");
				} %>
					<li><a href="00_JoinToMember.jsp">회원가입</a></li>
				</ul>
			</div>
		</header>
		<div class="container login-block">
			<form action="01_DoLogin.jsp" method="post" id="LoginForm" name="LoginForm">
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-user"></span> 샘 윗 위키 / 로그인</h3>
					</div>
					<div class="panel-body">
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">이메일</span>
						  <input type="text" id="uemail" name="uemail" class="form-control" placeholder="E-mail">
						</div>
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">비밀번호</span>
						  <input type="password" id="upw" name="upw" class="form-control" placeholder="Password">
						</div>
						<div class="container">
							<div class="btn-group">
								<input type="button" class="btn btn-default" value="로그인 유지" id="FindIdPw" name="FindIdPw">
								<input type="button" class="btn btn-success" value="로그인"  name="submitbtn" id="loginbutton" onClick="DoLogin()">
								<input type="button" class="btn btn-default" value="아이디/비밀번호 찾기" id="FindIdPw" name="FindIdPw">
								<input type="button" class="btn btn-default" value="회원가입" name="delete" onClick="goJoin()" id="joinbutton">
							</div>
						</div>
					</div>	
				</div>
			</form>
		</div>
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>


