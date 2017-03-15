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
if (String(Request("MM_update")) == "traloi_gopy") {
  if (!MM_abortEdit) {
    // execute the update
	
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "UPDATE dbo.GopY SET NoiDungGopY = ?, TrangThai = ?, NoiDungTraLoi = ? WHERE MaGopY = ?";
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 202, 1, 200, Request.Form("gopy"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param2", 5, 1, -1, (String(Request.Form("trangthai")) != "undefined" && String(Request.Form("trangthai")) != "") ? Request.Form("trangthai") : null)); // adDouble
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param3", 202, 1, 300, Request.Form("traloi"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param4", 5, 1, -1, (String(Request.Form("MM_recordId")) != "undefined" && String(Request.Form("MM_recordId")) != "") ? Request.Form("MM_recordId") : null)); // adDouble
    MM_editCmd.Execute();
    MM_editCmd.ActiveConnection.Close();

    // append the query string to the redirect URL
    var MM_editRedirectUrl = "gopytc_admin.asp";
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
            <h2 class="left">Trả Lời Góp Ý</h2>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
          <script>
		  function check()
		  	{
				var traloi = document.getElementById("traloi").value;
				var daduyet = document.getElementById("daduyet").checked;
				
				var reg_khoangtrang = /  +/;
				var reg_trang_newline = /[\r\n]/;
				
				if(traloi.length != 0 && daduyet == false)
				{
					alert("Bạn cần phải chọn nút đã duyệt trước khi gửi");
					return false;
				}
				else if(reg_khoangtrang.test(traloi) || reg_trang_newline.test(traloi) )
				{
					alert("Trả lời không được có nhiều khoảng trắng liên tiếp và không thể xuống dòng");
					document.getElementById("traloi").focus();
					return false;
				}
				else if (traloi.length == 0 && daduyet == true)
				{
					alert("Bạn cần phải trả lời trước khi chọn đã duyệt");
					document.getElementById("traloi").focus();
					return false;
				}
				else
				{
					confirm("Bạn đã chắc chắn về câu trả lời chưa?"); 
				}
			}
          </script>
          <form ACTION="<%=MM_editAction%>" METHOD="POST" name="traloi_gopy">
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
              	<th align="center" valign="middle">Nội dung Góp Ý</th>
                <td align="center" valign="middle"><textarea name="gopy" cols="45" rows="7" readonly><%=(rs_gopy.Fields.Item("NoiDungGopY").Value)%></textarea></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Trạng Thái</th>
                <td align="center" valign="middle"><input <%=(((rs_gopy.Fields.Item("TrangThai").Value) == 0)?"checked=\"checked\"":"")%>  type="radio" name="trangthai" value="0" checked="checked"/>Chưa duyệt
                  <input <%=(((rs_gopy.Fields.Item("TrangThai").Value) == 1)?"checked=\"checked\"":"")%>  type="radio" name="trangthai" id="daduyet" value="1"/>Đã duyệt</td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Nội dung trả lời</th>
                <td align="center" valign="middle">
                <textarea name="traloi" id="traloi" cols="45" rows="7"><%=(rs_gopy.Fields.Item("NoiDungTraLoi").Value)%></textarea>
                </td>
              </tr>
              <tr>
              	<td colspan="2" align="center" valign="middle"><input type="submit" class="button" value="Gửi" onClick="return check();">&nbsp;&nbsp;<input name="trove" type="button" class="button" value="Trở Về" onClick="history.back(-1)"></td>
                </tr>
            </table>
            <input type="hidden" name="MM_update" value="traloi_gopy">
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
