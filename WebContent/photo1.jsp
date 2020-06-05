<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "freeboard.FreeBoard" %>
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
list-style: none;
}
.nav-item{
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
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="photo1.jsp" style="color: #fed136;">PHOTO 1</a></li>
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
				<h3 style="text-align: center">Photos of STAR</h3>
				<p style="text-align: center; color:grey; font-size:80%">직접 찍은 별 사진을 공유해주세요 <br>리사이즈 필수! (1280x1024이하)</p>
				<div class="container">
					<div class="row">
					<table class="table" style="text-align: center; border: 1px solid #ddd">
					<thead>
					</thead>
					<tbody>
						<tr>
						<td style="text-align: left;">
						<br>
						<ul>
								<a href="#">
								<img src="assets/img/moon.jpg" width="80%" alt="">
									<li><br></li>
									<li>달 사진입니다</li>
									<li>작성자: 아헨</li>
									<li>작성일: 2020-06-05</li>	
							
							
								</a>
						</ul>	
						</td>
						
						<td style="text-align: left;">
						<br>
						<ul>
								<a href="#">
								<img src="assets/img/moon.jpg" width="80%" alt="">
									<li><br></li>
									<li>달 사진입니다</li>
									<li>작성자: 아헨</li>
									<li>작성일: 2020-06-05</li>	
							
							
								</a>
						</ul>	
						</td>
						<td style="text-align: left;">
						<br>
						<ul>
								<a href="#">
								<img src="assets/img/moon.jpg" width="80%" alt="">
									<li><br></li>
									<li>달 사진입니다</li>
									<li>작성자: 아헨</li>
									<li>작성일: 2020-06-05</li>	
							
							
								</a>
						</ul>	
						</td>
						
						</tr>
						<tr>
						<td style="text-align: left;">
						<br>
						<ul>
								<a href="#">
								<img src="assets/img/moon.jpg" width="80%" alt="">
									<li><br></li>
									<li>달 사진입니다</li>
									<li>작성자: 아헨</li>
									<li>작성일: 2020-06-05</li>	
							
							
								</a>
						</ul>	
						</td>
						
						<td style="text-align: left;">
						<br>
						<ul>
								<a href="#">
								<img src="assets/img/moon.jpg" width="80%" alt="">
									<li><br></li>
									<li>달 사진입니다</li>
									<li>작성자: 아헨</li>
									<li>작성일: 2020-06-05</li>	
							
							
								</a>
						</ul>	
						</td>
						<td style="text-align: left;">
						<br>
						<ul>
								<a href="#">
								<img src="assets/img/moon.jpg" width="80%" alt="">
									<li><br></li>
									<li>달 사진입니다</li>
									<li>작성자: 아헨</li>
									<li>작성일: 2020-06-05</li>	
							
							
								</a>
						</ul>	
						</td>
						
						</tr>
						</tbody>
					</table>
					<a href="photo1Write.jsp" class="btn btn-primary pull-right">글쓰기</a>
				</div>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>