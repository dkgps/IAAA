<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "photo2.Photo2DAO" %>
<%@ page import = "photo2.Photo2DTO" %>
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
<title>photoUpdateAction</title>
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
		int photoID = 0;
		if(request.getParameter("photoID")!=null){
			photoID = Integer.parseInt(request.getParameter("photoID"));
		}
		if(photoID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back();");
			script.println("</script>");	
		}
		String directory = application.getRealPath("/iaaaphoto").replaceAll("\\\\","/");
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
		
		Photo2DAO photo2DAO = new Photo2DAO();
		String photoFile = null;
		String photoRealFile = null;
		
		File file = multipartRequest.getFile("photoFile");
		if(file != null){
			photoFile = multipartRequest.getOriginalFileName("photoFile");
			photoRealFile = multipartRequest.getFilesystemName("photoFile");
			String prev = photo2DAO.getData(photoID).getRealFileName();
			File prevFile = new File(directory + "/" + prev);
			if(prevFile.exists()){
				prevFile.delete();
			}
		}else{
			photoFile = photo2DAO.getData(photoID).getFileName();
			photoRealFile = photo2DAO.getData(photoID).getRealFileName();
		}
		 
		
		int result = photo2DAO.update(photoID,photoTitle,photoContent,photoFile,photoRealFile);
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글이 수정되었습니다.')");
				script.println("location.href='photo2View.jsp?photoID="+photoID+"'");
				script.println("</script>");
			}else if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.')");
				script.println("history.back();");
				script.println("</script>");
			}
		
		
%>
</body>
</html>