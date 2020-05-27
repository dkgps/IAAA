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
		}else{
			
			String freeBoardTitle = null;
			String freeBoardContent = null;
			
			if(request.getParameter("freeBoardTitle") != null){
				freeBoardTitle = (String)request.getParameter("freeBoardTitle");
			}
			if(request.getParameter("freeBoardContent") != null){
				freeBoardContent = (String)request.getParameter("freeBoardContent");
			}
			
			if(freeBoardTitle==null || freeBoardContent==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back();");
				script.println("</script>");	
			}else{
				FreeBoardDAO freeBoardDAO = new FreeBoardDAO();
				int result = freeBoardDAO.write(freeBoardTitle,userID,freeBoardContent);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 등록되었습니다.')");
					script.println("location.href='freeBoard.jsp'");
					script.println("</script>");
				}else if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 등록에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
			}
		
		
		}
	%>
</body>
</html>