<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="notice.Notice" %>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>I.A.A.A</title>
<style type="text/css">
	td {
		color:gray;
	}
	td a{
		color: #000;
		text-decoration:none;
	}
	.td-title{
		width:65%;
	}
</style>
<link rel="icon" type="image/x-icon" href="assets/img/star.gif" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles2.css" rel="stylesheet" />
</head>
<body id="page-top">
<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

%>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="assets/img/navbar-logo.png" alt="" /></a><button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu<i class="fas fa-bars ml-1"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                    	
<%
	if(userID==null){	
						
%>				
						<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#notice">Notice</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#portfolio">Portfolio</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#contact">Contact</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="login.jsp">Login</a></li>
						
<%
	}else{
%>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="notice.jsp">Notice</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#contact">Contact</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="logoutAction.jsp">Logout</a></li>
<%
	}
%>
    
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead">
            <div class="container">
                <div class="masthead-subheading">Welcome To IAAA</div>
                
<%
	if(userID==null){
%>
                <div class="masthead-heading text-uppercase">It's Nice To Meet You</div>
                <a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger" href="join.jsp">Join us</a>
<%
	}else{
%>
            	<div class="masthead-heading text-uppercase">Let's go to SPACE!</div>
            	<a class="btn btn-primary btn-md text-uppercase js-scroll-trigger" style="padding:1.2rem;" href="#portfolio">OBSERVING</a>
<%
	}
%>
            </div>
        </header>
        <!-- Notice -->
        <section class="page-notice" id="notice">
        	<div class="container">
        		<div class="text-center">
        			<h2 class="section-heading text-uppercase">Notice</h2>
        			<h3 class="section-subheading text-muted">notice from IAAA</h3>
        			<br>
        			<table class="table table-striped" style="text-align:center; border : 1px solid #ddd">
        				<tbody>
        					<%
        						NoticeDAO noticeDAO = new NoticeDAO();
        						ArrayList<Notice> list = noticeDAO.getList(pageNumber);
        						if(list.size()<7){
        							
        							for(int i=0; i<list.size(); i++){
        					%>
        					<tr>
        						<td class=td-title><a href="noticeView.jsp?noticeID=<%= list.get(i).getNoticeID()%>"><%= list.get(i).getNoticeTitle()%></a></td>
        						<td><%= list.get(i).getUserID() %></td>
        						<td><%= list.get(i).getNoticeDate().substring(0,11)+list.get(i).getNoticeDate().substring(11,13)+":"+ list.get(i).getNoticeDate().substring(14,16)%></td>
        					</tr>
        					<%
        							}
        						}else{
        							for(int i=0; i<7; i++){
        					%>
        					<tr>
        						<td class=td-title style="color:black;"><a href="noticeView.jsp?noticeID=<%= list.get(i).getNoticeID()%>"><%= list.get(i).getNoticeTitle()%></a></td>
        						<td><%= list.get(i).getUserID() %></td>
        						<td><%= list.get(i).getNoticeDate().substring(0,11)+list.get(i).getNoticeDate().substring(11,13)+":"+ list.get(i).getNoticeDate().substring(14,16)%></td>
        					</tr>
        					<%
        							}
        						}
        					%>
        				</tbody>
        			</table>
        		</div>
        	</div>
        </section>

     
        <!-- Portfolio Grid-->
        <section class="page-section bg-light" id="portfolio">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Portfolio</h2>
                    <h3 class="section-subheading text-muted">These are things you will experience when you join the IAAA.</h3>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="portfolio-item">
                        
<%	if(userID==null){ %>
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal1">
                            	<div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                
<%	}else{ %>
							<a class="portfolio-link"  href="photo1.jsp">
<%	} %>
                                <img class="img-fluid" src="assets/img/galaxy.jpg" alt=""/>
                            </a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">PHOTO 1</div>
                                <div class="portfolio-caption-subheading text-muted">Photos of Star</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="portfolio-item">
<%	if(userID==null){ %>
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal2">
                            	<div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                
<%	}else{ %>
							<a class="portfolio-link"  href="photo2.jsp">
<%	} %>
                                <img class="img-fluid" src="assets/img/photo2.JPG" alt=""/></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">PHOTO 2</div>
                                <div class="portfolio-caption-subheading text-muted">Photos of IAAA</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal3"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="assets/img/star1.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">Observation</div>
                                <div class="portfolio-caption-subheading text-muted">Describe your observations!</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4 mb-lg-0">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal4"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="assets/img/research.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">Scientific Research</div>
                                <div class="portfolio-caption-subheading text-muted">Deep Sky, Academic Research..</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 mb-4 mb-sm-0">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal5"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="assets/img/free.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">Free board</div>
                                <div class="portfolio-caption-subheading text-muted">Free board</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="portfolio-item">
                            <a class="portfolio-link" data-toggle="modal" href="#portfolioModal6"
                                ><div class="portfolio-hover">
                                    <div class="portfolio-hover-content"><i class="fas fa-plus fa-3x"></i></div>
                                </div>
                                <img class="img-fluid" src="assets/img/about.jpg" alt=""
                            /></a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">About Me</div>
                                <div class="portfolio-caption-subheading text-muted">Introducing IAAA Members</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
      
       
        <!-- Contact-->
        <section class="page-section" id="contact">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Contact Us</h2>
                    <h3 class="section-subheading text-muted">아래의 사항을 기입해주세요</h3>
                </div>
                <form id="contactForm" name="sentMessage"  method="post" action="contactAction.jsp">
                    <div class="row align-items-stretch mb-5">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input class="form-control" id="contactName" type="text" placeholder="Your Name *" required="required" data-validation-required-message="Please enter your name." />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="form-group">
                                <input class="form-control" id="contactEmail" type="email" placeholder="Your Email *" required="required" data-validation-required-message="Please enter your email address." />
                                <p class="help-block text-danger"></p>
                            </div>
                            <div class="form-group mb-md-0">
                                <input class="form-control" id="contactPhone" type="text" placeholder="Your Phone *" required="required" data-validation-required-message="Please enter your phone number." />
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group form-group-textarea mb-md-0">
                                <textarea class="form-control" id="contactMessage" placeholder="Your Message *" required="required" data-validation-required-message="Please enter a message."></textarea>
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <div id="success"></div>
                        <button class="btn btn-primary btn-xl text-uppercase" id="sendMessageButton" type="submit">Send Message</button>
                    </div>
                </form>
            </div>
        </section>
        <!-- Footer-->
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-left">Copyright © IAAA</div>
                    <div class="col-lg-4 my-3 my-lg-0">
                        <a class="btn btn-dark btn-social mx-2" href="https://www.instagram.com/iaaa_inha/?hl=ko"><i class="fab fa-instagram"></i></a><a class="btn btn-dark btn-social mx-2" href="#!"><i class="fab fa-facebook-f"></i></a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Portfolio Modals--><!-- Modal 1-->
        <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">PHOTO 1</h2>
                                    <p class="item-intro text-muted">Photos of Star</p>
                                    <img class="img-fluid d-block mx-auto" src="assets/img/portfolio/01-full.jpg" alt="" />
                                    <p>소규모 관측회 또는 정기 관측회에서 IAAA 부원들이 찍은 사진을 올립니다. 세미나에서 배운 내용을 활용하여 찍은 딥스카이 사진을 다른 부원들과 함께 공유해보세요!</p>
                                    <ul class="list-inline">
                                        <li>Date: January 2020</li>
                                        <li>Picture By: OOO</li>
                                        <li>200mm ISO 1600 F/4</li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i>Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 2-->
        <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">PHOTO 2</h2>
                                    <p class="item-intro text-muted">Photos of IAAA</p>
                                    <img class="img-fluid d-block mx-auto" src="assets/img/portfolio/02-full.jpg" alt="" />
                                    <p>출사, 정기 관측회, 소규모 관측회, 공개 관측회, 세미나, 관측여행, MT 등 IAAA의 활동 사진이 담긴 갤러리입니다.</p>
                                    
                                    <ul class="list-inline">
                                        <li>Date: January 2020</li>
                                        <li>Activity: 관측여행</li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i>Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 3-->
        <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">Observation</h2>
                                    <p class="item-intro text-muted">Describe your observations!</p>
                                    <img class="img-fluid d-block mx-auto" src="assets/img/portfolio/03-full.jpg" alt="" />
                                    <p>IAAA의 다양한 관측회의 관측 후기를 볼 수 있습니다. 관측 시간, 월령 및 날씨, 관측 별자리, 관측 대상과 망원경 종류, 아이피스 종류, 함께 간 사람, 느낀점 등을 자유롭게 작성해주시면 됩니다.</p>
                                    <ul class="list-inline">
                                        <li>Date: January 2020</li>
                                        <li>Members: XXX,YYY,ZZZ</li>
                                        <li>Activity: 소규모 관측</li>
                                    </ul>
                                    <button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i>Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 4-->
        <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">Scientific Research</h2>
                                    <p class="item-intro text-muted">Deep Sky, Academic research,,</p>
                                    <img class="img-fluid d-block mx-auto" src="assets/img/portfolio/04-full.jpg" alt="" />
                                    <p>딥스카이에 관한 학술지, 논문, 블로그 포스팅 자료, 사진 등 자유롭게 공유할 수 있습니다. </p>
                                
                                    <button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i>Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 5-->
        <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">Free Board</h2>
                                    <p class="item-intro text-muted">Free Board</p>
                                    <img class="img-fluid d-block mx-auto" src="assets/img/portfolio/05-full.jpg" alt="" />
                                    <p>자유 게시판 입니다!</p>           
                                    <button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i>Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal 6-->
        <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">
                                    <!-- Project Details Go Here-->
                                    <h2 class="text-uppercase">About Me</h2>
                                    <p class="item-intro text-muted">Introducing IAAA Members</p>
                                    <img class="img-fluid d-block mx-auto" src="assets/img/portfolio/06-full.jpg" alt="" />
                                    <p>IAAA의 부원들을 소개합니다!</p>

                                    <button class="btn btn-primary" data-dismiss="modal" type="button"><i class="fas fa-times mr-1"></i>Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts2.js"></script>
    </body>
</html>
