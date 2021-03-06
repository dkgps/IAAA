<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "photo1.Photo1DAO" %>
<%@ page import = "photo1.Photo1DTO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.io.File" %>
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
<title>갤러리</title>
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
						<%
						Photo1DAO photo1DAO = new Photo1DAO();
						ArrayList<Photo1DTO> photoList = photo1DAO.getList(pageNumber);
						
							for(int i=0; i<photoList.size(); i++){
								if(i==6) break;
								Photo1DTO photo1 = photoList.get(i);
								String Photo = photo1DAO.getPhoto(photo1.getPhotoID());
							
						%>
							<div class="col-md-4">
								<div class="thumbnail" style="width: 200px; height:230px; ">
									<a href="photo1View.jsp?photoID=<%=photo1.getPhotoID() %>">
									<img alt =<%=Photo%> src=<%=Photo%> style="width: 200px; height:130px; overflow:hidden;">
										
											<h5><%=photo1.getPhotoTitle() %></h5>
											<h5>작성자:	 <%=photo1.getUserID() %></h5>
											<h5>		<%=photo1.getPhotoDate().substring(0,11) + photo1.getPhotoDate().substring(11,13)+"시" +photo1.getPhotoDate().substring(14,16)+"분"  %>
											</h5>
										
									</a>
								</div>
							</div>

						<%
							}
						%>
		
					</div>	
			</div>
			<div class="f" style="padding:1.5rem;">
						<a href="photo1Write.jsp" class="btn btn-primary pull-right">글쓰기</a>
						<%
						if(pageNumber!=1){
						%>
						<a href="photo1.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success">이전</a>
						<%
							}
						 	if(photo1DAO.nextPage(pageNumber)){
						%>
						<a href="photo1.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success">다음</a>
						<%
						 	}
						%>
			</div>	
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>