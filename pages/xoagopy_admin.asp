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

if (String(Request("MM_delete")) == "xoa_gopy" &&
    String(Request("MM_recordId")) != "undefined") {

  if (!MM_abortEdit) {
    // execute the delete
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "DELETE FROM dbo.GopY WHERE MaGopY = ?"
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 5, 1, -1, Request.Form("MM_recordId"))); // adDouble
    MM_editCmd.Execute();
    MM_editCmd.ActiveConnection.Close();

    // append the query string to the redirect URL
    var MM_editRedirectUrl = "gopy_admin.asp";
    if (MM_editRedirectUrl && Request.QueryString && Request.QueryString.Count > 0) {
      MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1) ? "?" : "&") + Request.QueryString;
    }
    Response.Redirect(MM_editRedirectUrl)
  }
}
%>
<%
var rs_gopy__MMColParam = "1";
if (String(Request.QueryString("ma")) != "undefined" && 
    String(Request.QueryString("ma")) != "") { 
  rs_gopy__MMColParam = String(Request.QueryString("ma"));
}
%>
<%
var rs_gopy_cmd = Server.CreateObject ("ADODB.Command");
rs_gopy_cmd.ActiveConnection = MM_connectdb_STRING;
rs_gopy_cmd.CommandText = "SELECT * FROM dbo.GopY WHERE MaGopY = ?";
rs_gopy_cmd.Prepared = true;
rs_gopy_cmd.Parameters.Append(rs_gopy_cmd.CreateParameter("param1", 5, 1, -1, rs_gopy__MMColParam)); // adDouble

var rs_gopy = rs_gopy_cmd.Execute();
var rs_gopy_numRows = 0;
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
            <h2 class="left">Xóa Góp Ý</h2>
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
          <form ACTION="<%=MM_editAction%>" method="POST" name="xoa_gopy">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th width="20%" align="center" valign="middle">Từ Username</th>
                <td width="54%" align="center" valign="middle"><%=(rs_gopy.Fields.Item("UserName").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Ngày Góp Ý</th>
                <td align="center" valign="middle"><%=(rs_gopy.Fields.Item("NgayGopY").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Nội dung góp ý</th>
                <td align="center" valign="middle"><%=(rs_gopy.Fields.Item("NoiDungGopY").Value)%></td>
              </tr>
              <tr>
              	<td colspan="2" align="center" valign="middle"><input name="xoagopy" class="button" type="submit" value="Xóa" onClick="return ConfirmDelete();">&nbsp;&nbsp;<input name="trove" class="button" type="button" value="Trở Về" onClick="history.back(-1)"></td>
                </tr>
            </table>
            <input type="hidden" name="MM_delete" value="xoa_gopy">
            <input type="hidden" name="MM_recordId" value="<%= rs_gopy.Fields.Item("MaGopY").Value %>">
          </form>
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
