<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<title>글등록</title>
<body>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        자유게시판
        <small>Regist</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashboard"></i>자유게시판</a></li>
        <li class="active">등록</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3>글등록</h3>
					</div><!--end box-header  -->
					<div class="box-body">
						<form role="form" method="post" action="regist.do" name="registForm">
							<div class="form-group">
								<label for="title">제 목</label> 
								<input type="text" id="title"
									name='title' class="form-control" placeholder="제목을 쓰세요">
							</div>
							<div class="form-group">
								<label for="content">내 용</label>
								<textarea class="form-control" name="content" id="content" rows="20"
									placeholder="1000자 내외로 작성하세요."></textarea>
							</div>
							<div class="form-group">
								<label for="writer">작성자</label> 
								<input type="text" id="writer" readonly
									name="writer" class="form-control" value="${loginUser.id }">
							</div>
						</form>
					</div><!--end box-body  -->
					<div class="box-footer">
						<button type="button" class="btn btn-primary" id="registBtn">등 록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn" id="cancelBtn">취 소</button>
					</div><!--end box-footer  -->
				</div><!-- end box -->				
			</div><!-- end col-md-12 -->
		</div><!-- end row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
	
<script>
	$('#registBtn').on('click',function(e){
		var form=document.registForm;
		
		for(var i=0;i<form.elements.length;i++){
			var input = form.elements[i];
			if(input.value==""){
				$(input).parent('div').addClass("has-error");
				alert(input.name+"은 필수입니다.")
				return;
			}
		}
		
		if(form.content.value.length>1000){
			alert("글자수가 1000자를 초과할 수 없습니다.");
			return;
		}
		
		form.submit();
	});
	$('#cancelBtn').on('click',function(e){
		history.go(-1);
	});
	
	$("input").on('keydown',function(e){	
		if($(this).val()!=""){
			$(this).parent('div').removeClass("has-error");
		}		
	});
	$("textArea").on('keydown',function(e){	
		if($(this).val()!=""){
			$(this).parent('div').removeClass("has-error");
		}		
	});
	
	
</script>

</body>






  