<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<html>
<head>
<title>회원가입</title>
<script>
var emailRegex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;  
var CheckedId;
var idDupCheckRes;
var idDupCheckId;
var idDupCheckkXhr;

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
			}else{
				alert("회원가입 성공");
				AuthenticationMailSending(submitRegitResResult);
				location.replace("index.jsp");
			}
		}
	}
}
var uemail
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
var AuthenticationMailXhr;
var AuthenticationMailContents = "이메일 주소를 인증하시려면 아래 버튼을 클릭해 주세요.<br>" 
								+ "<input type='button' value='이메일 주소 인증' /><br>"
								+ "위 버튼을 클릭해 이메일 주소를 인증하실 수 없는 경우, 아래 링크를 클릭하거나, "
								+ "복사하여 웹 브라우저의 주소창에 붙여넣으세요.<br>";
								+ "http://54.92.39.109/00_Authenticate.jsp?email=email&AuthentiCode="+AuthentiCode;
								
function AuthenticationMailSending(AuthentiCode){
	if(window.ActiveXObject){
		AuthenticationMailXhr = new ActiveXObject("Microsoft.XMLHTTP");
	}else{
		AuthenticationMailXhr = new XMLHttpRequest();
	}
	AuthenticationMailXhr.open("post", "00_MailModule.jsp", true);
	AuthenticationMailXhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	AuthenticationMailXhr.send("EmailTo="+uemail+"&EmailTitle="+"Sam Wit Wiki 회원가입 인증"+"&EmailContents="+AuthentiCode);
}
</script>
</head>
<body>
	<h1>JOIN PAGE</h1>
	<div class="LoginFormWrap">
	<form action="00_DoJoinToMember.jsp" method="post" name="regitform" target="bodyFrame">
		<a>이메일 주소</a>
		<input type="email" id="uemail" name="uemail" class="input_box">
		<input type="button" value="중복확인" name="submitbtn" id="submitbtn" onclick="idDuplicateCheck()"><br>
		<a>닉네임</a>
		<input type="text" id="unick" name="unick" class="input_box"><br>
		<a>비밀번호</a>
		<input type="password" id="upw" name="upw" class="input_box" required/><br>
		<a>비밀번호 확인</a>
		<input type="password" id="upw2" name="upw2" class="input_box" ><br>
		<input type="button" value="가입하기" name="submitbtn" id="submitbtn" onclick="submitRegitform(this)">
		<input type="reset" value="뒤로가기" name="resetbtn" id="resetbtn" onclick="javascript:history.go(-1);">
	</form>
	</div>
</body>
</html>
