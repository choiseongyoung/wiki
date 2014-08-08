<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" session="true"%>

<!DOCTYPE html>
<html>
	<head>
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<link href="assets/css/custom-style.css" rel="stylesheet">

		<script>
var emailRegex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;  
var findPwXhr;
var findPwResult;

function CheckIgIllegalInput(){
	CheckId = document.getElementById("uemail").value;
	CheckNick = document.getElementById("unick").value;

	if(CheckId == ""){
		alert("이메일을 입력해주세요");
	}else if(emailRegex.test(CheckId) === false){
		alert("잘못된 이메일 형식입니다.");  
	}else if(CheckNick == ""){
		alert("닉네임을 입력해주세요");
	}else{
		if(window.ActiveXObject){
			 findPwXhr = new ActiveXObject("Microsoft.XMLHTTP");
		}else{
			 findPwXhr = new XMLHttpRequest();
		}
		 findPwXhr.onreadystatechange = findPwXhrRes;

		 findPwXhr.open("get", "00_DoFindPw.jsp?uemail="+CheckId+"&unick="+CheckNick, false);
		 findPwXhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		 findPwXhr.send(null);
	}
}

function findPwXhrRes(){
	if( findPwXhr.readyState == 4) {
		if( findPwXhr.status == 200) {
			findPwResult = idDupCheckkXhr.responseText.replace(/^[\s\xA0]+/,"").replace(/[\s\xA0]+$/,"");;
			
			if(findPwResult == "true"){
				document.getElementById('ErrAlertBlock').className = 'alert alert-success';
				out.print("document.getElementById('ErrAlertBlock').style.display = 'block';");	
				out.print("document.getElementById('ErrAlertBlock').innerHTML = '<strong>비밀번호 발송 성공! </strong> <br>해당 메일주소로 새로운 임시 비밀번호를 발송했습니다.<br>발송된 임시 비밀번호로 로그인 하시여 비밀번호를 변경해주세요.';");
			}else{
				out.print("document.getElementById('ErrAlertBlock').style.display = 'block';");	
				out.print("document.getElementById('ErrAlertBlock').innerHTML = '<strong>비밀번호 찾기 실패! </strong> <br>일치하는 정보가 없습니다. <br>이메일과 닉네임을 확인해주세요.';");
			}
		}
	}
}
		</script>
	</head>
	<body>		
		<%@include file="header.jsp"%>
		<div class="container login-block">
			<div class="alert alert-danger" id="ErrAlertBlock" style="display:none"></div>
			<form action="00_DoFindPw.jsp" method="post" name="regitform">
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-user"></span> 샘 윗 위키 / 비밀번호 찾기 </h3>
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
						  <span class="input-group-addon" onclick="NickDuplicateCheck()">중복확인</span>
						</div>
						<div class="text-center">
							<div class="btn-group">
								<input type="button" class="btn btn-success" value="비번찾기" 
									id="submitbtn" onclick="submitRegitform()">
								<input type="button" class="btn btn-default" value="뒤로가기" 
									name="resetbtn" id="resetbtn" onclick="javascript:history.go(-1);">
							</div>
						</div>
					</div>	
				</div>
			</form>
			<div class="alert alert-warning"><h3><span class="glyphicon glyphicon-certificate"></span> 비밀번호 찾기 안내</h3><br>
				저희 샘 윗 위키에서는 아이디(이메일) 찾기는 지원하지 않습니다.<br>
				이메일과 가입하실때 입력한 닉네임을 입력하시면 해당 메일주소로 새로운 임시 비밀번호를 발송해드립니다.<br>
				발송된 임시 비밀번호로 로그인 하시여 비밀번호를 변경해주세요.<br>
				(단, 한메일은 발송이 제한될 수 있습니다.)</div>
		</div>
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>
