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

function SubmitRemailing(){
	CheckedId = document.getElementById("uemail").value;
	if(CheckedId == ""){
		alert("이메일을 입력해주세요");
	}else if(emailRegex.test(CheckedId) === false){
		alert("잘못된 이메일 형식입니다.");  
	}else{
		document.getElementById("remailingForm").submit();
	}
}
function loadCheck(){
	var Result = "<%= request.getParameter("result")%>";
	if(Result == null){
	}else if(Result == "notfoundemail"){
		document.getElementById('ErrAlertBlock').style.display = 'block';
		document.getElementById('ErrAlertBlock').innerHTML = '<strong>재전송 에러!</strong> <br>일치하는 정보가 없습니다. <br>이메일를 확인해주세요.';
	}else if(Result =="sendsucc"){
		document.getElementById('ErrAlertBlock').style.display = 'block';
		document.getElementById('ErrAlertBlock').className = 'alert alert-succes';
		document.getElementById('ErrAlertBlock').innerHTML = '<strong>재전송 성공!</strong> <br>인증메일이 재전송되었습니다. <br>이메일를 확인해주세요.';
	}else if(Result == "sendfail"){
		document.getElementById('ErrAlertBlock').style.display = 'block';
		document.getElementById('ErrAlertBlock').innerHTML = '<strong>재전송 에러!</strong> <br>알수 없는 에러입니다.';
	}else if(Result =="already"){
		document.getElementById('ErrAlertBlock').style.display = 'block';
		document.getElementById('ErrAlertBlock').innerHTML = '<strong>재전송 에러!</strong> <br>이미 인증된 메일입니다..';
	}
}
		</script>
	</head>
	<body onLoad="loadCheck()">		
		<%@include file="header.jsp"%>
		<div class="container login-block">
			<div class="alert alert-danger" id="ErrAlertBlock" style="display:none"></div>
			<form action="00_DoRemailing.jsp" method="post" id="remailingForm">
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-user"></span> 샘 윗 위키 / 인증메일 재발송 </h3>
					</div>
					<div class="panel-body">
						<div class="input-group btm-margin-10">
						  <span class="input-group-addon">이메일</span>
						  <input type="email" id="uemail" class="form-control" placeholder="E-mail">
						</div>

						<div class="text-center">
							<div class="btn-group">
								<input type="button" class="btn btn-success" value="인증 메일 보내기" 
									id="submitbtn" onclick="SubmitRemailing()">
								<input type="button" class="btn btn-default" value="뒤로가기" 
									name="resetbtn" id="resetbtn" onclick="javascript:history.go(-1);">
							</div>
						</div>
					</div>	
				</div>
			</form>
			<div class="alert alert-info"><h3><span class="glyphicon glyphicon-certificate"></span> 인증메일 안내</h3><br>
				회원가입시 본인의 이메일을 입력해주세요<br>
				입력된 이메일로 본인인증 메일이 발송됩니다.<br>
				(단, 한메일은 발송이 제한될 수 있습니다.)</div>
		</div>
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="assets/js/bootstrap.js"></script>
	</body>
</html>
