<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<head>
<style>
input#inputFile {
	display:none;
}
div.form-group label{padding:0;}
</style>
</head>

<body>
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>
				회원등록 <small>Regist</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="list.do"><i class="fa fa-dashboard"></i> 회원관리</a></li>
				<li class="active">등록</li>
			</ol>
		</section>

		<!-- Main content -->
		<section class="content container-fluid">

			<!--------------------------
        | Your Page Content Here |
        -------------------------->

			<div class="register-box">
				<!-- form start -->
				<form role="form" class="form-horizontal" action="regist.do"
					method="post">
					<input type="hidden" name="picture" />
					<div class="register-box-body" style="margin-bottom: 0px;">
						<div class="mailbox-attachments clearfix"
							style="text-align: center;">
							<span class="mailbox-attachment-icon has-img">
								<div id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;"></div>
							</span>
							<div class="mailbox-attachment-info">
								<div class="input-group input-group-sm">
									<label for="inputFile" class=" btn btn-warning btn-flat input-group-addon">파일선택</label>
									<input id="inputFileName" class="form-control" type="text" name="picture" />
									
									<span class="input-group-btn">
										<button type="button" class="btn btn-info btn-flat" onclick="upload_go();">업로드</button>
									</span>
								</div>
							</div>
						</div>
						<br />

						<div class="form-group">
							<label for="id" class="col-sm-3 control-label"><span style="color:red;font-weight:bold;">*</span>아이디</label>

							<div class="col-sm-9 input-group" style="padding:0 15px;">
								<input name="id" type="text" class="form-control" id="id"
									placeholder="13글자 영문자,숫자 조합">
								<span class="input-group-btn">	
									<button type="button" onclick="idCheck_go();" class="btn btn-info">중복확인</button>
								</span>								
							</div>
							
						</div>
						<div class="form-group">
							<label for="pwd" class="col-sm-3 control-label"><span style="color:red;font-weight:bold;">*</span>패스워드</label>

							<div class="col-sm-9">
								<input name="pwd" type="password" class="form-control" id="pwd"
									placeholder="20글자 영문자,숫자,특수문자 조합">
							</div>
						</div>
						<div class="form-group">
							<label for="email" class="col-sm-3 control-label">이메일</label>

							<div class="col-sm-9">
								<input name="email" type="email" class="form-control" id="email"
									placeholder="example@naver.com">
							</div>
						</div>
						<div class="form-group">
							<label for="phone" class="col-sm-3 control-label">전화번호</label>
							<div class="col-sm-9">
								<div class="col-sm-4" style="padding: 0;">
									<select name="phone" id="phone" class="form-control">
										<option value="">-선택-</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="017">017</option>
										<option value="018">018</option>
									</select>
								</div>
								<div class="col-sm-4" style="padding: 0;">
									<label class="col-sm-3" style="padding: 0; text-align: center;">-</label>
									<div class="col-sm-9" style="padding: 0;">
										<input name="phone" type="text" class="form-control" />
									</div>
								</div>
								<div class="col-sm-4" style="padding: 0;">
									<label class="col-sm-3" style="padding: 0; text-align: center;">-</label>
									<div class="col-sm-9" style="padding: 0;">
										<input name="phone" type="text" class="form-control" />
									</div>
								</div>
							</div>
							
						</div>

					</div>
					<div class="box-footer login-box"
						style="margin-top: 0; border-top: none;">
						<button type="button" id="registBtn" class="btn btn-info col-sm-3">가입하기</button>
						<button type="button" id="cancelBtn"
							class="btn btn-default pull-right col-sm-3">취 소</button>
					</div>
				</form>
			</div>
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->

	<script>
		$('#registBtn').on('click', function(e) {
			var uploadCheck = $('input[name="checkUpload"]').val();
			if(!(uploadCheck>0)){
				alert("사진 업로드는 필수입니다.");	
				//$('input[name="pictureFile"]').click();
				return;
			}
			
			if($('input[name="id"]').val()==""){
				alert("아이디는 필수입니다.");
				return;
			} 
				
			if($('input[name="pwd"]').val()==""){
				alert("패스워드는 필수입니다.");
				return;
			}	
			
			
			if($('input[name="id"]').val()!=checkedID){
				alert("아이디 중복확인이 필요합니다.");
				return;
			}
			var form = $('form[role="form"]');
			form.submit();
		});
		$('#cancelBtn').on('click', function(e) {
			location.href = "list.do";
		});
		
		//아이디 중복 확인
		var checkedID="";
		
		function idCheck_go(){			
			var id=$('input[name="id"]').val();
			//alert(id);
			
			if(id==""){
				alert("아이디를 입력하세요");
				return;
			}else{
				//아이디는 4~12자의 영문자와 숫자로만 입력
				var reqID=/^[a-zA-Z]{1}[a-zA-Z0-9]{3,11}$/;
				if(!reqID.test($('input[name="id"]').val())){
					alert("아이디는 첫글자는 영문자이며, \n4~12자의 영문자와 숫자로만 입력해야 합니다.");
					$('input[name="id"]').focus();
					return;
				}
			}
			
			var data={id:id};
			$.ajax({
				url:"<%=request.getContextPath()%>/member/idCheck.do",
				data:data,
				type:'post',
				success:function(result){
					console.log(result);
					if(result=="duplicated"){
						alert("중복된 아이디 입니다.");
						$('input[name="id"]').focus();
					}else{
						alert("사용가능한 아이디입니다.");
						checkedID=id;
					}
				},
				error:function(error){
					alert("시스템 장애로 가입이 불가합니다.");
				}
			});
		}
		
	</script>


<form role="imageForm" action="upload/picture.do" method="post" enctype="multipart/form-data">
	<input id="inputFile" name="pictureFile" type="file" class="form-control">
	<input id="oldFile" type="hidden" name="oldPicture" value="" />
	<input type="hidden" name="checkUpload" value="0" />	
</form>

<%@ include file="/WEB-INF/views/member/picture_js.jsp" %>

</body>







