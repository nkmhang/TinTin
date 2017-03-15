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
// *** Delete Record: construct a sql delete statement and execute it

if (String(Request("MM_delete")) == "xoa_kh" &&
    String(Request("MM_recordId")) != "undefined") {

  if (!MM_abortEdit) {
    // execute the delete
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "DELETE FROM dbo.KhachHang WHERE UserName = ?"
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 200, 1, 20, Request.Form("MM_recordId"))); // adVarChar
    MM_editCmd.Execute();
    MM_editCmd.ActiveConnection.Close();

    // append the query string to the redirect URL
    var MM_editRedirectUrl = "xoatc_admin.asp";
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
            <h2 class="left">Xóa Khách Hàng</h2>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
       <script>
			function ConfirmDelete()
			{
			  var x = confirm("Bạn đã chắc chắn muốn xóa chưa?");
			  if (x)
				  return true;
			  else
				return false;
			}
		</script>    
          <form ACTION="<%=MM_editAction%>" method="POST" name="xoa_kh">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th width="20%" align="center" valign="middle">Username</th>
                <td width="54%" align="center" valign="middle"><%=(rsUser.Fields.Item("UserName").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Họ Tên</th>
                <td align="center" valign="middle"><%=(rsUser.Fields.Item("HoTen").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Giới tính </th>
                <td align="center" valign="middle">Nam
				    <input <%=(((rsUser.Fields.Item("GioiTinh").Value) == 1)?"checked=\"checked\"":"")%>  type="radio" name="GioiTinh" value="1" disabled="disabled" />
						Nữ
				  <input <%=(((rsUser.Fields.Item("GioiTinh").Value) == 0)?"checked=\"checked\"":"")%> type="radio" name="GioiTinh" value="0" disabled="disabled"/></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Ngày Sinh</th>
                <td align="center" valign="middle"><%=(rsUser.Fields.Item("NgaySinh").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Email</th>
                <td align="center" valign="middle"><%=(rsUser.Fields.Item("Email").Value)%></td>
              </tr>
              <tr>
              	<td colspan="2" align="center" valign="middle"><input name="themsp" class="button" type="submit" value="Xóa KH" onClick="return ConfirmDelete();">&nbsp;&nbsp;<input name="trove" class="button" type="button" value="Trở Về" onClick="history.back(-1)"></td>
                </tr>
            </table>
            <input type="hidden" name="MM_delete" value="xoa_kh">
            <input type="hidden" name="MM_recordId" value="<%= rsUser.Fields.Item("UserName").Value %>">
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
<%
rsUser.Close();
%>
