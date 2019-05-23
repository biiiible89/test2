<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>회원상세페이지</title>

<body>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        회원상세
        <small>Detail</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="list"><i class="fa fa-dashboard"></i> 회원관리</a></li>
        <li class="active">상세보기</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
       
      <div class="register-box"> 
            <!-- form start -->
            <form role="form" class="form-horizontal" action="regist" method="post">
              <div class="register-box-body" style="margin-bottom:0px;">
                 
            <div class="mailbox-attachments clearfix"
               style="text-align: center;">
               <span class="mailbox-attachment-icon has-img">
                  <div id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;"></div>
               </span>
               
            </div>
            <br />
                 
                <div class="form-group">
                  <label for="inputEmail3" class="col-sm-3 control-label">아이디</label>

                  <div class="col-sm-9">
                    <input name="id" type="text" class="form-control" id="inputEmail3" value="${member.id }">
                  </div>
                </div>
                <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">패스워드</label>

                  <div class="col-sm-9">
                    <input name="pwd" type="password" class="form-control" id="inputPassword3" value="${member.pwd }">
                  </div>
                </div>
                 <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">이메일</label>

                  <div class="col-sm-9">
                    <input name="email" type="email" class="form-control" id="inputPassword3" value="${member.email }">
                  </div>
                </div>
                 <div class="form-group">
                  <label for="inputPassword3" class="col-sm-3 control-label">전화번호</label>
                  <div class="col-sm-9">   
                     <input name="phone" type="text" class="form-control" id="inputPassword3" value="${member.phone.substring(0,3) }-${member.phone.substring(3,7)}-${member.phone.substring(7) }">                   
                  </div>                  
                </div>               
              </div>  
             <div class="box-footer" >
                   
                   <c:if test="${loginUser.authority eq 'ROLE_ADMIN' }">
                      <c:set var="col" value="3"  />
                   </c:if>
                   <c:if test="${loginUser.authority ne 'ROLE_ADMIN' }">
                      <c:set var="col" value="6" />
                   </c:if>
                   <div class="col-xs-${col }">
                      <button type="button" id="modifyBtn" class="btn btn-warning ">수 정</button>
                   </div>
                   <c:if test="${loginUser.authority eq 'ROLE_ADMIN' }">
                   <div class="col-xs-${col }" style="text-align:center;">
                      <button type="button" id="deleteBtn" class="btn btn-danger" >삭 제</button>
                   </div>
                   <div class="col-xs-${col }" style="text-align:center;">
                      <button type="button" id="stopBtn" class="btn btn-info" >정  지</button>
                   </div>
                   </c:if>
                   <div class="col-xs-${col }">
                     <button type="button" id="listBtn" class="btn btn-primary pull-right">목 록</button>
                  </div>
                         
             </div>
           </form>
           </div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

<!-- post parameter -->
<form name="postForm">
   <input type="hidden" name="id" value="${member.id }" />
</form>

   
<script>
   $('input').css("border","none").prop("readonly",true);
   
   $('#modifyBtn').on('click',function(e){
      //alert("수정하기 클릭");
      location.href="modifyForm.do?id=${member.id}";
   });   
   $('#deleteBtn').on('click',function(e){
      //alert("삭제하기 클릭");
      //location.href="remove?id=${member.id}";
      var form=$('form[name="postForm"]');
      form.attr({
         "action":"remove.do",
         "method":"post"
      });
      form.submit();
   });
   $('#stopBtn').on('click',function(e){
      var form=$('form[name="postForm"]');
      form.attr({
         "action":"stop.do",
         "method":"post"
      });
      form.submit();
   });
   
   $('#listBtn').on('click',function(e){
      //alert("목록 클릭");
      location.href="list.do";
   });
   
   var imageURL = "picture.do?picture=${member.picture}";
   $('div#pictureView')
   .css({'background-image':'url('+imageURL+')',
        'background-position':'center',
        'background-size':'cover',
        'background-repeat':'no-repeat'
      });
</script>
   
</body>







  
  