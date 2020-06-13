<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeboard.FreeBoard" %>
<%@ page import="freeboard.FreeBoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
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
<title>자유게시판 글 수정</title>
</head>
<body>
	<%
		String userID =null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");	
		}
		
		int freeBoardID=0;
		
		if(request.getParameter("freeBoardID")!=null){
			freeBoardID = Integer.parseInt(request.getParameter("freeBoardID"));
		}
		if(freeBoardID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href='freeBoard.jsp'");
			script.println("</script>");
		}
		
		FreeBoard freeBoard = new FreeBoardDAO().getFreeBoard(freeBoardID);
		if(!userID.equals(freeBoard.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.');");
			script.println("location.href='bbs.jsp'");
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
		<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; height:auto; border: 1px solid #ddd;">
			<h3 style="text-align: center">자유게시판</h3> <br><br>
			
				<div class="row" style="border: 1px solid #ddd;">			
					<form method="post" action="freeBoardUpdateAction.jsp?freeBoardID=<%=freeBoardID%>">
						<table class="table table-striped" style="text-align: center;">
				
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eee; text-align:center;">글 수정</th>
							</tr>	
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="freeBoardTitle" maxlength="50" value="<%=freeBoard.getFreeBoardTitle()%>"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="freeBoardContent" maxlength="2048" style="height: 350px;"><%=freeBoard.getFreeBoardContent()%></textarea></td>
							</tr>	
						</tbody>	
						</table>
						<input type="submit" class="btn btn-primary pull-right" value="글 수정">
					</form>	
				</div>
				
			
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>