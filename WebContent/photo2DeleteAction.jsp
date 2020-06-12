<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "photo2.Photo2DAO" %>
<%@ page import = "photo2.Photo2DTO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DeleteAction</title>
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
		int photoID= 0;
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
		else{
			Photo2DAO photo2DAO = new Photo2DAO();
			try{
				String prev = photo2DAO.getData(photoID).getRealFileName();
				if(prev!=null){
					String directory = application.getRealPath("/iaaaphoto").replaceAll("\\\\","/");
					File prevFile = new File(directory + "/" + prev);
					if(prevFile.exists()){
						prevFile.delete();
					}
				}
			}catch (Exception e){
				e.printStackTrace();
			}
				
				int result = photo2DAO.delete(photoID);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글이 삭제되었습니다.');");
					script.println("location.href='photo2.jsp';");
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