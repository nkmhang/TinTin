<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
    <!--#include file="../Connections/connectdb.asp" -->
	<%
    var rs_Loai_cmd = Server.CreateObject ("ADODB.Command");
    rs_Loai_cmd.ActiveConnection = MM_connectdb_STRING;
    rs_Loai_cmd.CommandText = "SELECT * FROM dbo.TheLoai";
    rs_Loai_cmd.Prepared = true;
    
    var rs_Loai = rs_Loai_cmd.Execute();
    var rs_Loai_numRows = 0;
    %>
    <%
	var Repeat1__numRows = -1;
	var Repeat1__index = 0;
	rs_Loai_numRows += Repeat1__numRows;
	%>
<!-- TemplateBeginEditable name="doctitle" -->
<title>TinTin</title>
<!-- TemplateEndEditable -->
<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    <!-- TemplateBeginEditable name="head" -->
<!-- TemplateEndEditable -->
</head>
	<body class="homepage">
		<div id="page-wrapper">

			<!-- Header -->
				<div id="header-wrapper">
					<header id="header" class="container">

						<!-- Logo -->
							<div id="logo">
								<h1>TinTin</h1>
							</div>

						<!-- Nav -->
							<nav id="nav">
								<ul>
									<li class="current"><a href="../home.asp" target="_blank">Welcome</a></li>
									<li>
										<a href="../dochoi_all.asp">Sản Phẩm</a>
										<ul>
                                          <% while ((Repeat1__numRows-- != 0) && (!rs_Loai.EOF)) { %>
                                          <li><a href="../dochoi.asp?maloai=<%=(rs_Loai.Fields.Item("MaTheLoai").Value)%>"><%=(rs_Loai.Fields.Item("Ten").Value)%></a></li>
                                          <%
                                          Repeat1__index++;
                                          rs_Loai.MoveNext();
                                        }
                                        %>
                                        </ul>
									</li>
                                   <%
								   	if(Session("MM_Username") == "" || Session("MM_Username") == null)
									{
										Response.Write("<li><a href = 'dangnhap.asp'>Đăng Nhập</a></li><li><a href = 'dangky.asp'>Đăng Ký</a></li>");
									}
									else
									{
										Response.Write("<li><a href = 'chitietkhachhang.asp?user="+Session("MM_Username")+"'>Xin chào " +Session("MM_Username")+"</a>|<a href = 'thoat.asp'>Thoát</a></li><li><a href = 'themgopy.asp'>Góp Ý</a></li>");
									}
								   %>	
								</ul>
							</nav>

					</header>
				</div>
				<!-- TemplateBeginEditable name="EditRegion3" -->
                <!-- Banner -->
                <div id="banner-wrapper">
                  <div id="banner" class="box container">
                    <div class="row">
                      <div class="7u 12u(medium)">
                        <h2 align="center">Hi. This is TinTin.</h2>
                        <p align="center" style="color:#ff4486">Trang mua sắm trực tuyến các loại đồ chơi dễ thương cho thiếu nhi.</p>
                      </div>
                      <div class="5u 12u(medium)">
                        <ul>
                          <li><a href='../home.asp' class='button big icon fa-arrow-circle-right'>Trang User</a></li>
                          <li><a href='../admin.asp' class='button alt big icon fa-arrow-circle-right'>Trang Admin</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Features -->
                <div id="features-wrapper">
                  <div class="container">
                    <div class="row">
                      <div class="4u 12u(medium)">
                        <!-- Box -->
                        <section class="box feature">
                          <div class="image featured"><img src="../images/pic01.jpg" alt="" /></div>
                          <div class="inner">
                            <header>
                              <h2>Khơi gợi khả năng sáng tạo</h2>
                            </header>
                            <p>Bạn cứ thử quan sát bé chơi với những mẩu Lego chẳng hạn: ban đầu, bé chỉ biết xếp chúng chồng lên nhau, nhưng sau đó bé sẽ có thể tạo nên rất nhiều hình thù khác nhau. Khả năng tưởng tượng và sáng tạo của bé đã khác hẳn đi đấy chứ.</p>
                          </div>
                        </section>
                      </div>
                      <div class="4u 12u(medium)">
                        <!-- Box -->
                        <section class="box feature">
                          <div class="image featured"><img src="../images/pic02.jpg" alt="" /></div>
                          <div class="inner">
                            <header>
                              <h2>Tăng năng lực tự nhận thức</h2>
                            </header>
                            <p>Chơi với một bộ khối hình chẳng hạn, bé sẽ dần dần tự rút ra được cho mình những kết luận quan trọng như khối tròn lăn được còn khối vuông thì không; hay từ vài em búp bê và thú bông, bé có thể cùng bạn chơi đồ hàng, chơi trò cô giáo…</p>
                          </div>
                        </section>
                      </div>
                      <div class="4u 12u(medium)">
                        <!-- Box -->
                        <section class="box feature">
                          <div class="image featured"><img src="../images/pic03.jpg" alt="" /></div>
                          <div class="inner">
                            <header>
                              <h2>Phát triển kỹ năng</h2>
                            </header>
                            <p>Cung cấp đúng loại đồ chơi cho bé ở đúng lứa tuổi sẽ giúp cung cấp cả những kỹ năng cứng lẫn mềm – những hạt giống đầu tiên nhưng có thể nói là quan trọng nhất đối với sự phát triển tinh thần của bé. Đó là những kỹ năng ngôn ngữ, bày tỏ cảm xúc, kỹ năng hoạt động xã hội…</p>
                          </div>
                        </section>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Main -->
                <div id="main-wrapper">
                  <div class="container">
                    <div class="row 200%">
                      <div class="4u 12u(medium)">
                        <!-- Sidebar -->
                        <div id="sidebar">
                          <section class="widget thumbnails">
                            <h3>Ích lợi từ <span style="color:#ff4486">TinTin</span></h3>
                            <div class="grid">
                              <div class="row 50%">
                                <div class="6u">
                                  <div class="image fit"><img src="../images/pic04.jpg" alt="" /></div>
                                </div>
                                <div class="6u">
                                  <div class="image fit"><img src="../images/pic05.jpg" alt="" /></div>
                                </div>
                                <div class="6u">
                                  <div class="image fit"><img src="../images/pic06.jpg" alt="" /></div>
                                </div>
                                <div class="6u">
                                  <div class="image fit"><img src="../images/pic07.jpg" alt="" /></div>
                                </div>
                              </div>
                            </div>
                          </section>
                        </div>
                      </div>
                      <div class="8u 12u(medium) important(medium)">
                        <!-- Content -->
                        <div id="content">
                          <section align="center" class="last">
                            <h2>Bạn nhận được gì khi đến với <span style="color:#F09">TinTin</span></h2>
                            <p>
                            <ul style="list-style-type:none;font-size:25px;font-weight:bold">
                              <li>Giá rẻ hơn</li>
                              <li>Sự tiện lợi</li>
                              <li>Nhiều sự lựa chọn</li>
                              <li>Giao hàng tận nơi</li>
                            </ul>
                            <p></p>
                          </section>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
				<!-- TemplateEndEditable --><!-- Footer -->
				<div id="footer-wrapper">
					<footer id="footer" class="container">
						<div class="row">
							<div class="3u 6u(medium) 12u$(small)">

								<!-- Links -->
									<section class="widget links">
										<h3>Các đối tác liên kết</h3>
										<ul class="style2">
											<li>www.lego.com</li>
											<li>www.hasbro.com</li>
											<li>www.fisher-price.com</li>
											<li>www.megabloks.com</li>
											<li>www.nintendo.com</li>
										</ul>
									</section>

							</div>
							<div class="3u 6u(medium) 12u$(small)">

								<!-- Links -->
									<section class="widget links">
										<h3>Các kho hàng của <span style="color:#ff4486">TinTin</span></h3>
										<ul class="style2">
											<li>Thành phố Hồ Chí Minh</li>
											<li>Hà Nội</li>
											<li>Hải Phòng</li>
											<li>Đà Nẵng</li>
											<li>Cần Thơ</li>
										</ul>
									</section>

							</div>
							<div class="3u 6u$(medium) 12u$(small)">

								<!-- Contact -->
									<section class="widget contact last">
										<h3>Contact Us</h3>
										<ul>
											<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
											<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
											<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
											<li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
											<li><a href="#" class="icon fa-pinterest"><span class="label">Pinterest</span></a></li>
										</ul>
										<p>980 CMT8 Q.3 TP.HCM</p>
									</section>

							</div>
						</div>
						<div class="row">
							<div class="12u">
								<div id="copyright">
									<ul class="menu">
										<li>&copy; TinTin. All rights reserved</li>
									</ul>
								</div>
							</div>
						</div>
					</footer>
				</div>

	</div>

		<!-- Scripts -->

			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../assets/js/main.js"></script>

	</body>
    <%
	rs_Loai.Close();
	%>
</html>
