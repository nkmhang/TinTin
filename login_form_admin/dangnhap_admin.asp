<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/connectdb.asp" -->
<%
// *** Validate request to log in to this site.
var MM_LoginAction = Request.ServerVariables("URL");
if (Request.QueryString != "") MM_LoginAction += "?" + Server.HTMLEncode(Request.QueryString);
var MM_valUsername = String(Request.Form("username"));
if (MM_valUsername != "undefined") {
  var MM_fldUserAuthorization = "";
  var MM_redirectLoginSuccess = "../sp_admin.asp";
  var MM_redirectLoginFailed = "dangnhap_admin_sai.asp";

  var MM_loginSQL = "SELECT UserName, Password";
  if (MM_fldUserAuthorization != "") MM_loginSQL += "," + MM_fldUserAuthorization;
  MM_loginSQL += " FROM dbo.[Admin] WHERE UserName = ? AND Password = ?";
  var MM_rsUser_cmd = Server.CreateObject ("ADODB.Command");
  MM_rsUser_cmd.ActiveConnection = MM_connectdb_STRING;
  MM_rsUser_cmd.CommandText = MM_loginSQL;
  MM_rsUser_cmd.Parameters.Append(MM_rsUser_cmd.CreateParameter("param1", 200, 1, 20, MM_valUsername)); // adVarChar
  MM_rsUser_cmd.Parameters.Append(MM_rsUser_cmd.CreateParameter("param2", 200, 1, 20, Request.Form("password"))); // adVarChar
  MM_rsUser_cmd.Prepared = true;
  var MM_rsUser = MM_rsUser_cmd.Execute();

  if (!MM_rsUser.EOF || !MM_rsUser.BOF) {
    // username and password match - this is a valid user
    Session("MM_Admin_Username") = MM_valUsername;
    if (MM_fldUserAuthorization != "") {
      Session("MM_UserAuthorization") = String(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value);
    } else {
      Session("MM_UserAuthorization") = "";
    }
    if (String(Request.QueryString("accessdenied")) != "undefined" && false) {
      MM_redirectLoginSuccess = Request.QueryString("accessdenied");
    }
    MM_rsUser.Close();
    Response.Redirect(MM_redirectLoginSuccess);
  }
  MM_rsUser.Close();
  Response.Redirect(MM_redirectLoginFailed);
}
%>
<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <title>Đăng nhập vào Trang Admin</title>
    
    <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>

    <link rel="stylesheet" href="css/style.css">
 
  </head>

  <body>

    <div class="login-form">
     <h1>Admin của TinTin</h1>
     <div class="form-group ">
     	<form METHOD="POST" action="<%=MM_LoginAction%>" name="dangnhap_admin">
       <input type="text" name="username" class="form-control" placeholder="username" id="username">
       <i class="fa fa-user"></i>
         </div>
         <div class="form-group log-status">
       <input type="password" name="password" class="form-control" placeholder="password" id="password">
       <i class="fa fa-lock"></i>
     </div>
     <button type="submit" class="log-btn">Log in</button>
 		</form>
   </div>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

        <script src="js/index.js"></script>
    
  </body>
</html>

