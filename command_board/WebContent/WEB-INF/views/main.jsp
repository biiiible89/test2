<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
	<title>메인페이지</title>
	<c:if test="${!empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg"/>
	</c:if>
	<style>
		table th,td{
			text-align:center;
		}
	</style>
</head>

<body>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        <div class="col-md-12" >
        	<div class="box box-solid">
        		<div class="box-body">
        		<div  id="carousel-example-generic" class="carousel slide" data-ride="carousel" >
                <ol class="carousel-indicators">
                  <li data-target="#carousel-example-generic" data-slide-to="0" class=""></li>
                  <li data-target="#carousel-example-generic" data-slide-to="1" class="active"></li>
                  <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
                </ol>
                <div class="carousel-inner">
                  <div class="item">
                  	<!--
                  		Size : 이미지의 가로x세로 사이즈 지정
						Format : 이미지의 포멧지정 (gif, png, jpg)
						Color : 배경컬러와 텍스트컬러를 지정
						Text : 기본 텍스트는 이미지의 사이즈이나 사용자가 텍스트를 변경할 수 있음
						<img src="http://placehold.it/320x100?text=sample" />
						<img src="http://placehold.it/320x100.png?text=sample" />
						<img src="http://placehold.it/320x100.png/E8117F/ffffff" />
						<img src="http://placehold.it/320x100.png/E8117F/ffffff?text=sample" />	
					-->
                  	
                  	
                  	<!-- 
                  		카테고리종류 : animals, arch, nature, people, tech
						필터 종류 : grayscale, sepia
                  	 -->
                    <img src="https://placeimg.com/1600/200/arch/grayscale" alt="회원관리">

                    <div class="carousel-caption">
                     
                    </div>
                  </div>
                  <div class="item active">
                    <img src="https://placeimg.com/1600/200/people" alt="게시글관리">

                    <div class="carousel-caption">
                     
                    </div>
                  </div>
                  <div class="item">
                    <img src="https://placeimg.com/1600/200/any" alt="자료실관리">

                    <div class="carousel-caption">
                      
                    </div>
                  </div>
                </div>
                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                  <span class="fa fa-angle-left"></span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                  <span class="fa fa-angle-right"></span>
                </a>
              </div>
        	</div>
        	</div><!-- end box-body  -->
        </div>
        <div class="col-md-6">
        	<div class="panel box box-primary">
        		<div class="box-header with-border">
        			<h4 style="display:inline;"><i class="fa fa-user"></i>&nbsp;회원리스트</h4>
        			<a href="<%=request.getContextPath() %>/member/list.do" class="btn btn-info bg-aqua pull-right" style="padding:0 2px;">+더보기</a>
        		</div>
        		<div class="box-body" style="text-align:center;">
        			<table class="table table-bordered">
	                <thead>
	                <tr role="row">
	                	<th class="col-sm-2" >순번</th>
	                	<th class="col-sm-4" >아이디</th>
	                	<th class="col-sm-4" >이메일</th>
	                	<th class="col-sm-2" >전화번호</th>
	               	</tr>
	                </thead>
	                <c:forEach var="member" items="${memberList}" varStatus="status">
	                	<tr>
	                		<td>${status.count }</td>
	                		<td>
	                			<a href="<%=request.getContextPath() %>/member/detail.do?id=${member.id }">${member.id }</a>
	                		</td>
	                		<td>${member.email }</td>
	                		<td>${member.phone }</td>
	                	</tr>
	                </c:forEach>               
	              </table>
        		</div>
        		<div class="box-footer">
        		</div>
        	</div>
        </div>
        <div class="col-md-6">
        	<div class="panel box box-primary">
        		<div class="box-header with-border">
        			<h4 style="display:inline;"><i class="fa fa-pencil"></i>&nbsp;게시글 리스트</h4>
        			<a href="<%=request.getContextPath() %>/board/list.do" class="btn btn-info bg-aqua pull-right" style="padding:0 2px;">+더보기</a>
        		</div>
        		<div class="box-body">
        			<table class="table table-bordered">
						<tr>
							<th class="col-sm-1">번 호</th>
							<th class="col-sm-9">제 목</th>
							<th class="col-sm-2">등록일</th>
						</tr>	
						<c:if test="${empty boardList }" >
							<tr>
								<td colspan="5">
									<strong>해당 내용이 없습니다.</strong>
								</td>
							</tr>
						</c:if>						
						<c:forEach items="${boardList }" var="board">
							<tr>
								<td>${board.bno }</td>
								<td id="boardTitle" style="text-align:left;">
								<a href="<%=request.getContextPath() %>/board/detail.do?bno=${board.bno }">
									<span class="col-sm-12 ">${board.title }
										<c:if test="${board.replycnt ne 0 }">										
											&nbsp;&nbsp;<span class="fa fa-comment"></span>
											<span class="label label-success">${board.replycnt}</span>
										</c:if>
									</span>
								</a>
								</td>
								<td>
									<fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd"/>
								</td>
							</tr>
						</c:forEach>
					</table>
        		</div>
        		<div class="box-footer">
        		</div>
        	</div>
        </div>
        <div class="col-md-12">
        	<div class="panel box box-primary">
        		<div class="box-header">
        			<h4 style="display:inline;"><i class="fa fa-file-text-o"></i>&nbsp;자료실 리스트</h4>
        			<a href="<%=request.getContextPath() %>/pds/list.do" class="btn btn-info bg-aqua pull-right" style="padding:0 2px;">+더보기</a>
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
						<c:if test="${empty pdsList }" >
							<tr>
								<td colspan="5">
									<strong>해당 내용이 없습니다.</strong>
								</td>
							</tr>
						</c:if>						
						<c:forEach items="${pdsList }" var="pds">
							<tr>
								<td>${pds.pno }</td>
								<td id="pdsTitle" style="text-align:left;">
								<a href="<%=request.getContextPath() %>/pds/detail.do?pno=${pds.pno }">
									<span class="col-sm-12 ">${pds.title }</span>
								</a>
								</td>
								<td>${pds.writer }</td>
								<td>
									<fmt:formatDate value="${pds.regDate }" pattern="yyyy-MM-dd"/>
								</td>
								<td><span class="badge bg-red">${pds.viewcnt }</span></td>
							</tr>
						</c:forEach>
					</table>
        		</div>
        		<div class="box-footer">
        		</div>
        	</div>
        </div>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
</body>

