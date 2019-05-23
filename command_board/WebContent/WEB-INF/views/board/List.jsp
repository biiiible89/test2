<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<head>
	<title>게시글 목록</title>
	<style>
		table th,td{
			text-align:center;
		}
		div.box-header{
			overflow:hidden;
		}
		div.box-header #keyword{
			max-width:200px;
			float:right;
		} 
		div.box-header #searchType{		
			height:30px;
			line-height:30px;
			padding:0;
						
			max-width:160px;
			text-align:center;
			float:right;
			margin-left:20px;
		}
	
	</style>
</head>	
	
<body>
  <c:set var="pageMaker" value="${dataMap.pageMaker }" />	
  	
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        자유게시판
        <small>List</small>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button id='newBtn' class="btn btn-primary"
        	    onclick="javascript:location.href='registForm.do${pageMaker.makeQuery(pageMaker.cri.page)}';">글등록</button>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashboard"></i>자유게시판</a></li>
        <li class="active">목록</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">Search Board List page</h3>	
						<div id="keyword" class="input-group input-group-sm">	
							<input  class="form-control" type="text" name="keyword" 
								placeholder="검색어를 입력하세요." value="${param.keyword }"/>
							<span class="input-group-btn">
								<button class="btn btn-info btn-flat" type="button" id="searchBtn">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
						<div id="searchType">						
							<select class="form-control" name="searchType" id="searchType">
								<option value="tcw" ${pageMaker.cri.searchType eq 'tcw' ? 'selected':'' }>전 체</option>
								<option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected':'' }>제 목</option>
								<option value="w" ${pageMaker.cri.searchType eq 'w' ? 'selected':'' }>작성자</option>
								<option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected':'' }>내 용</option>
								<option value="tc" ${pageMaker.cri.searchType eq 'tc' ? 'selected':'' }>제목+내용</option>
								<option value="cw" ${pageMaker.cri.searchType eq 'cw' ? 'selected':'' }>작성자+내용</option>							
							</select>
						</div>					
					</div>
					<div class="box-body">
						<table class="table table-bordered">
							<tr>
								<th class="col-sm-1">번 호</th>
								<th class="col-sm-6">제 목</th>
								<th class="col-sm-2">작성자</th>
								<th class="col-sm-2">등록일</th>
								<th class="col-sm-1">조회수</th>
							</tr>	
							<c:if test="${empty dataMap.boardList }" >
								<tr>
									<td colspan="5">
										<strong>해당 내용이 없습니다.</strong>
									</td>
								</tr>
							</c:if>						
							<c:forEach items="${dataMap.boardList }" var="board">
								<tr>
									<td>${board.bno }</td>
									<td id="boardTitle" style="text-align:left;">
									<a href="detail.do${pageMaker.makeQuery(pageMaker.cri.page) }&bno=${board.bno }">
										<span class="col-sm-12 ">${board.title }
											<c:if test="${board.replycnt ne 0 }">										
												&nbsp;&nbsp;<span class="fa fa-comment"></span>
												<span class="label label-success">${board.replycnt}</span>
											</c:if>
										</span>
									</a>
									</td>
									<td>${board.writer }</td>
									<td>
										<fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd"/>
									</td>
									<td><span class="badge bg-red">${board.viewcnt }</span></td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="box-footer">
						<div class="text-center">
							<ul class="pagination">
									
								<li><a href="list.do${pageMaker.makeQuery(1)}">&lt;&lt;</a>						
								<li>
									<a href="list.do
									<c:if test="${pageMaker.prev }">
										${pageMaker.makeQuery(pageMaker.startPage-1) }
									</c:if>
									">&lt;</a>
								</li>
								
								<c:forEach begin="${pageMaker.startPage }" 
								           end="${pageMaker.endPage }" var="pageNum">
								<li <c:out value="${pageMaker.cri.page == pageNum?'class =active':''}"/>>
									<a href="list.do${pageMaker.makeQuery(pageNum) }" >${pageNum }</a></li>
								</c:forEach>
								<li><a href="list.do
								<c:if test="${pageMaker.next }">
									${pageMaker.makeQuery(pageMaker.endPage+1) }
								</c:if>
								<c:if test="${!pageMaker.next }">
									${pageMaker.makeQuery(pageMaker.cri.page) }
								</c:if>
								">&gt;</a></li>
								<li><a href="list.do${pageMaker.makeQuery(pageMaker.realEndPage) }">&gt;&gt;</a>
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
	<form id="jobForm">
		  <input type='hidden' name="page" value="${pageMaker.cri.page}" />
		  <input type='hidden' name="perPageNum" 
		  		 value="${pageMaker.cri.perPageNum}"/>
		  <input type='hidden' name="searchType" 
		         value="${pageMaker.cri.searchType }" />
		  <input type='hidden' name="keyword" 
		         value="${pageMaker.cri.keyword }" />
	</form>
   	
<script>
	
	$('#searchBtn').on('click',function(e){
		/* 
		if($('input[name="keyword"]').val() !=""){
			if($('select[name="searchType"]').val()==""){
				alert("검색구분은 필수입니다.");
				$('input[name="searchType"]').focus();
				return;
			}			
		} */
		
		var jobForm=$('#jobForm');
		jobForm.find("[name='page']").val(1);
		jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
		jobForm.find("[name='keyword']").val($('input[name="keyword"]').val());
		
		/* alert(jobForm.serialize()); */
		
		jobForm.attr("action","list.do").attr("method","get");
		jobForm.submit();
	});
	
	
</script>

</body>






  