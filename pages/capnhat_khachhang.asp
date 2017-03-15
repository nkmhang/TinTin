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
if (String(Request("MM_update")) == "capnhat") {
  if (!MM_abortEdit) {
    // execute the update
	
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "UPDATE dbo.KhachHang SET HoTen = ?, GioiTinh = ?, NgaySinh = ?, Email = ? WHERE UserName = ?";
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 202, 1, 50, Request.Form("hoten"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param2", 5, 1, -1, (String(Request.Form("gioitinh")) != "undefined" && String(Request.Form("gioitinh")) != "") ? Request.Form("gioitinh") : null)); // adDouble
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param3", 201, 1, 30, Request.Form("dob"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param4", 201, 1, 50, Request.Form("email"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param5", 200, 1, 20, Request.Form("MM_recordId"))); // adVarChar
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
var rsUser__MMColParam = "1";
if (String(Request.QueryString("user")) != "undefined" && 
    String(Request.QueryString("user")) != "") { 
  rsUser__MMColParam = String(Request.QueryString("user"));
}
%>
<%
var rsUser_cmd = Server.CreateObject ("ADODB.Command");
rsUser_cmd.ActiveConnection = MM_connectdb_STRING;
rsUser_cmd.CommandText = "SELECT * FROM dbo.KhachHang WHERE UserName = ?";
rsUser_cmd.Prepared = true;
rsUser_cmd.Parameters.Append(rsUser_cmd.CreateParameter("param1", 200, 1, 20, rsUser__MMColParam)); // adVarChar

var rsUser = rsUser_cmd.Execute();
var rsUser_numRows = 0;
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
			  function check()
			  	{
					var reg_hoten = /  +/;
					var reg_ngay = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
					var reg_mail = /^[A-Za-z0-9]+([_\.\-]?[A-Za-z0-9])*@[A-Za-z0-9]+([\.\-]?[A-Za-z0-9]+)*(\.[A-Za-z]+)+$/;
					
					var hoten = document.getElementById("hoten").value;
					var dob = document.getElementById("dob").value;
					var email = document.getElementById("email").value;
					
					var time = new Date();
					var namht= time.getFullYear()-20;
					var namnh = dob.slice(0,4);
					
					
					if(hoten.length==0)
					{
						alert("Họ tên không được để trống");
						document.getElementById("hoten").focus();
						return false;
					}
					else
					if(reg_hoten.test(hoten))
					{
						alert("Họ tên không được có nhiều khoảng trắng liên tiếp");
						document.getElementById("hoten").focus();
						return false;
					}
					else
					if(dob.length==0)
					{
						alert("Ngày sinh không được để trống");
						document.getElementById("dob").focus();
						return false;
					}
					else
					if(!reg_ngay.test(dob))
					{
						alert("Ngày sinh không hợp lệ");
						document.getElementById("dob").focus();
						return false;
					}
					else
					if(namht < namnh)
					{
						alert("Bạn phải từ 20 tuổi trở lên");
						document.getElementById("dob").focus();
						return false;
					}
					else
					if(email.length==0)
					{
						alert("Email không được để trống");
						document.getElementById("email").focus();
						return false;
					}
					else
					if(!reg_mail.test(email))
					{
						alert("Email không hợp lệ");
						document.getElementById("email").focus();
						return false;
					}
					else
					{
						alert("Bạn đã cập nhật thành công");
						return true;
					}
				}
              </script>
				  <p style="font-size: 36px; color: #ff711d; text-align: center; font-weight:bold" align="center" >Cập nhật Thông tin</p>
                <form ACTION="<%=MM_editAction%>" method="POST" name="capnhat" style="width:600px">
                <hr />
				<p>
               	 <label for="username">Username:</label>
				<div><%=(rsUser.Fields.Item("UserName").Value)%></div></p>
				<p>
				  <label for="newpass">Password</label>
				  <input type="button" value="Thay đổi Password" onClick="window.location='thaydoi_password.asp?user=<%=Session("MM_Username")%>'"/></p>
                <p>
				  <label for="hoten">Họ và Tên:</label>
                  <input name="hoten" type="text" class="text" id="hoten" value="<%=(rsUser.Fields.Item("HoTen").Value)%>"></p>
                <p>
                  <label for="gioitinh">Giới tính:</label>                  
                  <input <%=(((rsUser.Fields.Item("GioiTinh").Value) == 1)?"checked=\"checked\"":"")%> type="radio" name="gioitinh" value="1" checked="checked" id="nam"/>Nam
                  <input <%=(((rsUser.Fields.Item("GioiTinh").Value) == 0)?"checked=\"checked\"":"")%> type="radio" name="gioitinh" value="0" id="nu"/>Nữ</p>				
                <p>
					<label for="dob">Ngày sinh:</label>
					<input name="dob" type="text" class="text" id="dob" placeholder="YYYY-MM-DD" value="<%=(rsUser.Fields.Item("NgaySinh").Value)%>"></p>
	            <p>
				  <label for="email">Email:</label>
			      <input name="email" type="text" class="text" id="email" placeholder="abc@gmail.com" value="<%=(rsUser.Fields.Item("Email").Value)%>"></p>
                <hr />
				<p>
                    <input type="submit" id="submit" value="Cập Nhật" onClick="return check();"/>
                    <input type="button" value="Trở về" onclick="history.back(-1)" />
                    <input type="hidden" name="MM_update" value="capnhat">
                    <input type="hidden" name="MM_recordId" value="<%= rsUser.Fields.Item("UserName").Value %>">
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
<%
rsUser.Close();
%>
