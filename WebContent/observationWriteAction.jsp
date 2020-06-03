<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="observation.ObservationDTO" %>
<%@ page import="observation.ObservationDAO" %>
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
		ObservationDTO observationDTO = new ObservationDTO();
	
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
			
			int observationYear = 0;
			String observationDivide = null;
			String observationTitle = null;
			String observationContent = null;
			
			
			if(request.getParameter("observationYear") != null){
				observationYear = Integer.parseInt(request.getParameter("observationYear"));
			}
			if(request.getParameter("observationDivide") != null){
				observationDivide = (String)request.getParameter("observationDivide");
			}
			if(request.getParameter("observationTitle") != null){
				observationTitle = (String)request.getParameter("observationTitle");
			}
			if(request.getParameter("observationContent") != null){
				observationContent = (String)request.getParameter("observationContent");
			}
			
			if(observationTitle==null || observationContent==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back();");
				script.println("</script>");	
			}else{
				ObservationDAO observationDAO = new ObservationDAO();
				int result = observationDAO.write(userID,observationYear,observationDivide,observationTitle,observationContent);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 등록되었습니다.');");
					script.println("location.href='observation.jsp';");
					script.println("</script>");
				}else if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 등록에 실패했습니다.');");
					script.println("history.back();");
					script.println("</script>");
				}
			}
		
		
		}
	%>
</body>
</html>