<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeboard.FreeBoardDAO" %>
<%@ page import="freeboard.boardReply" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginAction</title>
</head>
<body>
	<%
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
		}
		
		int replyID=0;
		
		if(request.getParameter("replyID")!=null){
			replyID = Integer.parseInt(request.getParameter("replyID"));
		}
		if(replyID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.');");
			script.println("location.href='freeBoard.jsp'");
			script.println("</script>");
		}else{
		
	
			FreeBoardDAO freeBoardDAO = new FreeBoardDAO();
				int result = freeBoardDAO.delete(replyID);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글이 삭제되었습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}else if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제에 실패했습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
			
		}	
		
			
	%>
</body>
</html>