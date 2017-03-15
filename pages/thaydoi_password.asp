<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
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
if (String(Request("MM_update")) == "register") {
  if (!MM_abortEdit) {
    // execute the update
	
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "UPDATE dbo.KhachHang SET Password = ? WHERE UserName = ?";
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 201, 1, 20, Request.Form("Password"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param2", 200, 1, 20, Request.Form("MM_recordId"))); // adVarChar
    MM_editCmd.Execute();
    MM_editCmd.ActiveConnection.Close();

    // append the query string to the redirect URL
    var MM_editRedirectUrl = "home.asp";
    if (MM_editRedirectUrl && Request.QueryString && Request.QueryString.Count > 0) {
      MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1) ? "?" : "&") + Request.QueryString;
    }
    Response.Redirect(MM_editRedirectUrl)
  }
}
%>
<%
var Password__MMColParam = "1";
if (String(Request.QueryString("user")) != "undefined" && 
    String(Request.QueryString("user")) != "") { 
  Password__MMColParam = String(Request.QueryString("user"));
}
%>
<%
var Password_cmd = Server.CreateObject ("ADODB.Command");
Password_cmd.ActiveConnection = MM_connectdb_STRING;
Password_cmd.CommandText = "SELECT * FROM dbo.KhachHang WHERE UserName = ?";
Password_cmd.Prepared = true;
Password_cmd.Parameters.Append(Password_cmd.CreateParameter("param1", 200, 1, 20, Password__MMColParam)); // adVarChar

var Password = Password_cmd.Execute();
var Password_numRows = 0;
%>
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
			    <div id="content">
                <div align="center">
                <script>
			  window.onload = function MKT()
			{
				var capchar= Math.round(Math.random()*999999);
				document.getElementById('ngau_nhien').innerHTML=capchar;
			}
			function check_password()
			{
	    			var code = document.getElementById('ngau_nhien').innerHTML;
					var MKT = document.getElementById("MKT").value;
					var password_old = document.getElementById("Password_Old").value;
					var password_moi = document.getElementById("Password").value;
					var re_password = document.getElementById("Re_Password").value;
					var password_check = document.getElementById("Password_Old_check").value;
					var agree = document.getElementById("DongY").checked;
					
					var reg_khoangtrang = /  +/;
					var reg_trang = /\s/g;
					
					if(password_old.length==0)
					{
						alert("Password cũ không được để trống");
						document.getElementById("Password_Old").focus();
						return false;
					}
					else if(password_old != password_check)
					{
						alert("Password cũ không đúng. Mời nhập lại!");
						document.getElementById("Password_Old").focus();
						return false;
					}
					else if(password_moi.length == 0)
					{
						alert("Password mới không được để trống");
						document.getElementById("Password").focus();
						return false;
					}
					else if(reg_khoangtrang.test(password_moi) || reg_trang.test(password_moi))
					{
						alert("Password mới không được có khoảng trắng");
						document.getElementById("Password").focus();
						return false;
					}
					else if(password_moi.length<6 || password_moi.length>30)
					{
						alert("Password mới phải từ 6 tới 30 ký tự");
						document.getElementById("Password").focus();
						return false;
					}
					else if(re_password.length ==0)
					{
						alert("Nhập lại password mới không được bỏ trống");
						document.getElementById("Re_Password").focus();
						return false;
					}
					else if(re_password!=password_moi)
					{
						alert("Password mới và phần nhập lại không giống nhau");
						document.getElementById("Re_Password").focus();
						return false;
					}
					else if (MKT.length==0)
					{
						alert("MKT không được để trống");
						document.getElementById("MKT").focus();
						return false;
					}
					else if (MKT!=code)
					{
						alert("Mã kiểm tra không trùng khớp");
						document.getElementById("MKT").focus();
						return false;
					}
					else if(agree == false)
					{
						alert("Bạn cần chọn đồng ý thay đổi password");
						document.getElementById("DongY").focus();
						return false;
					}
					else
					{
						alert("Bạn đã thay đổi password thành công");
						return true;
					}
			}
				</script>
                <p style="font-size:36px; color:#ff711d; text-align:center;" align="center" >Khách hàng thay đổi mật khẩu</p>
                <form ACTION="<%=MM_editAction%>" METHOD="POST" name="register" style="width:600px">
                <hr />
            	<p>
                  <label for="Password_Old">Password cũ:(<span style="color:red;">*</span>)</label>
				  <input class="text" type="password" name="Password_Old" id="Password_Old"></p>
				<p>
                  <label for="Password">Password mới:(<span style="color:red;">*</span>)</label>
				  <input class="text" type="password" name="Password" id="Password"></p>
				<p>
				  <label for="Re_Password">Nhập lại Password mới:(<span style="color:red;">*</span>)</label>
				  <input class="text" type="password" name="Re_Password" id="Re_Password"></p>
				<p>
				    <label for="MKT">Mã kiểm tra: (<span style="color:red;">*</span>)</label>
                    <span id="ngau_nhien" class="capcharshow"  style="color:#F00;font-size:30px;font-weight:bold"></span>
			      <input class="text" type="text" name="MKT" id="MKT"  placeholder="Nhập mã kiểm tra"></p>
                <p>
                  <label for="submit">&nbsp;</label>
                    Tôi đồng ý thay đổi Password
                    <input name="DongY"  type="checkbox" id="DongY"/>
                  <input class="text" type="hidden" name="Password_Old_check" id="Password_Old_check" value="<%=(Password.Fields.Item("Password").Value)%>" /></p>
                <hr />
                <p>
                  <label for="submit">&nbsp;</label>
                  <strong>(<span style="color:red;">*</span>): Thông tin bắt buộc</strong></p>
                <hr />
				<p>
                  <label for="submit">&nbsp;</label>
                    <input type="submit" value="Chấp Nhận" onClick="return check_password();"/>
                    <input type="reset" value="Đặt lại" />                  
                    <input type="button" value="Trở về" onclick="history.back(-1)" /></p>
                <input type="hidden" name="MM_update" value="register">
                <input type="hidden" name="MM_recordId" value="<%=(Password.Fields.Item("UserName").Value)%>">
                </form>
			</div>
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
Password.Close();
%>
