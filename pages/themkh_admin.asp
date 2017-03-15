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
if (String(Request("MM_insert")) == "themkh") {
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
    var MM_editRedirectUrl = "kh_admin.asp";
    if (MM_editRedirectUrl && Request.QueryString && Request.QueryString.Count > 0) {
      MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1) ? "?" : "&") + Request.QueryString;
    }
    Response.Redirect(MM_editRedirectUrl)
  }
}
%>
<!DOCTYPE html>
<html><!-- InstanceBegin template="/Templates/index_admin.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>
	<%
		if (Session("MM_Admin_Username")== "" || Session("MM_Admin_Username")== null)
		{
			Response.Redirect("login_form_admin/dangnhap_admin.asp");
		}
	%>
	<meta charset="utf-8" />
	<!-- InstanceBeginEditable name="doctitle" -->
	<title>Trang Admin</title>
	<!-- InstanceEndEditable -->
	<link rel="stylesheet" href="css/style.css" type="text/css"/>
	<!-- InstanceBeginEditable name="head" -->
	<!-- InstanceEndEditable -->
</head>
<body>
<!-- Header -->
<div id="header">
	<div class="shell">
		<!-- Logo + Top Nav -->
		<div id="top">
			<h1>Trang Admin</h1>
			<div id="top-navigation">
				Xin chào <strong>Administrator</strong>
				<span>|</span>
				<a href="thoat.asp">Thoát</a>
			</div>
		</div>
		<!-- End Logo + Top Nav -->
		
		<!-- Main Nav -->
		<div id="navigation">
			<ul>
			    <li><a href="sp_admin.asp"><span>Sản Phẩm</span></a></li>
			    <li><a href="kh_admin.asp"><span>Khách Hàng</span></a></li>
			    <li><a href="gopy_admin.asp"><span>Góp Ý</span></a></li>
			</ul>
		</div>
		<!-- End Main Nav -->
	</div>
</div>
<!-- End Header -->

<!-- Container -->
<div id="container">
<!-- InstanceBeginEditable name="EditRegion3" -->
 <div class="shell">
    <!-- Small Nav -->
    <div class="small-nav"></div>
    <!-- End Small Nav -->
    <br />
    <!-- Main -->
    <div id="main">
      <div class="cl">&nbsp;</div>
      <!-- Content -->
      <div id="content">
        <!-- Box -->
        <div class="box">
          <!-- Box Head -->
          <div class="box-head">
            <h2 class="left">Thêm Khách Hàng</h2>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
          <script>
          function check_dangky()
			{
					var reg_trang = /\s/g;
					var reg_hoten = /  +/;
					var reg_ngay = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
					var reg_mail = /^[A-Za-z0-9]+([_\.\-]?[A-Za-z0-9])*@[A-Za-z0-9]+([\.\-]?[A-Za-z0-9]+)*(\.[A-Za-z]+)+$/;
					
					var username = document.getElementById("username").value;
					var password = document.getElementById("password").value;
					var hoten = document.getElementById("hoten").value;
					var dob = document.getElementById("dob").value;
					var email = document.getElementById("email").value;
					
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
					else
					{
						alert("Bạn đã thêm khách hàng thành công!");
						return true;
					}		
}
              </script>
          <form ACTION="<%=MM_editAction%>" method="POST" name="themkh">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th align="center" valign="middle">Username(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input name="username" id="username" type="text"></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Password(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input name="password" id="password" type="text"></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Họ tên(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input name="hoten" id="hoten" type="text"></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Giới tính(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input type="radio" name="gioitinh" id="gioitinh"  value="1" checked="checked"/>Nam
                  <input type="radio" name="gioitinh" id="gioitinh" value="0"/>Nữ</td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Ngày sinh(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input class="text" type="text" name="dob" id="dob" placeholder="YYYY-MM-DD"></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Email(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input class="text" type="text" name="email" id="email" placeholder="abc@gmail.com"></td>
              </tr>
              <tr>
          		<td colspan="2" align="center" valign="middle"><input name="themsp" class="button" type="submit" value="Thêm KH" onClick="return check_dangky();">&nbsp;&nbsp;<input name="trove" class="button" type="button" value="Trở Về" onClick="history.back(-1)"><br> <strong>(<span style="color:red;">*</span>): Thông tin bắt buộc</strong></p></td>
                </tr>
            </table>
            <input type="hidden" name="MM_insert" value="themkh">
          </form>
          </div>
          <!-- Table -->
        </div>
        <!-- End Box -->
        <!-- Box -->
        <!-- End Box -->
      </div>
      <!-- End Content -->
      <!-- Sidebar -->
      <div id="sidebar">
        <!-- Box -->
        <div class="box">
          <!-- Box Head -->
          <div class="box-head">
            <h2>Quản Lý</h2>
          </div>
          <!-- End Box Head-->
          <div class="box-content"> <a href="themkh_admin.asp" class="add-button"><span>Thêm Khách Hàng</span></a>
            <div class="cl">&nbsp;</div>
          </div>
        </div>
        <!-- End Box -->
      </div>
      <!-- End Sidebar -->
      <div class="cl">&nbsp;</div>
    </div>
    <!-- Main -->
  </div>
<!-- InstanceEndEditable -->
</div>
<!-- End Container -->

<!-- Footer -->
<div id="footer">
	<div class="shell">
		<span class="left">&copy; 2016 - TinTin - Admin</span>
	</div>
</div>
<!-- End Footer -->
	
</body>
<!-- InstanceEnd --></html>
