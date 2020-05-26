<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "notice.Notice" %>
<%@ page import = "notice.NoticeDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>
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

.nav-item:active{
 color: #fed136;
}

</style>
<title>공지사항</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	int pageNumber = 1;
	if(request.getParameter("pageNumber")!=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

%>
	<nav class="navbar navbar-expand-lg navbar-dark" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="index.jsp"><img src="assets/img/navbar-logo.png" alt="" /></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive" style="float:right;">
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

		<section class="container mt-5 mb-5" style="max-width: 800px;">
			<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; height:650px;">
				<h3 style="text-align: center">공지사항</h3>
				<div class="container">
					<div class="row">
						
						<br>
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th style="background-color: #eee; text-align:center;">번호</th>
									<th style="background-color: #eee; text-align:center; width:65%;">제목</th>
									<th style="background-color: #eee; text-align:center;">작성자</th>
									<th style="background-color: #eee; text-align:center;">작성일</th>
								</tr>	
							</thead>
							<tbody>
							<%
								NoticeDAO noticeDAO = new NoticeDAO();
								ArrayList<Notice> list = noticeDAO.getList(pageNumber);
								 
								for(int i=0; i<list.size(); i++){
							
							%>
								<tr>
									<td><%= list.get(i).getNoticeID() %></td>
									<td><a href="noticeView.jsp?noticeID=<%=list.get(i).getNoticeID()%>"><%=list.get(i).getNoticeTitle() %></a></td>
									<td><%= list.get(i).getUserID() %></td>
									<td style="font-size: 80%"><%= list.get(i).getNoticeDate().substring(0,11)+list.get(i).getNoticeDate().substring(11,13)+"시"+ list.get(i).getNoticeDate().substring(14,16)+"분"%></td>
								</tr>
								
							<%
								}
							%>
							</tbody>
					</table>
					<%
						if(pageNumber !=1){
					%>
						<a href="notice.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
					<%
						} 
						if(noticeDAO.nextPage(pageNumber+1)){
					%>	
						<a href="notice.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-right">다음</a>
					<%
						}
					%>
					<a href="noticeWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
				</div>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>