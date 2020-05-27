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
<title>freeboardUpdateAction</title>
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
			int freeBoardID = 0;
			if(request.getParameter("freeBoardID")!=null){
				freeBoardID = Integer.parseInt(request.getParameter("freeBoardID"));
			}
			if(freeBoardID == 0){
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
				script.println("location.href='freeBoard.jsp'");
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
					int result = freeBoardDAO.freeBoardUpdate(freeBoardID,freeBoardTitle,freeBoardContent);
					if(result == 1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글이 수정되었습니다.')");
						script.println("location.href='freeBoardView.jsp?freeBoardID="+freeBoardID+"'");
						script.println("</script>");
					}else if(result == 1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
						script.println("history.back();");
						script.println("</script>");
					}
				}
			}
			
		
		
		}
	%>
</body>
</html>