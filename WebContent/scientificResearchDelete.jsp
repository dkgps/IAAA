<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="research.ResearchDTO" %>
<%@ page import="research.ResearchDAO" %>
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
			script.close();
		}
		
		int researchID=0;
		
		if(request.getParameter("researchID")!=null){
			researchID = Integer.parseInt(request.getParameter("researchID"));
		}
		if(researchID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href='scientificResearch.jsp'");
			script.println("</script>");
			script.close();
		}	
	
		ResearchDTO research = new ResearchDAO().getResearch(researchID);
		if(!userID.equals(research.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.');");
			script.println("location.href='scientificResearch.jsp'");
			script.println("</script>");
			script.close();
		}else{
			ResearchDAO researchDAO = new ResearchDAO();
			int result = researchDAO.researchDelete(researchID);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 삭제되었습니다.');");
					script.println("location.href='scientificResearch.jsp';");
					script.println("</script>");
				}else if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제에 실패했습니다.');");
					script.println("history.back();");
					script.println("</script>");
				}
			
		}	
		
			
	%>
</body>
</html>