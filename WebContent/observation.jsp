<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="observation.ObservationDTO" %>
<%@ page import="observation.ObservationDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.net.URLEncoder" %>
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
<title>관측 후기 게시판</title>
</head>
<body>
<%	
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	String observationDivide = "전체";
	String searchType = "최신순";
	String search ="";
	
	if(request.getParameter("observationDivide") != null) {
		observationDivide = request.getParameter("observationDivide");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
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
				<h3 style="text-align: center">관측 후기를 들려주세요!</h3>
				<p style="text-align: center; color:grey; font-size:80%">글 제목 양식: 0000년 0학기 백마고지 정기관측회</p>
				<div class="container">
					<form method="get" action="./observation.jsp" class="form-inline mt-3">
						<br>
						<select name="observationDivide" class="form-control mx-1 mt-2">
							<option value="전체">전체</option>
							<option value="정관" <%if(observationDivide.equals("정관")) out.println("selected"); %>>정관</option>
							<option value="소관" <%if(observationDivide.equals("교양")) out.println("selected"); %>>소관</option>
							<option value="기타" <%if(observationDivide.equals("기타")) out.println("selected"); %>>기타</option>
						</select>
						<select name="searchType" class="form-control mx-1 mt-3">
							<option value="최신순">최신순</option>
							<option value="추천순" <%if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
						</select>
						<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요." style="width: 350px;">
						<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
					</form>
					<br>
					<div class="row">
						
						<br>
						<table class="table table-striped" style="text-align: center; border: 1px solid #ddd">
							<thead>
								<tr>
									<th style="background-color: #eee; text-align:center;">번호</th>
									<th style="background-color: #eee; text-align:center;">구분</th>
									<th style="background-color: #eee; text-align:center; width:60%;">제목</th>
									<th style="background-color: #eee; text-align:center;">작성자</th>
									<th style="background-color: #eee; text-align:center;">작성일</th>
									<th style="background-color: #eee; text-align:center;">추천수</th>
									
								</tr>	
							</thead>
							<tbody>
								
							<%
								ObservationDAO observationDAO = new ObservationDAO();
								ArrayList<ObservationDTO> list = observationDAO.getList(observationDivide, searchType, search, pageNumber);
	
								for(int i=0; i<list.size(); i++){
									if(i==8) break;
							%>
								<tr>
									<td><%=list.get(i).getObservationID()%></td>
									<td><%=list.get(i).getObservationDivide()%></td>
									<td><a href="observationView.jsp?observationID=<%=list.get(i).getObservationID()%>"><%=list.get(i).getObservationTitle()%></a></td>
									<td><%=list.get(i).getUserID()%></td>
									<td style="font-size: 80%"><%=list.get(i).getObservationDate().substring(0,11)+list.get(i).getObservationDate().substring(11,13)+"시"+list.get(i).getObservationDate().substring(14,16)+"분" %></td>
									<td style="color:red;"><%=list.get(i).getLikeCount()%></td>
								</tr>
							<%
								}
							%>
								
								
							
							</tbody>
					</table>
					
					<a href="observationWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
				<% if(pageNumber<=1){
					
				%>
					<!-- <a class="page-link disabled">이전</a> -->
				<%
					}else{
				%>
					<a class="btn btn-primary" href="./observation.jsp?observationDivide=<%=URLEncoder.encode(observationDivide, "UTF-8") %>&searchType=<%=URLEncoder.encode(searchType, "UTF-8") %>&search=
					<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber-1 %>">이전</a>
				<% 
					}
				%>
				
				
				<% if(list.size()<6){
					
				%>
					<!-- <a class="page-link disabled">다음</a> -->
				<%
					}else{
				%>
					<a class="btn btn-primary" href="./observation.jsp?observationDivide=<%=URLEncoder.encode(observationDivide, "UTF-8") %>&searchType=<%=URLEncoder.encode(searchType, "UTF-8") %>&search=
					<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber+1 %>">다음</a>
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