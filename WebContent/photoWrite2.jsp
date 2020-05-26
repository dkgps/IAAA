<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale='1'">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/nav.css">
<style>
li{
margin-left:3rem;
}

</style>
<title>join</title>
</head>
<body id="body" style="background-image: url('assets/img/bg-login.jpg');">
	<nav class="navbar navbar-expand-lg navbar-dark" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="index.jsp"><img src="assets/img/navbar-logo.png" alt="" /></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive" style="float:right;">
                    <ul class="navbar-nav text-uppercase ml-auto">
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="notice.jsp">Notice</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="login.jsp">Login</a></li>
                        
                    </ul>
                </div>
            </div>
    </nav>

	
		<section class="container mt-5 mb-5" style="max-width: 560px;">
			<div  style="padding-top: 20px; margin-top: 50px; height:750px;">
				<form class="jumbotron" method="multipart/form-data" action="UploadAction.jsp">
					<h3 style="text-align: center; margin-bottom:2rem;">Photos of STAR</h3>
					<br>
					<table>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="photo1Title" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="noticeContent" maxlength="2048" style="height: 350px;"></textarea></td>
							</tr>
							<tr>
								<td>파일선택</td>
								<td><input type="file" name="photo1"></td>
								
							</tr>
						
						</tbody>
						
	
					</table>
				</form>
			</div>
		</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>