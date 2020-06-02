<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="aboutme.AboutMeDTO" %>
<%@ page import="aboutme.AboutMeDAO" %>
<%@ page import="aboutme.AboutMeReply" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale='1'">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/nav.css">
<style>
li{
margin-left:1.5rem;
}

</style>
<title>자기 소개 글</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	int aboutMeID = 0;
	if(request.getParameter("aboutMeID")!=null){
		aboutMeID = Integer.parseInt(request.getParameter("aboutMeID"));
	}
	
	if(aboutMeID ==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.');");
		script.println("location.href='aboutMe.jsp'");
		script.println("</script>");
	}
	AboutMeDAO aboutMeDAO = new AboutMeDAO();
	AboutMeDTO aboutMeDTO = aboutMeDAO.getAboutMe(aboutMeID);
	aboutMeDAO.hit(aboutMeID);

%>
	<nav class="navbar navbar-expand-lg navbar-dark" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="index.jsp"><img src="assets/img/navbar-logo.png" alt="" /></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive" style="float:right;">
                    <ul class="navbar-nav text-uppercase ml-auto">
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="notice.jsp">Notice</a></li>
<%
	if(userID==null){
%>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="join.jsp">Join</a></li>
<%
	}else{
%>                      
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="photo1.jsp">PHOTO 1</a></li>
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="photo2.jsp">PHOTO 2</a></li>
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="observation.jsp">Observation</a></li>
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="scientificResearch.jsp">Research</a></li>
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="freeBoard.jsp">FreeBoard</a></li>
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="aboutMe.jsp" style="color: #fed136;">About Me</a></li>	
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="logoutAction.jsp">Logout</a></li>
<%
	}
%>
                    </ul>
                </div>
            </div>
    </nav>

	<section class="container mt-5 mb-5" style="max-width: 1000px;">
		<div class="jumbotron" style="padding-top: 30px; margin-top: 50px; height:auto;">
			<div class="container">
				<div class="row" style="padding-top:30px;">
					
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th colspan="5" style="background-color: #eee; text-align:center;"><%=aboutMeDTO.getUserID() %>의 자기 소개</th>
								</tr>	
							</thead>
							<tbody>
								<tr>
									<td style="width:20%;">글 제목</td>
									<td colspan="4"><%=aboutMeDTO.getAboutMeTitle() %></td>
								</tr>
								<tr>
									<td><h5>작성날짜</h5></td>
									<td colspan="2"><h6><%=aboutMeDTO.getAboutMeDate() %></h6></td>
									<td><h5>조회수</h5></td>
									<td colspan="2"><h5><%=aboutMeDTO.getAboutMeHit()+1%></h5></td>
								</tr>
								<tr>
									<td>글 내용</td>
									<td colspan="4">
									<textarea class="form-control" placeholder="글 내용" name="aboutMeContent" maxlength="2048" style="height: 450px;" readonly><%=aboutMeDTO.getAboutMeContent() %>
									</textarea></td>
								</tr>
							</tbody>	
						</table>
						</div>
						<br>
						<a href="aboutMe.jsp" class="btn btn-success pull-left">목록</a>
						<%
									if(userID != null && userID.equals(aboutMeDTO.getUserID())){
								%>
									<a href="aboutMeUpdate.jsp?aboutMeID=<%= aboutMeID %>" class="btn btn-primary pull-right">수정</a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="aboutMeDeleteAction.jsp?aboutMeID=<%=aboutMeID %>" class="btn btn-danger pull-right">삭제</a>
								<%
									}
								%>

			</div>
			<br>
			<br>
			
			<div class="container">
						<div class="row" style="border: 1px solid #ddd;">
						<form method="post" action= "aboutMeReplyWriteAction.jsp">
							<h3>&nbsp; 댓글</h3>
							<table class="table table-striped" style="text-align: center;">	
	
								<tbody>
									<tr>
										<td><textarea class="form-control" placeholder="댓글을 입력하세요" name="replyContent" maxlength="512" style="height: 50px; width: 100%;"></textarea>
										<input type="hidden" name="aboutMeID" value=<%=aboutMeID %>>
										<input type="submit" class="btn btn-primary" value="작성" style="height: 45px; width: 10%; margin-top:10px;">
										</td>
										
									</tr>
									
								</tbody>
							</table>
							
						</form>
						<table class="table table-white" style="text-align: center; border:none;">
							<tbody>
								<%
									
						
									ArrayList<AboutMeReply> replylist = aboutMeDAO.getReply(aboutMeID);
									
									for(int i=replylist.size()-1; i>=0; i--){
								%>
									<tr>
										<td class="reply-Content" style="width:70%;"><%=replylist.get(i).getReplyContent() %>
										<td class="reply-User" style="width:10%;"><%=replylist.get(i).getUserID() %></td>
										<td style="font-size: 80%"><%= replylist.get(i).getReplyDate().substring(0,11)+replylist.get(i).getReplyDate().substring(11,13)+"시"+ replylist.get(i).getReplyDate().substring(14,16)+"분"%></td>
										<%
									if(userID != null && userID.equals(replylist.get(i).getUserID())){
								%>
									<td style="width:10%;">
									<a onclick="return confirm('삭제하시겠습니까?')" href="./aboutMeReplyDeleteAction.jsp?aboutMeID=<%=aboutMeID %>&replyID=<%= replylist.get(i).getReplyID() %>" class="btn btn-danger pull-right" style="width:60%; font-size:70%;">삭제</a>
								<%
									}
								%>
									</tr>
								
								<%
									}
								%>
				
							</tbody>
						</table>
						</div>
				</div>
			
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>