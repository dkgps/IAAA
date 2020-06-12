<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "photo1.Photo1DAO" %>
<%@ page import = "photo1.Photo1DTO" %>
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

</style>
<title>이미지 갤러리 글 작성</title>
</head>
<body id="body" style="background-image: url('assets/img/bg-login.jpg');">
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	int photoID = 0;
	if(request.getParameter("photoID")!=null){
		photoID = Integer.parseInt(request.getParameter("photoID"));
	}
	
	Photo1DTO photo1 = new Photo1DAO().getData(photoID);


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
		<section class="container mt-5 mb-5" style="max-width: 900px;">
		<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; ">
			<div class="container">
				<div class="row" style="padding-top:30px;">
					<form method="post" action="photo1UpdateAction.jsp?photoID=<%=photoID %>" enctype="multipart/form-data">
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th colspan="2" style="background-color: #eee; text-align:center;">갤러리 글 수정</th>
								</tr>	
							</thead>
							<tbody>
								<tr>
									<td colspan="2"><input type="text" class="form-control" placeholder="글 제목" name="photoTitle" maxlength="50" value=<%=photo1.getPhotoTitle() %>></td>
								</tr>
								<tr>
									<td colspan="2"><textarea class="form-control" placeholder="글 내용" name="photoContent" maxlength="2048" style="height: 300px;"><%=photo1.getPhotoTitle() %></textarea></td>
								</tr>
								<tr>
									<td style="background-color:#eee; border:none;">
									<input type="hidden" name="userID" value="<%=userID%>">
									<input type="hidden" name="photoID" value="<%=photo1.getPhotoID()%>">
									</td>
								</tr>
								<tr>
									<td><h5>이미지 파일 선택</h5></td>
									<td>
										<input type="file" name="photoFile" class="file">
										<div class="input-group col-xs-12" style="padding-top:1rem;">
											<span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
											<input type="text" class="form-control input-lg" disabled placeholder="<%=photo1.getFileName() %>">
											<span class="input-group-btn">
												<button class="browse btn btn-primary input-lg" type="button"><i class="glyphicon glyphicon-search"></i>파일 찾기</button>
											</span>
										</div>
											
									</td>
								</tr>
							</tbody>	
						</table>
						<input type="submit" class="btn btn-primary pull-right" value="수정">
					</form>	
				</div>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>