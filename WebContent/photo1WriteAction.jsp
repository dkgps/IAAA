<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "photo1.Photo1DAO" %>
<%@ page import = "photo1.Photo1DTO" %>
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
		
		String directory = application.getRealPath("/starphoto").replaceAll("\\\\","/");
		int maxSize = 1024 * 1024 * 100;
		String encoding ="UTF-8";
		
		MultipartRequest multipartRequest 
		= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
	
		
		String photoTitle = multipartRequest.getParameter("photoTitle");
		String photoContent = multipartRequest.getParameter("photoContent");
		if(photoTitle == null || photoContent==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
		
		
		String photoFile = multipartRequest.getOriginalFileName("photoFile");
		String realFileName =  multipartRequest.getFilesystemName("photoFile");
		
		
		Photo1DAO photo1DAO = new Photo1DAO();
		int result = photo1DAO.write(photoTitle, photoContent, userID, photoFile, realFileName);
		if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 게시물이 작성되었습니다.')");
				script.println("location.href='photo1.jsp'");
				script.println("</script>");	
			
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시물이 작성에 실패하였습니다.')");
			script.println("location.href='photo1.jsp'");
			script.println("</script>");	
		}
	%>
</body>
</html>