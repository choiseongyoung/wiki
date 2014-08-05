<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8" session="false" %>

<html>
<head>
<title>로그인</title>
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
	parent.location.replace("00_JoinToMember.jsp");
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
		/*
		if(window.ActiveXObject){
			LoginXhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else{
			LoginXhr = new XMLHttpRequest();
		}
		LoginXhr.onreadystatechange = LoginXhrRes;

		LoginXhr.open("post", "01_DoLogin.jsp", true);
		LoginXhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		LoginXhr.send("uemail="+uemail+"&upw="+upw);
		*/
		document.getElementById("LoginForm").submit();
	}
}
/*
function LoginXhrRes(){
	if(LoginXhr.readyState == 4) {
		if(LoginXhr.status == 200) {
			LoginXhrResult = LoginXhr.responseText.replace(/^[\s\xA0]+/,"").replace(/[\s\xA0]+$/,"");;
			
			if(LoginXhrResult == "false"){
				alert("일치하는 정보가 없습니다.");
				document.getElementById("upw").value = "";
				document.getElementById("upw").focus;
				
			}

		}
	}
}*/

</script>
<body onLoad="LoginErr()">
	<h1>LOGIN PAGE</h1>
	<div class="wrapper">
	<form action="01_DoLogin.jsp" method="post" id="LoginForm" name="LoginForm">
	<div class="input_row" id="id_box">
		<span>
			email <input type="text" id="uemail" name="uemail" class="input_box"			
			onkeydown="javascript: if (event.keyCode == 13) {DoLogin();}">
		</span>
	</div>
	<div class="input_row" id="psw_box">
		<span>
			PW <input type="password" id="upw" name="upw" class="input_box" 
			onkeydown="javascript: if (event.keyCode == 13) {DoLogin();}">
		</span>
	</div>
	<input type="button" value="로그인" name="submitbtn" id="loginbutton" onClick="DoLogin()">
	<input type="button" value="아이디/비밀번호 찾기" id="FindIdPw" name="FindIdPw" id="findbutton">
	<input type="button" value="회원가입" name="delete" onClick="goJoin()" id="joinbutton">
	</form>
	</div>
</body>
</html>