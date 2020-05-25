<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="util.SHA256" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>login</title>
</head>
<body>
<%	
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	/* if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인되어 있습니다.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");		
		script.close();
		return;
	} */
	
	String userPassword = null;
	String userName = null;
	String userEmail = null;
	
	if(request.getParameter("userID") != null){
		userID = (String)request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null){
		userPassword = (String)request.getParameter("userPassword");
	}
	if(request.getParameter("userName") != null){
		userName = (String)request.getParameter("userName");
	}
	if(request.getParameter("userEmail") != null){
		userEmail = (String)request.getParameter("userEmail");
	}
	
	if(userID==null || userPassword ==null || userName==null || userEmail == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");		
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userID,userPassword,userName,userEmail,SHA256.getSHA256(userEmail),false));
		if(result == 1){
 			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입이 완료되었습니다.');");
			script.println("location.href='index.jsp'");
			script.println("</script>");		
			script.close(); 
			return;
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다');");
			script.println("history.back();");
			script.println("</script>");		
			script.close();
			return;
		}
	
%>
	
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>