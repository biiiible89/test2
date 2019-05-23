<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>상세보기</title>

<body>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        자유게시판
        <small>Detail</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashboard"></i> 자유게시판</a></li>
        <li class="active">상세보기</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">상세보기</h3>
					</div>
					<div class="box-body">
						<div class="form-group col-sm-12">
							<label for="title">제 목</label>
							<input type="text" class="form-control" id="title" 
								value="${board.title }" readonly />							
						</div>	
						<div class="form-group col-sm-4" >
							<label for="writer">작성자</label>
							<input type="text" class="form-control" id="writer" 
								value="${board.writer }" readonly />
						</div>		
						
						<div class="form-group col-sm-4" >
							<label for="regDate">작성일</label>
							<input type="text" class="form-control" id="regDate" 
								value="<fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd" />" readonly />
						</div>	
						<div class="form-group col-sm-4" >
							<label for="viewcnt">조회수</label>
							<input type="text" class="form-control" id="viewcnt" 
								value="${board.viewcnt }" readonly />
						</div>		
						<div class="form-group col-sm-12">
							<label for="content">내 용</label>
							<textArea class="form-control" id="content" rows="20"
								 readonly >${board.content }</textArea>	
						</div>
												
					</div>
					<div class="box-footer">
						<c:if test="${loginUser.id eq board.writer }">
						<button type="button" id="modifyBtn" class="btn btn-warning">Modify</button>						
					    <button type="button" id="removeBtn" class="btn btn-danger">REMOVE</button>
					    </c:if>
					    <button type="button" id="listBtn" class="btn btn-primary">GO LIST </button>
					</div>									
				</div><!-- end box -->				
			</div><!-- end col-md-12 -->
		</div><!-- end row  -->
		
		<!-- reply component start --> 
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">ADD NEW REPLY</h3>
					</div>
					<div class="box-body">
						<label for="newReplyWriter">Writer</label>
						<input class="form-control" type="text" placeholder="USER ID" 
							   id="newReplyWriter" readonly value="${loginUser.id}"> 
						<label for="newReplyText">Reply Text</label>
						<input class="form-control" type="text"	placeholder="REPLY TEXT" 
						       id="newReplyText">
					</div>
					<div class="box-footer">
						<button type="button" class="btn btn-primary" 
								id="replyAddBtn">ADD REPLY</button>
					</div>				
				</div>
				<!-- The time line -->
				<ul class="timeline">
					<!-- timeline time label -->
					<li class="time-label" id="repliesDiv">
						<span class="bg-green">Replies List </span></li>
				</ul>

				<div class='text-center'>
					<ul id="pagination" class="pagination pagination-sm no-margin ">
	
					</ul>
				</div>
			</div><!-- end col-md-12 -->
		</div><!-- end row -->
		
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <form role="form">
  	<input type='hidden' name='bno' value ="${board.bno}">
  	<input type='hidden' name='page' value ="${param.page}">
    <input type='hidden' name='perPageNum' value ="${param.perPageNum}">
    <input type='hidden' name="searchType" 
		         value="${param.searchType }" />
	<input type='hidden' name="keyword" 
		         value="${param.keyword }" />
  </form>

<!-- Modal -->
<div id="modifyModal" class="modal modal-default fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" style="display:none;"></h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>        
      </div>
      <div class="modal-body" data-rno>
        <p><input type="text" id="replytext" class="form-control"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/board/detail_js.jsp" %>

<%@ include file="/WEB-INF/views/board/reply_js.jsp" %>

</body>






  