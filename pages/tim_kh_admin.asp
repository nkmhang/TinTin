<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
var rs_KH__MMColParam = "1";
if (String(Request.QueryString("user")) != "undefined" && 
    String(Request.QueryString("user")) != "") { 
  rs_KH__MMColParam = String(Request.QueryString("user"));
}
%>
<%
var rs_KH_cmd = Server.CreateObject ("ADODB.Command");
rs_KH_cmd.ActiveConnection = MM_connectdb_STRING;
rs_KH_cmd.CommandText = "SELECT * FROM dbo.KhachHang WHERE UserName = ?";
rs_KH_cmd.Prepared = true;
rs_KH_cmd.Parameters.Append(rs_KH_cmd.CreateParameter("param1", 200, 1, 20, rs_KH__MMColParam)); // adVarChar

var rs_KH = rs_KH_cmd.Execute();
var rs_KH_numRows = 0;
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
            <h2 class="left">Khách Hàng</h2>
            <div class="right">
             <button class="button" onClick="history.back(-1)">Trở Về</button>
            </div>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <th >Username</th>
      <th >Họ Tên</th>
      <th >Email</th>
      <th width="110" class="ac">Hướng điều chỉnh</th>
    </tr>
      <tr>
        <td ><%=(rs_KH.Fields.Item("UserName").Value)%></td>
        <td ><%=(rs_KH.Fields.Item("HoTen").Value)%></td>
        <td ><%=(rs_KH.Fields.Item("Email").Value)%></td>
        <td >
  <%
	var rs_gopy__MMColParam = rs_KH.Fields.Item("UserName").Value;
	if (String(Request.QueryString("user")) != "undefined" && 
		String(Request.QueryString("user")) != "") { 
	  rs_gopy__MMColParam = String(Request.QueryString("user"));
	}
	%>
	<%
    var rs_gopy_cmd = Server.CreateObject ("ADODB.Command");
    rs_gopy_cmd.ActiveConnection = MM_connectdb_STRING;
    rs_gopy_cmd.CommandText = "SELECT * FROM dbo.GopY WHERE UserName = ?";
    rs_gopy_cmd.Prepared = true;
    rs_gopy_cmd.Parameters.Append(rs_gopy_cmd.CreateParameter("param1", 200, 1, 20, rs_gopy__MMColParam)); // adVarChar
    
    var rs_gopy = rs_gopy_cmd.Execute();
    var rs_gopy_numRows = 0;
    %>
    <% if (rs_gopy.EOF && rs_gopy.BOF) { %>
  <a href="xoakh_admin.asp?user=<%=(rs_KH.Fields.Item("UserName").Value)%>" class="ico del"> Xóa </a>
  <% } // end rs_gopy.EOF && rs_gopy.BOF %></td>
      </tr>
  </table>
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
<%
rs_KH.Close();
%>
