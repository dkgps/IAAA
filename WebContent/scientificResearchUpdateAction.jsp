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
<title>scientificResearchUpdateAction</title>
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
		}else{
			int researchID = 0;
			if(request.getParameter("researchID")!=null){
				researchID = Integer.parseInt(request.getParameter("researchID"));
			}
			if(researchID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.');");
				script.println("location.href='scientificResearch.jsp'");
				script.println("</script>");
			}
			
			ResearchDAO researchDAO = new ResearchDAO();
			ResearchDTO research = researchDAO.getResearch(researchID);
			if(!userID.equals(research.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.');");
				script.println("location.href='freeBoard.jsp'");
				script.println("</script>");
			}else{
				
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
				
				String researchFile = null;
				String researchRealFile = null;
				File file = multipartRequest.getFile("researchFile");
				if(file != null){
					researchFile = multipartRequest.getOriginalFileName("researchFile");
					researchRealFile = multipartRequest.getFilesystemName("researchFile");
					String prev = researchDAO.getResearchRealFile(researchID);
					File prevFile = new File(directory + "/" + prev);
					if(prevFile.exists()){
						prevFile.delete();
					}
				}else{
					researchFile = researchDAO.getResearchFile(researchID);
					researchRealFile = researchDAO.getResearchRealFile(researchID);
				}
				
				
				int result = researchDAO.researchUpdate(researchID,researchTitle,researchContent,researchFile,researchRealFile);
					if(result == 1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글이 수정되었습니다.')");
						script.println("location.href='scientificResearchView.jsp?researchID="+researchID+"'");
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
			
		
		
		
%>
</body>
</html>