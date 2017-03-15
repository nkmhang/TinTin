<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/connectdb.asp" -->
<%
var rs_gopy_cmd = Server.CreateObject ("ADODB.Command");
rs_gopy_cmd.ActiveConnection = MM_connectdb_STRING;
rs_gopy_cmd.CommandText = "SELECT * FROM dbo.GopY ORDER BY TrangThai ASC";
rs_gopy_cmd.Prepared = true;

var rs_gopy = rs_gopy_cmd.Execute();
var rs_gopy_numRows = 0;
%>
<%
var Repeat1__numRows = 10;
var Repeat1__index = 0;
rs_gopy_numRows += Repeat1__numRows;
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

// set the record count
var rs_gopy_total = rs_gopy.RecordCount;

// set the number of rows displayed on this page
if (rs_gopy_numRows < 0) {            // if repeat region set to all records
  rs_gopy_numRows = rs_gopy_total;
} else if (rs_gopy_numRows == 0) {    // if no repeat regions
  rs_gopy_numRows = 1;
}

// set the first and last displayed record
var rs_gopy_first = 1;
var rs_gopy_last  = rs_gopy_first + rs_gopy_numRows - 1;

// if we have the correct record count, check the other stats
if (rs_gopy_total != -1) {
  rs_gopy_numRows = Math.min(rs_gopy_numRows, rs_gopy_total);
  rs_gopy_first   = Math.min(rs_gopy_first, rs_gopy_total);
  rs_gopy_last    = Math.min(rs_gopy_last, rs_gopy_total);
}
%>
<% var MM_paramName = ""; %>
<%
// *** Move To Record and Go To Record: declare variables

var MM_rs        = rs_gopy;
var MM_rsCount   = rs_gopy_total;
var MM_size      = rs_gopy_numRows;
var MM_uniqueCol = "";
    MM_paramName = "";
var MM_offset = 0;
var MM_atTotal = false;
var MM_paramIsDefined = (MM_paramName != "" && String(Request(MM_paramName)) != "undefined");
%>
<%
// *** Move To Record: handle 'index' or 'offset' parameter

if (!MM_paramIsDefined && MM_rsCount != 0) {

  // use index parameter if defined, otherwise use offset parameter
  r = String(Request("index"));
  if (r == "undefined") r = String(Request("offset"));
  if (r && r != "undefined") MM_offset = parseInt(r);

  // if we have a record count, check if we are past the end of the recordset
  if (MM_rsCount != -1) {
    if (MM_offset >= MM_rsCount || MM_offset == -1) {  // past end or move last
      if ((MM_rsCount % MM_size) != 0) {  // last page not a full repeat region
        MM_offset = MM_rsCount - (MM_rsCount % MM_size);
      } else {
        MM_offset = MM_rsCount - MM_size;
      }
    }
  }

  // move the cursor to the selected record
  for (var i=0; !MM_rs.EOF && (i < MM_offset || MM_offset == -1); i++) {
    MM_rs.MoveNext();
  }
  if (MM_rs.EOF) MM_offset = i;  // set MM_offset to the last possible record
}
%>
<%
// *** Move To Record: if we dont know the record count, check the display range

if (MM_rsCount == -1) {

  // walk to the end of the display range for this page
  for (var i=MM_offset; !MM_rs.EOF && (MM_size < 0 || i < MM_offset + MM_size); i++) {
    MM_rs.MoveNext();
  }

  // if we walked off the end of the recordset, set MM_rsCount and MM_size
  if (MM_rs.EOF) {
    MM_rsCount = i;
    if (MM_size < 0 || MM_size > MM_rsCount) MM_size = MM_rsCount;
  }

  // if we walked off the end, set the offset based on page size
  if (MM_rs.EOF && !MM_paramIsDefined) {
    if ((MM_rsCount % MM_size) != 0) {  // last page not a full repeat region
      MM_offset = MM_rsCount - (MM_rsCount % MM_size);
    } else {
      MM_offset = MM_rsCount - MM_size;
    }
  }

  // reset the cursor to the beginning
  if (MM_rs.CursorType > 0) {
    if (!MM_rs.BOF) MM_rs.MoveFirst();
  } else {
    MM_rs.Requery();
  }

  // move the cursor to the selected record
  for (var i=0; !MM_rs.EOF && i < MM_offset; i++) {
    MM_rs.MoveNext();
  }
}
%>
<%
// *** Move To Record: update recordset stats

// set the first and last displayed record
rs_gopy_first = MM_offset + 1;
rs_gopy_last  = MM_offset + MM_size;
if (MM_rsCount != -1) {
  rs_gopy_first = Math.min(rs_gopy_first, MM_rsCount);
  rs_gopy_last  = Math.min(rs_gopy_last, MM_rsCount);
}

// set the boolean used by hide region to check if we are on the last record
MM_atTotal = (MM_rsCount != -1 && MM_offset + MM_size >= MM_rsCount);
%>
<%
// *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

// create the list of parameters which should not be maintained
var MM_removeList = "&index=";
if (MM_paramName != "") MM_removeList += "&" + MM_paramName.toLowerCase() + "=";
var MM_keepURL="",MM_keepForm="",MM_keepBoth="",MM_keepNone="";

// add the URL parameters to the MM_keepURL string
for (var items=new Enumerator(Request.QueryString); !items.atEnd(); items.moveNext()) {
  var nextItem = "&" + items.item().toLowerCase() + "=";
  if (MM_removeList.indexOf(nextItem) == -1) {
    MM_keepURL += "&" + items.item() + "=" + Server.URLencode(Request.QueryString(items.item()));
  }
}

// add the Form variables to the MM_keepForm string
for (var items=new Enumerator(Request.Form); !items.atEnd(); items.moveNext()) {
  var nextItem = "&" + items.item().toLowerCase() + "=";
  if (MM_removeList.indexOf(nextItem) == -1) {
    MM_keepForm += "&" + items.item() + "=" + Server.URLencode(Request.Form(items.item()));
  }
}

// create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL + MM_keepForm;
if (MM_keepBoth.length > 0) MM_keepBoth = MM_keepBoth.substring(1);
if (MM_keepURL.length > 0)  MM_keepURL = MM_keepURL.substring(1);
if (MM_keepForm.length > 0) MM_keepForm = MM_keepForm.substring(1);
%>
<%
// *** Move To Record: set the strings for the first, last, next, and previous links

var MM_moveFirst="",MM_moveLast="",MM_moveNext="",MM_movePrev="";
var MM_keepMove = MM_keepBoth;  // keep both Form and URL parameters for moves
var MM_moveParam = "index";

// if the page has a repeated region, remove 'offset' from the maintained parameters
if (MM_size > 1) {
  MM_moveParam = "offset";
  if (MM_keepMove.length > 0) {
    params = MM_keepMove.split("&");
    MM_keepMove = "";
    for (var i=0; i < params.length; i++) {
      var nextItem = params[i].substring(0,params[i].indexOf("="));
      if (nextItem.toLowerCase() != MM_moveParam) {
        MM_keepMove += "&" + params[i];
      }
    }
    if (MM_keepMove.length > 0) MM_keepMove = MM_keepMove.substring(1);
  }
}

// set the strings for the move to links
if (MM_keepMove.length > 0) MM_keepMove = Server.HTMLEncode(MM_keepMove) + "&";
var urlStr = Request.ServerVariables("URL") + "?" + MM_keepMove + MM_moveParam + "=";
MM_moveFirst = urlStr + "0";
MM_moveLast  = urlStr + "-1";
MM_moveNext  = urlStr + (MM_offset + MM_size);
MM_movePrev  = urlStr + Math.max(MM_offset - MM_size,0);
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
            <script>
			function tim()
			{
				var x = document.getElementById("searching").value;
				window.location="tim_gopy_admin.asp?user="+x;
			}
			</script>
            <div class="right">
              <label>Tìm Username</label>
              <input type="text" id="searching" class="field small-field" />
              <input type="submit" class="button" value="search" onClick="tim();"/>
              <button class="button"><A HREF="<%=MM_moveFirst%>">First</A></button>
            </div>
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
    rs_trangthai_cmd.CommandText = "SELECT * FROM dbo.trangthaigopy WHERE MaGopY = ? ORDER BY MaGopY DESC";
    rs_trangthai_cmd.Prepared = true;
    rs_trangthai_cmd.Parameters.Append(rs_trangthai_cmd.CreateParameter("param1", 5, 1, -1, rs_trangthai__MMColParam)); // adDouble
    
    var rs_trangthai = rs_trangthai_cmd.Execute();
    var rs_trangthai_numRows = 0;
    %>
    <% if (rs_trangthai.EOF && rs_trangthai.BOF) { %>
  <a href="editgopy_admin.asp?ma=<%=(rs_gopy.Fields.Item("MaGopY").Value)%>" class="ico edit">Trả Lời</a>
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
<%
rs_trangthai.Close();
%>