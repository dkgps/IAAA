<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "freeboard.FreeBoard" %>
<%@ page import = "freeboard.FreeBoardDAO" %>
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
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="freeBoard.jsp" style="color: #fed136;">FreeBoard</a></li>
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
				<h3 style="text-align: center">자유게시판</h3>
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
								FreeBoardDAO freeBoardDAO = new FreeBoardDAO();
								ArrayList<FreeBoard> list = freeBoardDAO.getList(pageNumber);
								 
								for(int i=0; i<list.size(); i++){
									if(i==12) break;
							
							%>
								<tr>
									<td><%= list.get(i).getFreeBoardID() %></td>
									<td><a href="freeBoardView.jsp?freeBoardID=<%=list.get(i).getFreeBoardID()%>"><%=list.get(i).getFreeBoardTitle() %> (<%=freeBoardDAO.countReply(list.get(i).getFreeBoardID()) %>)</a></td>
									<td><%= list.get(i).getUserID() %></td>
									<td style="font-size: 80%"><%= list.get(i).getFreeBoardDate().substring(0,11)+list.get(i).getFreeBoardDate().substring(11,13)+"시"+ list.get(i).getFreeBoardDate().substring(14,16)+"분"%></td>
								</tr>
								
							<%
								}
							%>
							</tbody>
					</table>
					<%
						if(pageNumber !=1){
					%>
						<a href="freeBoard.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
					<%
						} 
						if(freeBoardDAO.nextPage(pageNumber)){
					%>	
						<a href="freeBoard.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-right">다음</a>
					<%
						}
					%>
					<a href="freeBoardWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
				</div>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>