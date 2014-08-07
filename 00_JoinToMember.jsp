<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>

<!DOCTYPE html>
<html>
	<head>
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<link href="assets/css/custom-style.css" rel="stylesheet">

	<script>
var emailRegex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;  
var CheckedId;
var idDupCheckRes;
var idDupCheckId;
var idDupCheckkXhr;
var uemail
var submitRegitXhr;
var submitRegitResResult;

function idDuplicateCheck(){
	CheckedId = document.getElementById("uemail").value;
	if(CheckedId == ""){
		alert("이메일을 입력해주세요");
	}else if(emailRegex.test(CheckedId) === false){
		alert("잘못된 이메일 형식입니다.");  
	}else{
		if(window.ActiveXObject){
			idDupCheckkXhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else{
			idDupCheckkXhr = new XMLHttpRequest();
		}
		idDupCheckkXhr.onreadystatechange = idDuplicateCheckRes;

		idDupCheckkXhr.open("get", "00_IdDupCheck.jsp?uemail="+CheckedId, false);
		idDupCheckkXhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		idDupCheckkXhr.send(null);
	}

}

function idDuplicateCheckRes(){
	if(idDupCheckkXhr.readyState == 4) {
		if(idDupCheckkXhr.status == 200) {
			idDupCheckRes = idDupCheckkXhr.responseText.replace(/^[\s\xA0]+/,"").replace(/[\s\xA0]+$/,"");;
			
			if(idDupCheckRes == "false"){
				alert(CheckedId + "는 이미 사용중인 이메일입니다.");
			}else{
				alert(CheckedId + "는 사용하실 수 있습니다.");
				idDupCheckId = CheckedId;
			}
		}
	}
}

function submitRegitRes(){
	if(submitRegitXhr.readyState == 4) {
		if(submitRegitXhr.status == 200) {
			submitRegitResResult = submitRegitXhr.responseText.replace(/^[\s\xA0]+/,"").replace(/[\s\xA0]+$/,"");;
			
			if(submitRegitResResult == "id null"){
				alert("회원가입 실패\n Error : ID 전달 실패");
			}else if(submitRegitResResult == "nick null"){
				alert("회원가입 실패\n Error : 닉네임 전달 실패");
			}else if(submitRegitResResult == "pw null"){
				alert("회원가입 실패\n Error : 비밀번호 전달 실패");
			}else if(submitRegitResResult == "pw2 null"){
				alert("회원가입 실패\n Error : 비밀번호 확인 전달 실패");
			}else if(submitRegitResResult == "email null"){
				alert("회원가입 실패\n Error : 이메일 전달 실패");
			}else if(submitRegitResResult == "pw conflict"){
				alert("회원가입 실패\n Error : 비밀번호 불일치");
			}else if(submitRegitResResult == "sign up fail"){
				alert("회원가입 실패\n Error : DB 입력 실패");
			}else if(submitRegitResResult == "email send fail"){
				alert("회원가입 실패\n Error : 이메일 발송 실패");
			}else{
				alert("회원가입 성공\n 가입하신 이메일로 인증메일이 발송되었습니다.");
				location.replace("index.jsp");
			}
		}
	}
}
function submitRegitform(FormElement){
	var unick = document.getElementById("unick").value;
	var upw = document.getElementById("upw").value;
	var upw2 = document.getElementById("upw2").value;
	uemail = document.getElementById("uemail").value;


	if(uemail == ""){
		alert("이메일을 입력해주세요.");
		document.getElementById('uemail').focus();
	}else if(emailRegex.test(uemail) === false){
		alert("잘못된 이메일 형식입니다.");  
	}else if(unick == ""){
		alert("닉네임을 입력해주세요.");
		document.getElementById('unick').focus();
	}else if(upw == ""){
		alert("비밀번호를 입력해주세요.");
		document.getElementById('upw').focus();
	}else if(upw2 == ""){
		alert("비밀번호를 다시 입력해주세요.");
		document.getElementById('upw2').focus();
	}else if(idDupCheckRes != "true" || uemail != idDupCheckId){
		alert("아이디 중복확인을 확인해주세요.");
	}else if(upw != upw2){
		alert("비밀번호를 확인을 확인해주세요.");
	}else{
		if(window.ActiveXObject){
			submitRegitXhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else{
			submitRegitXhr = new XMLHttpRequest();
		}
		submitRegitXhr.onreadystatechange = submitRegitRes;

		submitRegitXhr.open("post", "00_DoJoinToMember.jsp", true);
		submitRegitXhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		submitRegitXhr.send("unick="+unick+"&upw="+upw+"&upw2="+upw2+"&uemail="+uemail);
	}
}

	</script>
	</head>
	<body>		
		<%@include file="header.jsp"%>
		<div class="container login-block">
			<form action="00_DoJoinToMember.jsp" method="post" name="regitform" target="bodyFrame">
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-user"></span> 샘 윗 위키 / 회원가입 </h3>
					</div>
					<div class="panel-body">
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">이메일</span>
						  <input type="email" id="uemail" class="form-control" placeholder="E-mail">
						  <span class="input-group-addon" onclick="idDuplicateCheck()">중복확인</span>
						</div>
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">닉네임</span>
						  <input type="text" id="unick" class="form-control" placeholder="Nickname">
						</div>
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">비밀번호</span>
						  <input type="password" id="upw" class="form-control" placeholder="Password">
						</div>
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">비번확인</span>
						  <input type="password" id="upw2" class="form-control" placeholder="Password confirm">
						</div>

						<div class="text-center">
							<div class="btn-group">
								<input type="button" class="btn btn-success" value="가입하기" 
									id="submitbtn" onclick="submitRegitform(this)">
								<input type="button" class="btn btn-default" value="뒤로가기" 
									name="resetbtn" id="resetbtn" onclick="javascript:history.go(-1);">
							</div>
						</div>
					</div>	
				</div>
			</form>
			<div class="alert alert-info"><h3><span class="glyphicon glyphicon-certificate"></span> 회원가입 안내</h3><br>
				회원가입시 본인의 이메일을 입력해주세요<br>
				입력된 이메일로 본인인증 메일이 발송됩니다.<br>
				인증 메일 재발송은 <a href="00_Remailing.jsp">여기</a>를 눌러주세요.<br>
				(단, 한메일은 발송이 되지 않습니다.)</div>
		</div>
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>
