<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "research.ResearchDAO" %>
<%@ page import = "research.ResearchDTO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale='1'">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/nav.css">
<style>
li{
margin-left:1.5rem;
}

a:link{
text-decoration:none;
}
</style>
<title>학술 연구 자료 게시판</title>
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
	
	ResearchDAO researchDAO = new ResearchDAO();
	ArrayList<ResearchDTO> researchList = researchDAO.getList(pageNumber);

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
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="scientificResearch.jsp" style="color: #fed136;">Research</a></li>
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
				<h3 style="text-align: center">학술 연구</h3>
				<p style="text-align: center; color:grey; font-size:80%">딥스카이, 스타샷 정보, 학술지에 관련된 글만 올려주세요</p>
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
									<th style="background-color: #eee; text-align:center;">조회수</th>
								</tr>	
							</thead>
							<tbody>
							<%
								for(int i=0; i<researchList.size(); i++){
									ResearchDTO research = researchList.get(i);
								
							%>
								<tr>
									<td><%=research.getResearchID() %></td>
									<td style="text-align:left; padding-left:5rem;"><a href="scientificResearchView.jsp?researchID=<%=research.getResearchID() %>">
									
							<%
								for(int j=0; j<research.getResearchLevel(); j++){
							%>
									<span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
							<%
								}
							%>
							<%
								if(research.getResearchAvailable()==0){	
							%>
								(삭제된 게시물입니다.)
							<%
								}else{
							%>
								<%=research.getResearchTitle() %>
							
							<%
								}
							%>
							</a></td>
									<td><%=research.getUserID() %></td>
									<td style="font-size: 80%;"><%=research.getResearchDate() %></td>
									<td><%=research.getResearchHit() %></td>
								</tr>
								
							<%
								}
							%>
							</tbody>
					</table>
					
					<a href="scientificResearchWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
					<%
						if(pageNumber!=1){
					%>
					<a href="scientificResearch.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success">이전</a>
					<%
						}
					 	if(researchDAO.nextPage(pageNumber)){
					%>
					<a href="scientificResearch.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success">다음</a>
					<%
					 	}
					%>
				</div>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>