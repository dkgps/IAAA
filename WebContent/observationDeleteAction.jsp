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
		else{
			
			
				ObservationDAO observationDAO = new ObservationDAO();
				int result = observationDAO.delete(observationID);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 삭제되었습니다.');");
					script.println("location.href='observation.jsp';");
					script.println("</script>");
				}else if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.');");
					script.println("history.back();");
					script.println("</script>");
				}
			
		
		
		}
	%>
</body>
</html>