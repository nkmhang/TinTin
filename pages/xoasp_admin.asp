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

if (String(Request("MM_delete")) == "xoa_sp" &&
    String(Request("MM_recordId")) != "undefined") {

  if (!MM_abortEdit) {
    // execute the delete
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "DELETE FROM dbo.DoChoi WHERE MaDoChoi = ?"
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 5, 1, -1, Request.Form("MM_recordId"))); // adDouble
    MM_editCmd.Execute();
    MM_editCmd.ActiveConnection.Close();

    // append the query string to the redirect URL
    var MM_editRedirectUrl = "sp_admin.asp";
    if (MM_editRedirectUrl && Request.QueryString && Request.QueryString.Count > 0) {
      MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1) ? "?" : "&") + Request.QueryString;
    }
    Response.Redirect(MM_editRedirectUrl)
  }
}
%>
<%
var rs_XoaSP__MMColParam = "1";
if (String(Request.QueryString("masp")) != "undefined" && 
    String(Request.QueryString("masp")) != "") { 
  rs_XoaSP__MMColParam = String(Request.QueryString("masp"));
}
%>
<%
var rs_XoaSP_cmd = Server.CreateObject ("ADODB.Command");
rs_XoaSP_cmd.ActiveConnection = MM_connectdb_STRING;
rs_XoaSP_cmd.CommandText = "SELECT * FROM dbo.chitietdochoi WHERE MaDoChoi = ?";
rs_XoaSP_cmd.Prepared = true;
rs_XoaSP_cmd.Parameters.Append(rs_XoaSP_cmd.CreateParameter("param1", 5, 1, -1, rs_XoaSP__MMColParam)); // adDouble

var rs_XoaSP = rs_XoaSP_cmd.Execute();
var rs_XoaSP_numRows = 0;
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
            <h2 class="left">Xóa Sản Phẩm</h2>
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
          <form ACTION="<%=MM_editAction%>" method="POST" name="xoa_sp">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              	<td width="26%" rowspan="7"><img src="images/<%=(rs_XoaSP.Fields.Item("Hinh").Value)%>" height="250px" width="270px"/></td>
                <th width="20%" align="center" valign="middle">Tên SP</th>
                <td width="54%" align="center" valign="middle"><%=(rs_XoaSP.Fields.Item("TenDoChoi").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Giá</th>
                <td align="center" valign="middle"><%=(rs_XoaSP.Fields.Item("Gia").Value)%> ngàn đồng</td>
              </tr>
              <tr>
              	<th align="center" valign="middle">NSX</th>
                <td align="center" valign="middle"><%=(rs_XoaSP.Fields.Item("NSX").Value)%></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Chi tiết SP</th>
                <td align="center" valign="middle"><textarea name="chitiet" cols="45" rows="7" readonly="readonly"><%=(rs_XoaSP.Fields.Item("Chitiet").Value)%></textarea></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Loại SP</th>
                <td align="center" valign="middle"><%=(rs_XoaSP.Fields.Item("TheLoai").Value)%></td>
              </tr>
              <tr>
              	<td colspan="2" align="center" valign="middle"><input name="themsp" class="button" type="submit" value="Xóa SP" onClick="return ConfirmDelete();">&nbsp;&nbsp;<input name="trove" class="button" type="button" value="Trở Về" onClick="history.back(-1)"></td>
                </tr>
            </table>
            <input type="hidden" name="MM_delete" value="xoa_sp">
            <input type="hidden" name="MM_recordId" value="<%= rs_XoaSP.Fields.Item("MaDoChoi").Value %>">
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
rs_XoaSP.Close();
%>
