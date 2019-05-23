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
        자료실
        <small>Detail</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashpds"></i> 자료실</a></li>
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
								value="${pds.title }" readonly />							
						</div>	
						<div class="form-group col-sm-4" >
							<label for="writer">작성자</label>
							<input type="text" class="form-control" id="writer" 
								value="${pds.writer }" readonly />
						</div>		
						
						<div class="form-group col-sm-4" >
							<label for="regDate">작성일</label>
							<input type="text" class="form-control" id="regDate" 
								value="<fmt:formatDate value="${pds.regDate }" pattern="yyyy-MM-dd" />" readonly />
						</div>	
						<div class="form-group col-sm-4" >
							<label for="viewcnt">조회수</label>
							<input type="text" class="form-control" id="viewcnt" 
								value="${pds.viewcnt }" readonly />
						</div>		
						<div class="form-group col-sm-12">
							<label for="content">내 용</label>
							<textArea class="form-control" id="content" rows="5"
								 readonly >${pds.content }</textArea>	
						</div>
						<div class="form-group col-sm-12">
							<div class="box box-success">
								<div class="box-header">
									<h3>첨부파일</h3>
								</div>			
								<div class="box-footer">
									<c:forEach items="${pds.attachList }" var="attach">
									<div class="col-md-4 col-sm-6 col-xs-12"
										style="cursor:pointer;"
										onclick="location.href='<%=request.getContextPath() %>/attach/get.do?ano=${attach.ano }';">
										<div class="info-box">	
											<span class="info-box-icon bg-yellow">	<i class="fa fa-files-o"></i>
											</span>
				
											<div class="info-box-content">
												<span class ="info-box-text">
												<fmt:formatDate value="${attach.regDate }" pattern="yyyy-MM-dd" />
												</span>
												<span class ="info-box-number">${attach.fileName }</span>
											</div>
										</div>
									</div>
									</c:forEach>
								</div>				
							</div>
						</div>
												
					</div>
					<div class="box-footer">
						<c:if test="${loginUser.id eq pds.writer }">
						<button type="button" id="modifyBtn" class="btn btn-warning">Modify</button>						
					    <button type="button" id="removeBtn" class="btn btn-danger">REMOVE</button>
					    </c:if>
					    <button type="button" id="listBtn" class="btn btn-primary">GO LIST </button>
					</div>									
				</div><!-- end box -->				
			</div><!-- end col-md-12 -->
		</div><!-- end row  -->		
		
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <form role="form">
  	<input type='hidden' name='pno' value ="${pds.pno}">
  	<input type='hidden' name='page' value ="${param.page}">
    <input type='hidden' name='perPageNum' value ="${param.perPageNum}">
    <input type='hidden' name="searchType" 
		         value="${param.searchType }" />
	<input type='hidden' name="keyword" 
		         value="${param.keyword }" />
  </form>

<%@ include file="/WEB-INF/views/pds/detail_js.jsp" %>
</body>






  