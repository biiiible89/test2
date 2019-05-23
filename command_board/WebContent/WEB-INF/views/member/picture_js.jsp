<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<script>
	$('input#inputFile').on('change',function(event){
		var fileFormat=
			this.value.substr(this.value.lastIndexOf(".")+1).toUpperCase();
		
		if(fileFormat!="JPG"){
			alert("이미지는 jpg 형식만 가능합니다.");
			return;
		}
		
		//이미지 파일 용량 체크
		if(this.files[0].size > 1024*1024*1){
			alert("사진 용량은 1MB 이하만 가능합니다."	);
			return;
		};
		
		$('input[name="checkUpload"]').val(0);
		
		document.getElementById('inputFileName').value=$(this).val();		
				
		if (this.files && this.files[0]) {
	        var reader = new FileReader();
	        
	        reader.onload = function (e) {
	        	//이미지 미리보기	        	
	        	$('div#pictureView')
	        	.css({'background-image':'url('+e.target.result+')',
					  'background-position':'center',
					  'background-size':'cover',
					  'background-repeat':'no-repeat'
	        		});
	        }
	        
	        reader.readAsDataURL(this.files[0]);
		}
	});
	
	
	function upload_go(){
		//alert("upload btn click");
		
		// form 태그 양식을 객채화
		
		var form = new FormData($('form[role="imageForm"]')[0]);
		
		if($('input[name="pictureFile"]').val()==""){
			alert("사진을 선택하세요.");
			$('input[name="pictureFile"]').click();
			return;
		};
		
		$.ajax({
			url:"<%=request.getContextPath()%>/upload/picture.do",
			data:form,
			type:'post',
			processData:false, //반드시 false로
			contentType:false, //반드시 false로
			success:function(data){
				if(data){
					$('input#oldFile').val(data);
					$('form[role="form"] > input[name="picture"]').val(data);
					$('input[name="checkUpload"]').val(1);
					alert("사진을 업로드 했습니다.");
				}
			},
			error:function(){
				alert("업로드를 실패했습니다.");
			}
		});
		
	}
	
	
</script>