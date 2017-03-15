<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
var rs_SP__MMColParam = "1";
if (String(Request.QueryString("ma")) != "undefined" && 
    String(Request.QueryString("ma")) != "") { 
  rs_SP__MMColParam = String(Request.QueryString("ma"));
}
%>
<%
var rs_SP_cmd = Server.CreateObject ("ADODB.Command");
rs_SP_cmd.ActiveConnection = MM_connectdb_STRING;
rs_SP_cmd.CommandText = "SELECT * FROM dbo.DoChoi WHERE MaDoChoi = ?";
rs_SP_cmd.Prepared = true;
rs_SP_cmd.Parameters.Append(rs_SP_cmd.CreateParameter("param1", 5, 1, -1, rs_SP__MMColParam)); // adDouble

var rs_SP = rs_SP_cmd.Execute();
var rs_SP_numRows = 0;
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
            <h2 class="left">Sản Phẩm</h2>
            <div class="right">
              <button class="button" onClick="history.back(-1)">Trở Về</button>
            </div>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="masp">
              <tr>
                <th >Mã SP</th>
                <th >Tên SP</th>
                <th >Giá SP</th>
                <th >Hình SP</th>
                <th width="110" class="ac">Hướng điều chỉnh</th>
              </tr>
  			<tr>
   			 <td ><%=(rs_SP.Fields.Item("MaDoChoi").Value)%></td>
    <td ><%=(rs_SP.Fields.Item("TenDoChoi").Value)%></td>
    <td ><%=(rs_SP.Fields.Item("Gia").Value)%></td>
    <td ><img src="images/<%=(rs_SP.Fields.Item("Hinh").Value)%>" height="150px" width="180px"/></td>
    <td ><a href="xoasp_admin.asp?masp=<%=(rs_SP.Fields.Item("MaDoChoi").Value)%>" class="ico del">Xóa</a>&nbsp;&nbsp;<a href="editsp_admin.asp?masp=<%=(rs_SP.Fields.Item("MaDoChoi").Value)%>" class="ico edit">Edit</a></td>
  </tr>
</form>
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
          <div class="box-content"> <a href="themsp_admin.asp" class="add-button"><span>Thêm Sản Phẩm</span></a>
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
rs_SP.Close();
%>
