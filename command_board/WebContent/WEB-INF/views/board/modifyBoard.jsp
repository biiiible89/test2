<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<title>수정페이지</title>

<body>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        자유게시판
        <small>Modify</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashboard"></i>자유게시판</a></li>
        <li class="active">수정</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3>글수정</h3>
					</div><!--end box-header  -->
					<div class="box-body">
						<form role="form" method="post" action="modify.do" name="modifyForm">
							
							<input type='hidden' name='page' value="${param.page}">
							<input type='hidden' name='perPageNum' value="${param.perPageNum}">
							<input type='hidden' name='searchType' value="${param.searchType}">
							<input type='hidden' name='keyword' value="${param.keyword}">
							
							<div class="form-group">
								<label for="title">제 목</label> 
								<input type="text" id="title" value="${board.title }"
									name='title' class="form-control" placeholder="제목을 쓰세요">
							</div>
							<div class="form-group">
								<label for="content">내 용</label>
								<textarea class="form-control" name="content" id="content" rows="3"
									placeholder="500자 내외로 작성하세요.">${board.content }</textarea>
							</div>
							<div class="form-group">
								<label for="writer">작성자</label> 
								<input type="text" id="writer" readonly
									name="writer" class="form-control" value="${board.writer }">
							</div>
							
							<input type="hidden" name="bno" value="${board.bno }" />
							
						</form>
					</div><!--end box-body  -->
					<div class="box-footer">
						<button type="button" class="btn btn-warning" id="modifyBtn">수 정</button>
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
	$('#modifyBtn').on('click',function(e){
		var form=document.modifyForm;
		
		for(var i=0;i<form.elements.length;i++){
			var input = form.elements[i];
			if(input.type!="hidden"){
				if(input.value==""){
					$(input).parent('div').addClass("has-error");
					alert(input.name+"은 필수입니다.")
					return;
				}
			}
		}
		
		$('form[role="form"]').submit();
	});
	$('#cancelBtn').on('click',function(e){
		location.href="detail.do?bno=${board.bno}&page=${param.page}&perPageNum=${param.perPageNum}"; //검색, 페이징 시에는 반드시 변경
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






  