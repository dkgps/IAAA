<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notice.Notice" %>
<%@ page import="notice.NoticeDAO" %>
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
		Notice notice = new Notice();
	
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
			
			String noticeTitle = null;
			String noticeContent = null;
			
			if(request.getParameter("noticeTitle") != null){
				noticeTitle = (String)request.getParameter("noticeTitle");
			}
			if(request.getParameter("noticeContent") != null){
				noticeContent = (String)request.getParameter("noticeContent");
			}
			
			if(noticeTitle==null || noticeContent==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back();");
				script.println("</script>");	
			}else{
				NoticeDAO noticeDAO = new NoticeDAO();
				int result = noticeDAO.write(noticeTitle,userID,noticeContent);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 등록되었습니다.')");
					script.println("location.href='notice.jsp'");
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