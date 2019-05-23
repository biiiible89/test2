<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<script>
$('#addFileBtn').on('click',function(event){
    //alert("add File btn click");
    var attachedFile = $('a[name="attachedFile"]').length;
    var inputFile = $('input[name="uploadFile"]').length;
    var attachCount = attachedFile + inputFile;
    
    if(attachCount >=5){
       alert("파일추가는 5개까지만 가능합니다.");
       return;
    }
    
    var input=$('<input>').attr({"type":"file","name":"uploadFile",}).css("display","inline");
    var div=$('<div>').addClass("inputRow");
       div.append(input).append("<button class='badge bg-red' type='button'>X</button>");
       div.appendTo('.fileInput');
 });
 
$('div.fileInput').on('click','div.inputRow > button',function(event){
	$(this).parent('div.inputRow').remove();
});

var index=0;

$('div.fileInput').on('click','a[name="attachedFile"] > button',function(event){
	//alert(event.currentTarget.className);
	
	var parent = $(this).parent('a[name="attachedFile"]');
	alert(parent.attr("attach-fileName:") + "파일을 삭제합니다.");
	
	var ano=parent.attr("attach-no");
	
	$(this).parent('a[name="attachedFile"]').remove();
	
	var input=$('<input>').attr({"type":"hidden", "name":"deleteFile", "value":ano});
	
	$('form[role="form"]').prepend(input);
	index++;
	/* event.preventDefault();
	event.stopPropagation(); */
	return false;
});

$('.fileInput').on('change','input[type="file"]',function(event){
	if(this.files[0].size>1024*1024*40){
		alert("파일 용량이 40MB를 초과 하였습니다.");
		this.value="";
		$(this).focus();
		return false;
	}
});
</script>

