<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
// *** Edit Operations: declare variables

// set the form action variable
var MM_editAction = Request.ServerVariables("SCRIPT_NAME");
if (Request.QueryString) {
  MM_editAction += "?" + Server.HTMLEncode(Request.QueryString);
}

// boolean to abort record edit
var MM_abortEdit = false;
%>
<%
if (String(Request("MM_insert")) == "register") {
  if (!MM_abortEdit) {
    // execute the insert
	
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "INSERT INTO dbo.KhachHang (UserName, Password, HoTen, GioiTinh, NgaySinh, Email) VALUES (?, ?, ?, ?, ?, ?)";
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 201, 1, 20, Request.Form("username"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param2", 201, 1, 20, Request.Form("password"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param3", 202, 1, 50, Request.Form("hoten"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param4", 5, 1, -1, (String(Request.Form("gioitinh")) != "undefined" && String(Request.Form("gioitinh")) != "") ? Request.Form("gioitinh") : null)); // adDouble
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param5", 201, 1, 30, Request.Form("dob"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param6", 201, 1, 50, Request.Form("email"))); // adLongVarChar
    MM_editCmd.Execute();
    MM_editCmd.ActiveConnection.Close();

    // append the query string to the redirect URL
    var MM_editRedirectUrl = "dangnhap.asp";
    if (MM_editRedirectUrl && Request.QueryString && Request.QueryString.Count > 0) {
      MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1) ? "?" : "&") + Request.QueryString;
    }
    Response.Redirect(MM_editRedirectUrl)
  }
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
              <script>
			  window.onload = function MKT()
{
	var capchar= Math.round(Math.random()*999999);
	document.getElementById('ngau_nhien').innerHTML=capchar;
}
function check_dangky()
{
	    			var code = document.getElementById('ngau_nhien').innerHTML;
					var reg_trang = /\s/g;
					var reg_hoten = /  +/;
					var reg_ngay = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
					var reg_mail = /^[A-Za-z0-9]+([_\.\-]?[A-Za-z0-9])*@[A-Za-z0-9]+([\.\-]?[A-Za-z0-9]+)*(\.[A-Za-z]+)+$/;
					
					var username = document.getElementById("username").value;
					var password = document.getElementById("password").value;
					var repass = document.getElementById("repass").value;
					var hoten = document.getElementById("hoten").value;
					var dob = document.getElementById("dob").value;
					var email = document.getElementById("email").value;
					var MKT = document.getElementById("MKT").value;
					var agree = document.getElementById("agree").checked;
					
					var time = new Date();
					var namht= time.getFullYear()-20;
					var namnh = dob.slice(0,4);
					
					if(username.length==0)
					{
						alert("Username không được để trống");
						document.getElementById("username").focus();
						return false;
					}
					else if(reg_trang.test(username) || reg_hoten.test(username))
					{
						alert("Username không được có khoảng trắng");
						document.getElementById("username").focus();
						return false;
					}
					else if(username.length<6 || username.length>20)
					{
						alert("Username phải từ 6 đến 20 ký tự");
						document.getElementById("username").focus();
						return false;
					}
					else if(password.length==0)
					{
						alert("Password không được để trống");
						document.getElementById("password").focus();
						return false;
					}
					else if(password.length<6 || password.length>30)
					{
						alert("Password phải từ 6 đến 30 ký tự");
						document.getElementById("password").focus();
						return false;
					}
					else if(reg_hoten.test(password)|| reg_trang.test(password))
					{
						alert("Password không được có khoảng trắng");
						document.getElementById("password").focus();
						return false;
					}
					else if(repass.length==0)
					{
						alert("Re-Password không được để trống");
						document.getElementById("repass").focus();
						return false;
					}
					else if(repass!=password)
					{
						alert("Password và Re-Password không trùng nhau");
						document.getElementById("password").focus();
						return false;
					}
					else if(hoten.length==0)
					{
						alert("Họ tên không được để trống");
						document.getElementById("hoten").focus();
						return false;
					}
					else if(reg_hoten.test(hoten))
					{
						alert("Họ tên không được có nhiều khoảng trắng liên tiếp");
						document.getElementById("hoten").focus();
						return false;
					}
					else if(!reg_ngay.test(dob))
					{
						alert("Ngày sinh không hợp lệ");
						document.getElementById("dob").focus();
						return false;
					}
					else if(namht < namnh)
					{
						alert("Bạn phải từ 20 tuổi trở lên");
						document.getElementById("dob").focus();
						return false;
					}
					else if(email.length==0)
					{
						alert("Email không được để trống");
						document.getElementById("email").focus();
						return false;
					}
					else if(!reg_mail.test(email))
					{
						alert("Email không hợp lệ");
						document.getElementById("email").focus();
						return false;
					}
					else if(MKT.length==0)
					{
						alert("MKT không được để trống");
						document.getElementById("MKT").focus();
						return false;
					}
					else if(MKT!=code)
					{
						alert("Mã kiểm tra không trùng khớp");
						document.getElementById("MKT").focus();
						return false;
					}
					else if(agree == false)
					{
						alert("Bạn cần chọn đồng ý Chính sách bảo mật thông tin");
						document.getElementById("agree").focus();
						return false;
					}
					else
					{
						alert("Bạn đã đăng ký thành công");
						return true;
					}			
}
              </script>
				  <p style="font-size: 36px; color: #ff711d; text-align: center; font-weight:bold" align="center" >Khách hàng đăng kí</p>
                <form action="<%=MM_editAction%>" METHOD="POST" name="register" style="width:600px">
                <hr />
            	<p>
                   <label for="username">User Name:(<span style="color:red;">*</span>)</label>
            	  <input class="text" type="text" name="username" id="username"></p>
				<p>
                  <label for="password">Password:(<span style="color:red;">*</span>)</label>
				  <input class="text" type="password" name="password" id="password"></p>
				<p>
				  <label for="Re_Password">Nhập lại Password:(<span style="color:red;">*</span>)</label>
				  <input class="text" type="password" name="Re_Password" id="repass"></p>
                <p>
				  <label for="hoten">Họ và Tên:(<span style="color:red;">*</span>)</label>
                  <input class="text" type="text" name="hoten" id="hoten"></p>
                <p>
                   <label for="gioitinh">Giới tính:</label>              
                  <input type="radio" name="gioitinh" id="gioitinh"  value="1" checked="checked"/>Nam
                  <input type="radio" name="gioitinh" id="gioitinh" value="0"/>Nữ</p>				
                <p>
					<label for="ngaysinh">Ngày sinh:(<span style="color:red;">*</span>)</label>
					<input class="text" type="text" name="dob" id="dob" placeholder="YYYY-MM-DD"></p>
	            <p>
				  <label for="email">Email:(<span style="color:red;">*</span>)</label>
			      <input class="text" type="text" name="email" id="email" placeholder="abc@gmail.com"></p>
                <p>
				    <label for="MKT">Mã kiểm tra:(<span style="color:red;">*</span>)</label>
                    <br>
                    <span id="ngau_nhien" class="capcharshow" style="color:#F00;font-size:30px;font-weight:bold"></span>
			      <input class="text" type="text" name="MKT" id="MKT"  placeholder="Nhập mã kiểm tra"></p>
				<p>
                  Chính sách bảo mật thông tin (<span style="color:red;">*</span>)<br>
                  <iframe src="chinhsachbaomat.html" width="420" height="200" style="margin-left:10px"></iframe></p>
                <p>
                    <label for="submit">&nbsp;</label>
                    Tôi đã đọc và tuân theo <strong>Chính Sách</strong> trên
                    <input name="DongY"  type="checkbox" id="agree"/></p>
                <hr />
                <p>
                	<label for="submit">&nbsp;</label>
                  <strong>(<span style="color:red;">*</span>): Thông tin bắt buộc</strong></p>
                <hr />
				<p>
                	<label for="submit">&nbsp;</label>
                    <input type="submit" id="submit" value="Đăng ký" onClick="return check_dangky();"/>
                    <input type="reset" value="Đặt lại"/>
                    <input type="hidden" name="MM_insert" value="register">
                </form>
     			</p>
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