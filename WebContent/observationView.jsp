<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="observation.ObservationDTO" %>
<%@ page import="observation.ObservationDAO" %>
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

nav.active{
color:blue;
}

</style>
<title>관측 후기 글쓰기</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	int observationID= 0;
	if(request.getParameter("observationID")!=null){
		observationID = Integer.parseInt(request.getParameter("observationID"));
	}
	
	if(observationID==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("history.back();");
		script.println("</script>");	
	}
	
	ObservationDAO observationDAO = new ObservationDAO();
	ObservationDTO observationDTO = observationDAO.getObservation(observationID);

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
                    	<li class="nav-item"><a class="nav-link js-scroll-trigger" href="observation.jsp"  style="color: #fed136;">Observation</a></li>
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
				
	
				<div class="container">
					<div class="row" style="padding-top:30px;">
					<br>
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th colspan="6" style="background-color: #eee; text-align:center; border: 1px solid #ddd; "><h3 style="text-align: center">관측 후기</h3></th>
								</tr>	
							</thead>
							<tbody>
							<tr> 
								<td style="border: 1px solid #ddd; font-weight: bold; ">연도</td>
								<td><%=observationDTO.getObservationYear() %></td>
								
							
								<td style="border: 1px solid #ddd; font-weight: bold;">관측 구분</td>
								<td><%=observationDTO.getObservationDivide() %></td>
								
		
								<td style="border: 1px solid #ddd; font-weight: bold;">작성자</td>
								<td><%=observationDTO.getUserID() %></td>
								
							</tr>
						
							<tr>
								<td colspan="2" style="border: 1px solid #ddd; font-weight: bold;">제목</td>
								<td colspan="3"  style="text-align:left; padding-left:3rem;"><%=observationDTO.getObservationTitle() %></td>
								<td colspan="1">추천수: <%=observationDTO.getLikeCount() %>&nbsp;&nbsp;&nbsp;&nbsp;<a href="observationLikeAction.jsp?observationID=<%=observationID %>" class="btn btn-warning">추천</a></td>
								
							</tr>
						
							<tr style="height:350px; text-align:left;">
								
								<td colspan="6" style=" padding: 2rem;"><%=observationDTO.getObservationContent() %></td>
								
							</tr>
							</tbody>	
						</table>
					</div>	
					<br>
					
				
				</div>	
				<a href="observation.jsp" class="btn btn-success pull-left" >목록</a>
					
								<%
									if(userID != null && userID.equals(observationDTO.getUserID())){
								%>
									<a href="observationUpdate.jsp?observationID=<%= observationID %>" class="btn btn-primary pull-right">수정</a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="observationDeleteAction.jsp?observationID=<%=observationID %>" class="btn btn-danger pull-right">삭제</a>
								<%
									}
								%>	
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>