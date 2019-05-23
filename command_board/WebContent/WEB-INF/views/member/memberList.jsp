<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<head>
   <title>회원목록</title>
   <style>
      table th,td{
         text-align:center;
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
<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        회원리스트
        <small>List</small>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button type="button" class="btn btn-primary" id="registBtn">회원등록</button>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list.do"><i class="fa fa-dashboard"></i> 회원관리</a></li>
        <li class="active">리스트</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
   <div class="box">
      <div class = "box-header with-border">
         <h3 class="box-title">회원 검색 관리 페이지</h3>
         <div id="keyword" class="input-group input-group-sm">   
                     <input  class="form-control" type="text" name="keyword" 
                        placeholder="검색어를 입력하세요." value="${param.keyword }"/>
                     <span class="input-group-btn">
                        <button class="btn btn-info btn-flat" type="button" id="searchBtn">
                           <i class="fa fa-fw fa-search"></i>
                        </button>
                     </span>
                  </div>
                  <c:set var="pageMaker" value="${dataMap.pageMaker }"/>
                  <div id="searchType">                  
                     <select class="form-control" name="searchType" id="searchType">
                        <option value=""  ${pageMaker.cri.searchType eq '' ? 'selected':'' }>검색구분</option>
                        <option value="i" ${pageMaker.cri.searchType eq 'i' ? 'selected':'' }>아이디</option>
                        <option value="p" ${pageMaker.cri.searchType eq 'p' ? 'selected':'' }>전화번호</option>
                        <option value="e" ${pageMaker.cri.searchType eq 'e' ? 'selected':'' }>이메일</option>
                        </select>
                  </div>               
      </div>
      <div class="box-body"> 
                 
             <div class="row">
             <div class="col-sm-12">
             <table class="table table-bordered">
                <thead>
                <tr role="row">
                   <th class="col-sm-1" >순번</th>
                   <th class="col-sm-2" >아이디</th>
                   <th class="col-sm-3" >패스워드</th>
                   <th class="col-sm-4" >이메일</th>
                   <th class="col-sm-2" >전화번호</th>
                  </tr>
                </thead>
                <c:forEach var="member" items="${dataMap.memberList}" varStatus="status">
                   <tr>
                      <td>${status.count }</td>
                      <td>
                         <a href="detail.do?id=${member.id }">${member.id }</a>
                      </td>
                      <td>${member.pwd }</td>
                      <td>${member.email }</td>
                      <td>${member.phone }</td>
                   </tr>
                </c:forEach>               
              </table>
             </div>
            </div>            
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
         <!-- /.box-footer-->
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
     $('#registBtn').on('click',function(e){
        location.href="registForm.do";
     });
     
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

