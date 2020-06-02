<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="aboutme.AboutMeDTO" %>
<%@ page import="aboutme.AboutMeDAO" %>
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
		AboutMeDTO aboutMeDTO = new AboutMeDTO();
	
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
		
		int aboutMeID = 0;
		if(request.getParameter("aboutMeID")!=null){
			aboutMeID = Integer.parseInt(request.getParameter("aboutMeID"));
		}
		if(aboutMeID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='aboutMe.jsp'");
			script.println("</script>");
		}
		else{
			
			String aboutMeTitle = null;
			String aboutMeContent = null;
			
			if(request.getParameter("aboutMeTitle") != null){
				aboutMeTitle = (String)request.getParameter("aboutMeTitle");
			}
			if(request.getParameter("aboutMeContent") != null){
				aboutMeContent = (String)request.getParameter("aboutMeContent");
			}
			
			if(aboutMeTitle==null || aboutMeContent==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back();");
				script.println("</script>");	
			}else{
				AboutMeDAO aboutMeDAO = new AboutMeDAO();
				int result = aboutMeDAO.update(aboutMeID,aboutMeTitle,aboutMeContent);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정이 완료되었습니다.');");
					script.println("location.href='aboutMeView.jsp?aboutMeID="+aboutMeID+"'");
					script.println("</script>");
				}else if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.');");
					script.println("history.back();");
					script.println("</script>");
				}
			}
		
		
		}
	%>
</body>
</html>