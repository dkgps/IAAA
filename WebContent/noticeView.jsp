<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "notice.Notice" %>
<%@ page import = "notice.NoticeDAO" %>
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

.navbar-nav{
	padding-left:3.65rem;
	
}

.nav-item:active{
 color: #fed136;
}

</style>
<title>공지사항 글</title>

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
	int noticeID = 0;
	if(request.getParameter("noticeID") != null){
		noticeID = Integer.parseInt(request.getParameter("noticeID"));
	}
	
	if(noticeID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='notice.jsp'");
		script.println("</script>");
	}
	
	Notice notice = new NoticeDAO().getNotice(noticeID);

%>
	<nav class="navbar navbar-expand-lg navbar-dark" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="index.jsp"><img src="assets/img/navbar-logo.png" alt="" /></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                     	<li class="nav-item active"><a class="nav-link js-scroll-trigger" href="notice.jsp" style="color: #fed136;">Notice</a></li>

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
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="aboutMe.jsp">About Me</a></li>	
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="logoutAction.jsp">Logout</a></li>
<%
	}
%>
                    </ul>
                </div>
            </div>
    </nav>

	<section class="container mt-5 mb-5" style="max-width: 1000px;">
		<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; height:700px;">
			<div class="container" >
				<div class="row" style="padding-top:30px; ">
					
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd;">
							<thead>
								<tr>
									<th colspan="2" style="background-color: #eee; text-align:center;"><h4>공지사항</h4></th>
								</tr>	
							</thead>
							<tbody>
								<tr>
									<td style="border: 1px solid #ddd;">제목</td>
									<td class="noticeTitle" style="text-align:left;">&nbsp; <%=notice.getNoticeTitle() %></td>
								</tr>
								<tr>
									<td style="border: 1px solid #ddd;">작성일</td>
									<td class="noticeDate" style="text-align:left; font-size: 80%;">&nbsp;<%=notice.getNoticeDate().substring(0,11) %> <%=notice.getNoticeDate().substring(11,13) %>시 <%=notice.getNoticeDate().substring(14,16) %>분</td>
								</tr>
								<tr>
									<td colspan="2" class="noticeContent" style="height:400px; text-align:left; padding:2rem; border: 1px solid #ddd;">&nbsp; <%= notice.getNoticeContent() %></td>
									
								</tr>
							</tbody>	
						</table>

				</div>
			</div>
				
						<a href="notice.jsp" class="btn btn-success pull-left">목록</a>
								<%
									if(userID != null && userID.equals(notice.getUserID())){
								%>
									<a href="noticeUpdate.jsp?noticeID=<%= noticeID %>" class="btn btn-primary pull-right">수정</a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="noticeDeleteAction.jsp?noticeID=<%=noticeID %>" class="btn btn-danger pull-right">삭제</a>
								<%
									}
								%>
			
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>