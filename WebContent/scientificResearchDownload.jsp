<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "research.ResearchDAO" %>
<%@ page import = "research.ResearchDTO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale='1'">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/nav.css">
<style>
li{
margin-left:1.5rem;
}

a:link{
text-decoration:none;
}
</style>
<title>학술 연구 자료 게시판</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int researchID = Integer.parseInt(request.getParameter("researchID"));
	if(researchID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.');");
		script.println("location.href='scientificResearch.jsp'");
		script.println("</script>");
	}
	

	
	String root = application.getRealPath("/");
	String savePath = root + "upload";
	String fileName="";
	String realFileName="";
	
	ResearchDAO researchDAO = new ResearchDAO();
	fileName = researchDAO.getResearchFile(researchID);
	realFileName = researchDAO.getResearchRealFile(researchID);
	
	if(fileName.equals("") || realFileName.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근할 수 없습니다.');");
		script.println("location.href='scientificResearch.jsp'");
		script.println("</script>");
	}
	
	InputStream in = null;
	OutputStream os = null;
	File file = null;
	boolean skip = false;
	String client = "";
	try{
		try{
			file = new File(savePath, realFileName);
			in = new FileInputStream(file);
		}catch (FileNotFoundException e){
			skip = true;
		}
		client = request.getHeader("User-Agent");
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description","JSP Generated Data");
		if(!skip){
			if(client.indexOf("MSIE")!= -1){
				response.setHeader("Content-Disposition","attachment; filename=" +
			new String(fileName.getBytes("KSC5601"),"ISO8859_1"));
			}else{
				fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
				response.setHeader("Content-Disposition","attachment; filename=\"" + fileName + "\"");
				response.setHeader("Content-Type","application/octet-stream; charset=UTF-8");
			}
			response.setHeader("Content-Length", "" +file.length());
			os = response.getOutputStream();
			byte b[] = new byte[(int)file.length()];
			int leng = 0;
			while((leng=in.read(b))>0){
				os.write(b,0,leng);
			}
		}else{
			response.setContentType("text/html; charset=UTF-8");
			out.println("<script>alert('파일을 찾을 수 없습니다.');history.back();</script>");
		}
		in.close();
		os.close();
	}catch (Exception e){
		e.printStackTrace();
	}
	
	
	

%>
	
</body>
</html>