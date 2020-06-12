<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "photo2.Photo2DAO" %>
<%@ page import = "photo2.Photo2DTO" %>
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

a:link{
text-decoration:none;
}
</style>
<title>Photo</title>
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
	
	int photoID = 0;
	if(request.getParameter("photoID")!=null){
		photoID = Integer.parseInt(request.getParameter("photoID"));
	}
	if(photoID==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글을 읽어올 수 없습니다.')");
		script.println("location.href='photo2.jsp'");
		script.println("</script>");
	}
	
	Photo2DAO photo2DAO = new Photo2DAO();
	Photo2DTO photo2 = photo2DAO.getData(photoID);
	String Photo = photo2DAO.getPhoto(photo2.getPhotoID());
	
	
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
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="photo2.jsp" style="color: #fed136;">PHOTO 2</a></li>
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
		<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; height:scroll; ">
			<div class="container">
				<div class="row" style="padding-top:30px;">
					
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th colspan="5" style="background-color: #eee; text-align:center; border: 1px solid #ddd; ">게시물 보기</th>
								</tr>	
							</thead>
							<tbody>
								<tr>
									<td><h5>제목</h5></td>
									<td colspan="4"><h5><%=photo2.getPhotoTitle() %></h5></td>
								</tr>
								<tr>
									<td><h5>작성자</h5></td>
									<td colspan="4"><h5><%=photo2.getUserID() %></h5></td>
								</tr>
								<tr>
									<td><h5>작성날짜</h5></td>
									<td colspan="2"><h6><%=photo2.getPhotoDate() %></h6></td>
								</tr>
								<tr>
								<% if(Photo.equals("http://localhost:8080/WebPractice/iaaaphoto/noimage.jpg")){ %>
									<td colspan="2" style="height: 388px; text-align:left; padding: 2rem;"><%=photo2.getPhotoContent() %>
									</td>
								<%}else{ %>
									<td colspan="2" style="height: auto; text-align:left; padding: 2rem;">
									<img src=<%= Photo%> style="max-width:90%;"><br><br>
									<%=photo2.getPhotoContent() %></td>
								<%} %>
								</tr>
								
							</tbody>	
						</table>
				</div>
			</div>
								
								<%
									if(userID != null && userID.equals(photo2DAO.getData(photoID).getUserID())){
								%>
									<a href="photo2.jsp" class="btn btn-success pull-left">목록</a>
									<a href="photo2Update.jsp?photoID=<%= photoID %>" class="btn btn-primary pull-right">수정</a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="photo2DeleteAction.jsp?photoID=<%=photoID %>" class="btn btn-danger pull-right">삭제</a>
								<%
									}else{
								%>	
								<a href="photo2.jsp" class="btn btn-success pull-right">목록</a>
								<%
									}
								%>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>