<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
// *** Validate request to log in to this site.
var MM_LoginAction = Request.ServerVariables("URL");
if (Request.QueryString != "") MM_LoginAction += "?" + Server.HTMLEncode(Request.QueryString);
var MM_valUsername = String(Request.Form("username"));
if (MM_valUsername != "undefined") {
  var MM_fldUserAuthorization = "";
  var MM_redirectLoginSuccess = "home.asp";
  var MM_redirectLoginFailed = "dangnhap_sai.asp";

  var MM_loginSQL = "SELECT UserName, Password";
  if (MM_fldUserAuthorization != "") MM_loginSQL += "," + MM_fldUserAuthorization;
  MM_loginSQL += " FROM dbo.KhachHang WHERE UserName = ? AND Password = ?";
  var MM_rsUser_cmd = Server.CreateObject ("ADODB.Command");
  MM_rsUser_cmd.ActiveConnection = MM_connectdb_STRING;
  MM_rsUser_cmd.CommandText = MM_loginSQL;
  MM_rsUser_cmd.Parameters.Append(MM_rsUser_cmd.CreateParameter("param1", 200, 1, 20, MM_valUsername)); // adVarChar
  MM_rsUser_cmd.Parameters.Append(MM_rsUser_cmd.CreateParameter("param2", 200, 1, 20, Request.Form("password"))); // adVarChar
  MM_rsUser_cmd.Prepared = true;
  var MM_rsUser = MM_rsUser_cmd.Execute();

  if (!MM_rsUser.EOF || !MM_rsUser.BOF) {
    // username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername;
    if (MM_fldUserAuthorization != "") {
      Session("MM_UserAuthorization") = String(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value);
    } else {
      Session("MM_UserAuthorization") = "";
    }
    if (String(Request.QueryString("accessdenied")) != "undefined" && false) {
      MM_redirectLoginSuccess = Request.QueryString("accessdenied");
    }
    MM_rsUser.Close();
    Response.Redirect(MM_redirectLoginSuccess);
  }
  MM_rsUser.Close();
  Response.Redirect(MM_redirectLoginFailed);
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
			  function check()
			  	{
					var username=document.getElementById("username").value;
					var password=document.getElementById("password").value;
					
					if(username.length==0)
					{
						alert("Username không được để trống");
						document.getElementById("username").focus();
						return false;
					}
					else if(username.length<6 || username.length>20)
					{
						alert("Username phải ít nhất 6 và 20 ký tự");
						document.getElementById("username").focus();
						return false;
					}
					else if(password.length==0)
					{
						alert("Password không được để trống");
						document.getElementById("password").focus();
						return false;
					}
					else if(password.length<6||password.length>30)
					{
						alert("Password phải ít nhất 6 và 30 ký tự");
						document.getElementById("password").focus();
						return false;
					}
					else
					{
						return true;
					}
				}
              </script>
				<form ACTION="<%=MM_LoginAction%>" METHOD="POST" name="login" style="width:530px">
                <p style="vertical-align: middle; text-align: center; font-size:30px; color:#ff711d">Đăng Nhập</p>
                      <hr />
				  <table width="530px" border="0" cellpadding="3" cellspacing="0">
				  <tr>
                    <th width="131" scope="row">User Name:(<span style="color:red;">*</span>)</th>
                    <td width="357"><input class="text" type="text" name="username" id="username"/></td>
                  </tr>
                  <tr>
                    <th width="131" scope="row">Password:(<span style="color:red;">*</span>)</th>
                    <td><input class="text" type="password" name="password" id="password"/></td>
                  </tr>
                  <tr>
                    <th colspan="2" scope="row">(<span style="color:red;">*</span>): Thông tin bắt buộc</th>
                    </tr>
                  <tr>
                    <th colspan="2" scope="row">
                        <input type="submit" value="Đăng nhập" id="submit" onClick="return check();"/>
                        <input type="reset" value="Đặt lại" />
                    </th>
                   </tr>
                  </table>
                  <hr />
				</form>
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