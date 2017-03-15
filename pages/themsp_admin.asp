<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
var rs_loai_cmd = Server.CreateObject ("ADODB.Command");
rs_loai_cmd.ActiveConnection = MM_connectdb_STRING;
rs_loai_cmd.CommandText = "SELECT * FROM dbo.TheLoai";
rs_loai_cmd.Prepared = true;

var rs_loai = rs_loai_cmd.Execute();
var rs_loai_numRows = 0;
%>
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
    MM_editCmd.CommandText = "INSERT INTO dbo.DoChoi (TenDoChoi, Gia, NSX, Hinh, MoTa, MaTheLoai) VALUES (?, ?, ?, ?, ?, ?)";
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 202, 1, 30, Request.Form("tensp"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param2", 5, 1, -1, (String(Request.Form("gia")) != "undefined" && String(Request.Form("gia")) != "") ? Request.Form("gia") : null)); // adDouble
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param3", 202, 1, 30, Request.Form("nsx"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param4", 202, 1, 300,Request.Form("hinhsp"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param5", 202, 1, 300, Request.Form("chitiet"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param6", 201, 1, 5, Request.Form("loaisp"))); // adLongVarChar
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
            <h2 class="left">Thêm Sản Phẩm</h2>
          </div>
          <!-- End Box Head -->
          <!-- Table -->
          <div class="table">
          <script>
          function check()
			{
				var tensp = document.getElementById("tensp").value;
				var gia = document.getElementById("gia").value;
				var nsx = document.getElementById("nsx").value;
				var chitiet = document.getElementById("chitiet").value;
				
				var reg_gia = /[0-9]/;
				var reg_khoangtrang = /  +/;
				var reg_trang_newline = /[\r\n]/;
				
				if(tensp.length == 0)
				{
					alert("Tên Sản Phẩm không được để trống");
					document.getElementById("tensp").focus();
					return false;
				}
				else if(reg_khoangtrang.test(tensp))
				{
					alert("Tên sản phẩm không được có nhiều khoảng trắng liên tiếp");
					document.getElementById("tensp").focus();
					return false;
				}
				else if(gia.length ==0)
				{
					alert("Giá không được để trống");
					document.getElementById("gia").focus();
					return false;
				}
				else if(!reg_gia.test(gia))
				{
					alert("Giá không đúng định dạng");
					document.getElementById("gia").focus();
					return false;
				}
				else if(gia > 1000)
				{
					alert("Giá không được hơn 1 triệu đồng");
					document.getElementById("gia").focus();
					return false;
				}
				else if(reg_khoangtrang.test(gia))
				{
					alert("Giá không được có nhiều khoảng trắng liên tiếp");
					document.getElementById("gia").focus();
					return false;
				}
				else if(chitiet.length==0)
				{
					alert("Chi tiết không được để trống");
					document.getElementById("chitiet").focus();
					return false;
				}
				else if(reg_khoangtrang.test(chitiet)|| reg_trang_newline.test(chitiet))
				{
					alert("Chi tiết không được có nhiều khoảng trắng liên tiếp và không thể xuống dòng");
					document.getElementById("chitiet").focus();
					return false;
				}
				else
				{
					alert("Bạn đã thêm sản phẩm thành công!");
					return true;
				}
			}
              </script>
          <form ACTION="<%=MM_editAction%>" method="POST" name="themkh">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <th align="center" valign="middle">Tên Sản Phẩm(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input name="tensp" id="tensp" type="text"></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Giá(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input name="gia" id="gia" type="text" placeholder="850"> ngàn đồng</td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Nhà Sản Xuất(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><select name="nsx" id="nsx">
                  <option value="Hasbro" selected="selected">Hasbro</option>
                  <option value="Magabloks">Megabloks</option>
                  <option value="Fisher - Price">Fisher - Price</option>
                  <option value="Lego">Lego</option>
                  <option value="Nintendo">Nintendo</option>
                </select></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Hình Sản Phẩm(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><input name="hinhsp" id="hinhsp" type="file" ></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Chi Tiết(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><textarea name="chitiet" id="chitiet" cols="45" rows="7"></textarea></td>
              </tr>
              <tr>
          		<th align="center" valign="middle">Loại Sản Phẩm(<span style="color:red;">*</span>)</th>
                <td align="center" valign="middle"><select name="loaisp">
                  <% 
while (!rs_loai.EOF) {
%>
                  <option value="<%=(rs_loai.Fields.Item("MaTheLoai").Value)%>"><%=(rs_loai.Fields.Item("Ten").Value)%></option>
                  <%
  rs_loai.MoveNext();
}
if (rs_loai.CursorType > 0) {
  if (!rs_loai.BOF) rs_loai.MoveFirst();
} else {
  rs_loai.Requery();
}
%>
                </select></td>
              </tr>
              <tr>
          		<td colspan="2" align="center" valign="middle"><input name="themsp" class="button" type="submit" value="Thêm SP" onClick="return check();">&nbsp;&nbsp;<input name="trove" class="button" type="button" value="Trở Về" onClick="history.back(-1)"><br> <strong>(<span style="color:red;">*</span>): Thông tin bắt buộc</strong></p></td>
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
rs_loai.Close();
%>
