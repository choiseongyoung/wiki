<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>
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
	out.print("alert('이메일 전달 실패');");
}else if(errCode.equals("pw_lose")){
	out.print("alert('비밀번호 전달 실패');");
}else if(errCode.equals("failed")){
	out.print("document.getElementById('ErrAlertBlock').style.display = 'block';");	
	out.print("document.getElementById('ErrAlertBlock').innerHTML = '<strong>로그인 에러! </strong> <br>일치하는 정보가 없습니다. <br>이메일과 비밀번호를 확인해주세요.';");
}else if(errCode.equals("authention")){
	out.print("document.getElementById('ErrAlertBlock').style.display = 'block';");
	out.print("document.getElementById('ErrAlertBlock').innerHTML = '<strong>로그인 에러! </strong> <br>이메일 인증이 필요합니다. <br>가입하신 이메일로 발송된 인증메일을 확인해주세요';");
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
		<%@include file="header.jsp"%>
		<div class="container login-block">
			<div class="alert alert-danger" id="ErrAlertBlock" style="display:none">alert</div>
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


