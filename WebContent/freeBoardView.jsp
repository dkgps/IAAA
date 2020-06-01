<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="freeboard.FreeBoard" %>
<%@ page import="freeboard.boardReply" %>
<%@ page import="freeboard.FreeBoardDAO" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale='1'">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/nav.css">
<title>자유게시판 글</title>
</head>
<body>
	<%
		String userID =null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
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
			<div class="jumbotron" style="padding-top: 20px; margin-top: 50px; height:auto;">
				<h3 style="text-align: center">자유게시판</h3> <br><br>
						
	
					<div class="container">
						<div class="row" style="border: 1px solid #ddd;">
							<table class="table table-striped" style="text-align: center;">
								<thead>
									<tr>
										<th colspan="5" style="background-color: #eee; text-align:center;">게시글 보기</th>
									</tr>	
								</thead>
								<tbody>
									<tr>
										<td style="width:20%;">글 제목</td>
										<td colspan="2"><%= freeBoard.getFreeBoardTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td>작성자</td>
										<td colspan="2"><%= freeBoard.getUserID() %></td>
										<td colspan="2"></td>
									</tr>
									<tr>
										<td>작성일자</td>
										<td colspan="2"><%= freeBoard.getFreeBoardDate().substring(0,11) + freeBoard.getFreeBoardDate().substring(11,13)+"시" +freeBoard.getFreeBoardDate().substring(14,16)+"분" %></td>
										<td colspan="2"></td>
									</tr>
								</tbody>
							</table>
							<table class="table" style="text-align:left;" >
							<tr>
								<td colspan="2" style="min-height:200px; padding:20px;  "><%= freeBoard.getFreeBoardContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
							</tr>
							</table>
								
						</div>
						<br>
						<a href="freeBoard.jsp" class="btn btn-success pull-right">목록</a>
								<%
									if(userID != null && userID.equals(freeBoard.getUserID())){
								%>
									<a href="freeBoardUpdate.jsp?freeBoardID=<%= freeBoardID %>" class="btn btn-primary pull-right">수정</a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="freeBoardDeleteAction.jsp?freeBoardID=<%=freeBoardID %>" class="btn btn-danger pull-right">삭제</a>
								<%
									}
								%>
					</div>
					<br>
					<br>
					<div class="container">
						<div class="row" style="border: 1px solid #ddd;">
						<form method="post" action= "boardReplyWrite.jsp">
							<h3>&nbsp; 댓글</h3>
							<table class="table table-striped" style="text-align: center;">	
	
								<tbody>
									<tr>
										<td><textarea class="form-control" placeholder="댓글을 입력하세요" name="replyContent" maxlength="512" style="height: 50px; width: 100%;"></textarea>
										<input type="hidden" name="freeBoardID" value=<%=freeBoardID %>>
										<input type="submit" class="btn btn-primary" value="작성" style="height: 45px; width: 10%; margin-top:10px;">
										</td>
										
									</tr>
									
								</tbody>
							</table>
							
						</form>
						<table class="table table-white" style="text-align: center; border:none;">
							<tbody>
															<%
									FreeBoardDAO freeBoardDAO = new FreeBoardDAO();
									boardReply boardreply = freeBoardDAO.getBoardReply(freeBoardID);
									ArrayList<boardReply> replylist = freeBoardDAO.getReply(freeBoardID);
									
									for(int i=replylist.size()-1; i>=0; i--){
								%>
									<tr>
										<td class="reply-Content" style="width:70%;"><%=replylist.get(i).getReplyContent() %>
										<td class="reply-User" style="width:10%;"><%=replylist.get(i).getUserID() %></td>
										<td style="font-size: 80%"><%= replylist.get(i).getReplyDate().substring(0,11)+replylist.get(i).getReplyDate().substring(11,13)+"시"+ replylist.get(i).getReplyDate().substring(14,16)+"분"%></td>
										<%
									if(userID != null && userID.equals(boardreply.getUserID())){
								%>
									<td style="width:10%;">
									<a onclick="return confirm('삭제하시겠습니까?')" href="./boardReplyDeleteAction.jsp?freeBoardID=<%=freeBoardID %>&replyID=<%= replylist.get(i).getReplyID() %>" class="btn btn-danger pull-right" style="width:60%; font-size:70%;">삭제</a>
								<%
									}
								%>
									</tr>
								
								<%
									}
								%>
				
							</tbody>
						</table>
						</div>
				</div>
			</div>
	</section>

	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>