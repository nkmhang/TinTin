<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
var rs_gopy__MMColParam = "1";
if (String(Request.QueryString("user")) != "undefined" && 
    String(Request.QueryString("user")) != "") { 
  rs_gopy__MMColParam = String(Request.QueryString("user"));
}
%>
<%
var rs_gopy_cmd = Server.CreateObject ("ADODB.Command");
rs_gopy_cmd.ActiveConnection = MM_connectdb_STRING;
rs_gopy_cmd.CommandText = "SELECT * FROM dbo.GopY WHERE UserName = ? ORDER BY MaGopY DESC";
rs_gopy_cmd.Prepared = true;
rs_gopy_cmd.Parameters.Append(rs_gopy_cmd.CreateParameter("param1", 200, 1, 20, rs_gopy__MMColParam)); // adVarChar

var rs_gopy = rs_gopy_cmd.Execute();
var rs_gopy_numRows = 0;
%>
<%
var Repeat2__numRows = 10;
var Repeat2__index = 0;
rs_gopy_numRows += Repeat2__numRows;
%>
<%
		if (Session("MM_Username")== "" || Session("MM_Username")== null)
		{
			Response.Redirect("dangnhap.asp");
		}
%>
<!DOCTYPE HTML>
<!--
	Verti by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html><!-- InstanceBegin template="/Templates/pages.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>
    <!--#include file="Connections/connectdb.asp" -->
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
<!-- InstanceBeginEditable name="doctitle" -->
	<title>TinTin</title>
	<!-- InstanceEndEditable -->
<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    <!-- InstanceBeginEditable name="head" -->
    <!-- InstanceEndEditable -->
</head>
	<body class="no-sidebar" onLoad="MKT();">
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
									<li class="current"><a href="home.asp" target="_blank">Welcome</a></li>
									<li>
										<a href="dochoi_all.asp">Sản Phẩm</a>
										<ul>
                                          <% while ((Repeat1__numRows-- != 0) && (!rs_Loai.EOF)) { %>
                                          <li><a href="dochoi.asp?maloai=<%=(rs_Loai.Fields.Item("MaTheLoai").Value)%>"><%=(rs_Loai.Fields.Item("Ten").Value)%></a></li>
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

			<!-- Main -->
			<!-- InstanceBeginEditable name="EditRegion3" -->
			<div id="main-wrapper">
			  <div class="container">
              <div align="center">
                <p style="font-size:36px; color:#ff711d; text-align:center;" align="center" >Nội dung đã Góp Ý</p>
                <% while ((Repeat2__numRows-- != 0) && (!rs_gopy.EOF)) { %>
                  <form name="xemgopy" style="width:600px">
                    <hr />
                    <table width="600" height="auto" border="0" cellpadding="10" cellspacing="0" style="background-color: transparent;">
                      <tr>
                        <th width="150" scope="row">Ngày Góp Ý</th>
                        <td><%=(rs_gopy.Fields.Item("NgayGopY").Value)%></td>
                      </tr>
                      <tr>
                        <th scope="row">Nội dung:</th>
                        <td width="410"><textarea name="gopy" cols="100" rows="4" readonly><%=(rs_gopy.Fields.Item("NoiDungGopY").Value)%></textarea></td>
                      </tr>
                      <tr>
                        <th scope="row">Trạng Thái:</th>
                        <td>Đã duyệt
                          <input <%=(((rs_gopy.Fields.Item("TrangThai").Value) == 1)?"checked=\"checked\"":"")%> type="radio" name="trangthai" value="1" disabled="disabled" />
                          Chưa duyệt
                          <input <%=(((rs_gopy.Fields.Item("TrangThai").Value) == 0)?"checked=\"checked\"":"")%> type="radio" name="trangthai" value="0" disabled="disabled"/></td>
                      </tr>
                      <tr>
                        <th scope="row">Trả lời từ Admin:</th>
                        <td><textarea name="traloi" cols="100" rows="4" readonly><%=(rs_gopy.Fields.Item("NoiDungTraLoi").Value)%></textarea></td>
                      </tr>
                      <tr>
                        <th colspan="2" scope="row"><hr />
                        </th>
                      </tr>
                    </table>
                  </form>
                  <%
  Repeat2__index++;
  rs_gopy.MoveNext();
}
%>
              </div>
              </div>
		    </div>
			<!-- InstanceEndEditable -->
			<!-- Footer -->
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
									<section class="widget contact">
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

			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
    <%
	rs_Loai.Close();
	%>

<!-- InstanceEnd --></html>
<%
rs_gopy.Close();
%>
