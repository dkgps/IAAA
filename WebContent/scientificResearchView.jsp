<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "research.ResearchDAO" %>
<%@ page import = "research.ResearchDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale='1'">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/nav.css">

<title>학술 연구 자료</title>
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
	
	int researchID = 0;
	if(request.getParameter("researchID")!=null){
		researchID = Integer.parseInt(request.getParameter("researchID"));
	}
	
	ResearchDAO researchDAO = new ResearchDAO();
	ResearchDTO research = researchDAO.getResearch(researchID);
	researchDAO.hit(researchID);
	
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
	<section class="container mt-5 mb-5" style="max-width: 900px;">
		<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; ">
			<div class="container">
				<div class="row" style="padding-top:30px;">
					
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th colspan="5" style="background-color: #eee; text-align:center;">게시물 보기</th>
								</tr>	
							</thead>
							<tbody>
								<tr>
									<td><h5>제목</h5></td>
									<td colspan="4"><h5><%=research.getResearchTitle() %></h5></td>
								</tr>
								<tr>
									<td><h5>작성자</h5></td>
									<td colspan="4"><h5><%=research.getUserID() %></h5></td>
								</tr>
								<tr>
									<td><h5>작성날짜</h5></td>
									<td colspan="2"><h6><%=research.getResearchDate() %></h6></td>
									<td><h5>조회수</h5></td>
									<td colspan="2"><h5><%=research.getResearchHit() %></h5></td>
								</tr>
								<tr>
									<td colspan="2" style="height: 350px; text-align:left; padding: 2rem;"><%=research.getResearchContent() %></td>
								</tr>
								<tr>
									<td><h5>첨부파일</h5></td>
									<td colspan="4"><h5><a href="scientificResearchDownload.jsp?researchID=<%=research.getResearchID() %>"><%= research.getResearchFile()%></a></h5></td>
								</tr>
							</tbody>	
						</table>
				</div>
			</div>
								<a href="scientificResearch.jsp" class="btn btn-success pull-right">목록</a>
								<a href="scientificResearchReply.jsp?researchID=<%= researchID %>" class="btn btn-primary pull-left">답변</a>
								<%
									if(userID != null && userID.equals(research.getUserID())){
								%>
									<a href="scientificResearchUpdate.jsp?researchID=<%= researchID %>" class="btn btn-primary pull-right">수정</a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="scientificResearchDeleteAction.jsp?researchID=<%=researchID %>" class="btn btn-danger pull-right">삭제</a>
								<%
									}
								%>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>