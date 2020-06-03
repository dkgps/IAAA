<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="observation.ObservationDTO" %>
<%@ page import="observation.ObservationDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>


<%!
	public static String getClientIP(HttpServletRequest request){
		String ip = request.getHeader("X-FORWARDED-FOR"); 
		if(ip==null || ip.length() ==0){
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip==null || ip.length() ==0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip==null || ip.length() ==0){
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
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
				int result = observationDAO.like(userID, observationID,getClientIP(request));
				if(result == 1){
					result = observationDAO.likeUp(observationID);
					if(result == 1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('추천이 완료되었습니다.');");
						script.println("location.href='observationView.jsp?observationID="+observationID+"';");
						script.println("</script>");
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('오류가 발생하였습니다.');");
						script.println("location.href='observationView.jsp?observationID="+observationID+"';");
						script.println("</script>");
					}
					
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 추천한 글입니다.');");
					script.println("history.back();");
					script.println("</script>");
				}
			
		
		
		}
	%>
