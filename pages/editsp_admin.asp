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
if (String(Request("MM_update")) == "sua_sp") {
  if (!MM_abortEdit) {
    // execute the update
	
    var MM_editCmd = Server.CreateObject ("ADODB.Command");
    MM_editCmd.ActiveConnection = MM_connectdb_STRING;
    MM_editCmd.CommandText = "UPDATE dbo.DoChoi SET TenDoChoi = ?, Gia = ?, NSX = ?, Hinh = ?, MoTa = ?, MaTheLoai = ? WHERE MaDoChoi = ?";
    MM_editCmd.Prepared = true;
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param1", 202, 1, 30, Request.Form("tensp"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param2", 5, 1, -1, (String(Request.Form("gia")) != "undefined" && String(Request.Form("gia")) != "") ? Request.Form("gia") : null)); // adDouble
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param3", 202, 1, 30, Request.Form("nsx"))); // adVarWChar
	if(Request.Form("hinhsp") != "")
	{
		MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param4", 202, 1, 300,Request.Form("hinhsp")));
	}
	else
	{
		 MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param4", 202, 1, 300,Request.Form("old_image"))); 
	}
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param5", 202, 1, 300, Request.Form("chitiet"))); // adVarWChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param6", 201, 1, 5, Request.Form("theloai"))); // adLongVarChar
    MM_editCmd.Parameters.Append(MM_editCmd.CreateParameter("param7", 5, 1, -1, (String(Request.Form("MM_recordId")) != "undefined" && String(Request.Form("MM_recordId")) != "") ? Request.Form("MM_recordId") : null)); // adDouble
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
var rs_SP__MMColParam = "1";
if (String(Request.QueryString("masp")) != "undefined" && 
    String(Request.QueryString("masp")) != "") { 
  rs_SP__MMColParam = String(Request.QueryString("masp"));
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
<%
var rs_Loai_cmd = Server.CreateObject ("ADODB.Command");
rs_Loai_cmd.ActiveConnection = MM_connectdb_STRING;
rs_Loai_cmd.CommandText = "SELECT * FROM dbo.TheLoai";
rs_Loai_cmd.Prepared = true;

var rs_Loai = rs_Loai_cmd.Execute();
var rs_Loai_numRows = 0;
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
            <h2 class="left">Cập Nhật Sản Phẩm</h2>
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
				else if(nsx.length==0)
				{
					alert("Nhà sản xuất không được để trống");
					document.getElementById("nsx").focus();
					return false;
				}
				else if(reg_khoangtrang.test(nsx))
				{
					alert("Nhà sản xuất không được có nhiều khoảng trắng liên tiếp");
					document.getElementById("nsx").focus();
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
					alert("Bạn đã cập nhật sản phẩm thành công");
					return true;
				}
			}
              </script>
          <form ACTION="<%=MM_editAction%>" method="POST" name="sua_sp">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              	<td width="26%" rowspan="7"><img src="images/<%=(rs_SP.Fields.Item("Hinh").Value)%>" height="250px" width="270px"/></td>
                <th width="20%" align="center" valign="middle">Tên SP</th>
                <td width="54%" align="center" valign="middle"><input name="tensp" id="tensp" type="text" value="<%=(rs_SP.Fields.Item("TenDoChoi").Value)%>"></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Giá</th>
                <td align="center" valign="middle"><input name="gia" id="gia" type="text" value="<%=(rs_SP.Fields.Item("Gia").Value)%>" placeholder="850"> ngàn đồng</td>
              </tr>
              <tr>
              	<th align="center" valign="middle">NSX</th>
                <td align="center" valign="middle"><input name="nsx" id="nsx" type="text" value="<%=(rs_SP.Fields.Item("NSX").Value)%>"></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Hình SP</th>
                <td align="center" valign="middle"><label for="hinhsp"></label>
                  <input name="hinhsp" type="file" id="hinhsp" value=""></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Chi tiết SP</th>
                <td align="center" valign="middle"><textarea name="chitiet" id="chitiet" cols="45" rows="7"><%=(rs_SP.Fields.Item("MoTa").Value)%></textarea></td>
              </tr>
              <tr>
              	<th align="center" valign="middle">Loại SP</th>
                <td align="center" valign="middle"><select name="theloai">
                  <option value="" <%=(("" == (rs_SP.Fields.Item("MaTheLoai").Value))?"selected=\"selected\"":"")%>></option>
                  <% 
while (!rs_Loai.EOF) {
%>
                  <option value="<%=(rs_Loai.Fields.Item("MaTheLoai").Value)%>" <%=((rs_Loai.Fields.Item("MaTheLoai").Value == (rs_SP.Fields.Item("MaTheLoai").Value))?"selected=\"selected\"":"")%> ><%=(rs_Loai.Fields.Item("Ten").Value)%></option>
                  <%
  rs_Loai.MoveNext();
}
if (rs_Loai.CursorType > 0) {
  if (!rs_Loai.BOF) rs_Loai.MoveFirst();
} else {
  rs_Loai.Requery();
}
%>
                </select>
                  <input name="old_image" type="hidden" id="old_image" value="<%=(rs_SP.Fields.Item("Hinh").Value)%>"></td>
              </tr>
              <tr>
              	<td colspan="2" align="center" valign="middle"><input name="themsp" type="submit" class="button" value="Cập nhật SP" onClick="return check();">&nbsp;&nbsp;<input name="trove" type="button" class="button" value="Trở Về" onClick="history.back(-1)"></td>
                </tr>
            </table>
            <input type="hidden" name="MM_update" value="sua_sp">
            <input type="hidden" name="MM_recordId" value="<%= rs_SP.Fields.Item("MaDoChoi").Value %>">
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
rs_SP.Close();
%>
<%
rs_Loai.Close();
%>
