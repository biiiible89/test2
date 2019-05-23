<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<title>회원수정</title>
<body>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        회원수정
        <small>Modify</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashboard"></i> 회원관리</a></li>
        <li class="active">수정</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
       
		<div class="register-box">
				<!-- form start -->
				<form role="form" class="form-horizontal" action="modify.do"
					method="post">
					<input type="hidden" name="picture" />
					<input type="hidden" name="oldPicture" value="${member.picture }" />
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
							<label for="id" class="col-sm-3 control-label">아이디</label>

							<div class="col-sm-9">
								<input readonly name="id" type="text" class="form-control" id="id"
									placeholder="13글자 영문자,숫자 조합" value="${member.id }">
							</div>
						</div>
						<div class="form-group">
							<label for="pwd" class="col-sm-3 control-label" >패스워드</label>

							<div class="col-sm-9">
								<input name="pwd" type="password" class="form-control" id="pwd"
									placeholder="20글자 영문자,숫자,특수문자 조합" value="${member.pwd }">
							</div>
						</div>
						
						<c:if test="${loginUser.authority eq 'ROLE_ADMIN' }">
						<div class="form-group">
							<label for="authority" class="col-sm-3 control-label" >권 한</label>

							<div class="col-sm-9">
								<select name ="authority" class="form-control">
									<option value="ROLE_USER">사용자</option>
									<option value="ROLE_MANAGER">운영자</option>
									<option value="ROLE_ADMIN">관리자</option>								
								</select>
							</div>
						</div>
						</c:if>
						
						<div class="form-group">
							<label for="email" class="col-sm-3 control-label">이메일</label>

							<div class="col-sm-9">
								<input name="email" type="email" class="form-control" id="email"
									placeholder="example@naver.com" value="${member.email }">
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
						<button type="button" id="modifyBtn" class="btn btn-warning col-sm-3">수정하기</button>
						<button type="button" id="cancelBtn"
							class="btn btn-default pull-right col-sm-3">취 소</button>
					</div>
				</form>
			</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
<form role ="imageForm" action ="upload/picture.do" method="post" enctype="multipart/form-data">
	<input id="inputFile" name="pictureFile" type="file" class="form-control" />
	<input id="oldFile" type="hidden" name="oldPicture" value=""/>
	<input type="hidden" name="checkUpload" value="0" />
</form>
   
<script>
	var imageURL = "picture.do?picture=${member.picture}";
	$('div#pictureView')
	.css({'background-image':'url('+imageURL+')',
		  'background-position':'center',
		  'background-size':'cover',
		  'background-repeat':'no-repeat'
		});
	
	$('#modifyBtn').on('click',function(e){
		
		var form=$('form[role="form"]');
		form.submit();
	});	
	$('#cancelBtn').on('click',function(e){
		location.href="detail.do?id=${member.id}";
	});
	
	 function test(phone) { 
		 return phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"); 
		 }
	 var phone = test("${member.phone}").split("-");
	 $('select[name="phone"]').val(phone[0]).attr("selected","selected");
	 var inputPhone = $('input[name="phone"]'); 
	 inputPhone[0].value = phone[1];
	 inputPhone[1].value = phone[2];
	 
	 $('select[name="authority"]').val("${member.authority}").attr("selected","selected");
</script>
   
   <%@ include file="/WEB-INF/views/member/picture_js.jsp" %>
   
</body>






  
  