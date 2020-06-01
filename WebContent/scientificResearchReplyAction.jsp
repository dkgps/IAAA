<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="research.ResearchDTO" %>
<%@ page import="research.ResearchDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scientificResearchWriteAction</title>
</head>
<body>
	<%	
		ResearchDTO research = new ResearchDTO();
	
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
		
		
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 * 100;
		String encoding ="UTF-8";
		
		MultipartRequest multipartRequest 
		= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
	
		
		String researchTitle = multipartRequest.getParameter("researchTitle");
		String researchContent = multipartRequest.getParameter("researchContent");
		if(researchTitle == null || researchContent==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("location.href='scientificResearchWrite.jsp'");
			script.println("</script>");
		}
		
		
		String researchFile = multipartRequest.getOriginalFileName("researchFile");
		String researchRealFile = multipartRequest.getFilesystemName("researchFile");
		
		
		int researchID = 0;
		if(multipartRequest.getParameter("researchID")!=null){
			researchID = Integer.parseInt(multipartRequest.getParameter("researchID"));
		}
		if(researchID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href='scientificResearch.jsp'");
			script.println("</script>");
		}
		

		
		ResearchDAO researchDAO = new ResearchDAO();
		ResearchDTO parent = researchDAO.getResearch(researchID);
		researchDAO.replyUpdate(parent);
		int result = researchDAO.reply(userID, researchTitle, researchContent, researchFile, researchRealFile, parent);
		if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 게시물이 작성되었습니다.')");
				script.println("location.href='scientificResearch.jsp'");
				script.println("</script>");	
			
		}
	%>
</body>
</html>