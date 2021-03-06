<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
<title>학술 연구 자료 업로드</title>
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
					<form method="post" action="scientificResearchWriteAction.jsp" enctype="multipart/form-data">
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th colspan="2" style="background-color: #eee; text-align:center;">파일 업로드</th>
								</tr>	
							</thead>
							<tbody>
								<tr>
									<td colspan="2"><input type="text" class="form-control" placeholder="글 제목" name="researchTitle" maxlength="50"></td>
								</tr>
								<tr>
									<td colspan="2"><textarea class="form-control" placeholder="글 내용" name="researchContent" maxlength="2048" style="height: 300px;"></textarea></td>
								</tr>
								<tr>
									<td><h5>파일 업로드</h5></td>
									<td>
										<input type="file" name="researchFile" class="file">
										<div class="input-group col-xs-12" style="padding-top:1rem;">
											<span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
											<input type="text" class="form-control input-lg" disabled placeholder="파일을 업로드하세요.">
											<span class="input-group-btn">
												<button class="browse btn btn-primary input-lg" type="button"><i class="glyphicon glyphicon-search"></i>파일 찾기</button>
											</span>
										</div>
											
									</td>
								</tr>
							</tbody>	
						</table>
						<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
					</form>	
				</div>
			</div>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>