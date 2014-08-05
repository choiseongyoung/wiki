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

						<div class="container">
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
		</div>
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>
