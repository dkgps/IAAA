<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeboard.FreeBoard" %>
<%@ page import="freeboard.FreeBoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboardWriteAction</title>
</head>
<body>
	<%	
		FreeBoard freeboard = new FreeBoard();
	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
			return;
		}
		
		
		String replyContent = null;
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
		if(request.getParameter("replyContent")!=null){
			replyContent = (String) request.getParameter("replyContent");
		}	
			
		if(replyContent==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 입력하세요')");
			script.println("history.back();");
			script.println("</script>");	
		}else{
			
			FreeBoardDAO freeBoardDAO = new FreeBoardDAO();
			int result = freeBoardDAO.reply(freeBoardID,userID,replyContent);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글이 등록되었습니다.')");
					script.println("location.href='freeBoardView.jsp?freeBoardID="+freeBoardID+"'");
					script.println("</script>");
				}else if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 등록에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
		}
		
	%>
</body>
</html>