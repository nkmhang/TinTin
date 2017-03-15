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
rs_gopy_cmd.CommandText = "SELECT * FROM dbo.GopY WHERE UserName = ?";
rs_gopy_cmd.Prepared = true;
rs_gopy_cmd.Parameters.Append(rs_gopy_cmd.CreateParameter("param1", 200, 1, 20, rs_gopy__MMColParam)); // adVarChar

var rs_gopy = rs_gopy_cmd.Execute();
var rs_gopy_numRows = 0;
%>
<%
var Repeat1__numRows = -1;
var Repeat1__index = 0;
rs_gopy_numRows += Repeat1__numRows;
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
            <h2 class="left">Góp Ý</h2>
            <div class="right"><button class="button" onClick="history.back(-1)">Trở Về</button></div>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th >Username</th>
                <th >Ngày Góp Ý</th>
                <th >Trạng Thái</th>
                <th width="110" class="ac">Hướng điều chỉnh</th>
              </tr>
              <% while ((Repeat1__numRows-- != 0) && (!rs_gopy.EOF)) { %>
  <tr>
    <td ><%=(rs_gopy.Fields.Item("UserName").Value)%></td>
    <td ><%=(rs_gopy.Fields.Item("NgayGopY").Value)%></td>
    <form>
      <td >Đã duyệt
        <input <%=(((rs_gopy.Fields.Item("TrangThai").Value) == 1)?"checked=\"checked\"":"")%> type="radio" name="trangthai" value="1" disabled="disabled" />
        Chưa duyệt
        <input <%=(((rs_gopy.Fields.Item("TrangThai").Value) == 0)?"checked=\"checked\"":"")%>  type="radio" name="trangthai" value="0" disabled="disabled"/></td>
    </form>
    <td ><a href="xoagopy_admin.asp?ma=<%=(rs_gopy.Fields.Item("MaGopY").Value)%>" class="ico del">Xóa</a>
      <%
    var rs_trangthai__MMColParam = rs_gopy.Fields.Item("MaGopY").Value;
    if (String(Request.QueryString("ma")) != "undefined" && 
        String(Request.QueryString("ma")) != "") { 
      rs_trangthai__MMColParam = String(Request.QueryString("ma"));
    }
    %>
      <%
    var rs_trangthai_cmd = Server.CreateObject ("ADODB.Command");
    rs_trangthai_cmd.ActiveConnection = MM_connectdb_STRING;
    rs_trangthai_cmd.CommandText = "SELECT * FROM dbo.trangthaigopy WHERE MaGopY = ?";
    rs_trangthai_cmd.Prepared = true;
    rs_trangthai_cmd.Parameters.Append(rs_trangthai_cmd.CreateParameter("param1", 5, 1, -1, rs_trangthai__MMColParam)); // adDouble
    
    var rs_trangthai = rs_trangthai_cmd.Execute();
    var rs_trangthai_numRows = 0;
    %>
      <% if (rs_trangthai.EOF && rs_trangthai.BOF) { %>
        <a href="editgopy_admin.asp?ma=<%=(rs_gopy.Fields.Item("MaGopY").Value)%>" class="ico edit">Edit</a>
        <% } // end rs_trangthai.EOF && rs_trangthai.BOF %></td>
  </tr>
  <%
  Repeat1__index++;
  rs_gopy.MoveNext();
}
%>
            </table>
          </div>
          <!-- Table -->
        </div>
        <!-- End Box -->
        <!-- Box -->
        <!-- End Box -->
      </div>
      <!-- End Content -->
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
rs_gopy.Close();
%>
