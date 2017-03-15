// JavaScript Document
window.onload = function MKT()
{
	var capchar= Math.round(Math.random()*999999);
	document.getElementById('ngau_nhien').innerHTML=capchar;
}
function check_dangky()
{
	    			var code = document.getElementById('ngau_nhien').innerHTML;
					var reg_mail = /^[A-Za-z0-9]+([_\.\-]?[A-Za-z0-9])*@[A-Za-z0-9]+([\.\-]?[A-Za-z0-9]+)*(\.[A-Za-z]+)+$/;
					var reg_trang = /\s/g;
					var reg_hoten = /  +/;
					var reg_ngay =  new RegExp("^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1[0-9])|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$");
					
					var username = document.getElementById("username").value;
					var password = document.getElementById("password").value;
					var repass = document.getElementById("repass").value;
					var hoten = document.getElementById("hoten").value;
					var gioitinh = document.getElementById("nam").checked;
					var dob = document.getElementById("dob").value;
					var email = document.getElementById("email").value;
					var MKT = document.getElementById("MKT").value;
					var agree = document.getElementById("agree").checked;
					
					var time = new Date();
					var namht= time.getFullYear()-20;
					var namnh = dob.slice(0,4);
					
					if(username.length==0)
					{
						alert("Username không được để trống");
						document.getElementById("username").focus();
						return false;
					}
					else if(reg_trang.test(username))
					{
						alert("Username không được có khoảng trắng");
						document.getElementById("username").focus();
						return false;
					}
					else if(username.length<6 || username.length>20)
					{
						alert("Username phải từ 6 đến 20 ký tự");
						document.getElementById("username").focus();
						return false;
					}
					else if(password.length==0)
					{
						alert("Password không được để trống");
						document.getElementById("password").focus();
						return false;
					}
					else if(password.length<6 || password.length>30)
					{
						alert("Password phải từ 6 đến 30 ký tự");
						document.getElementById("password").focus();
						return false;
					}
					else if(repass.length==0)
					{
						alert("Re-Password không được để trống");
						document.getElementById("repass").focus();
						return false;
					}
					else if(repass!=password)
					{
						alert("Password và Re-Password không trùng nhau");
						document.getElementById("password").focus();
						return false;
					}
					else if(hoten.length==0)
					{
						alert("Họ tên không được để trống");
						document.getElementById("hoten").focus();
						return false;
					}
					else if(reg_hoten.test(hoten))
					{
						alert("Họ tên không được có nhiều khoảng trắng liên tiếp");
						document.getElementById("hoten").focus();
						return false;
					}
					else if(!reg_ngay.test(dob))
					{
						alert("Ngày sinh không hợp lệ");
						document.getElementById("dob").focus();
						return false;
					}
					else if(namht < namnh)
					{
						alert("Bạn phải từ 20 tuổi trở lên");
						document.getElementById("dob").focus();
						return false;
					}
					else if(email.length==0)
					{
						alert("Email không được để trống");
						document.getElementById("email").focus();
						return false;
					}
					else if(!reg_mail.test(email))
					{
						alert("Email không hợp lệ");
						document.getElementById("email").focus();
						return false;
					}
					else if(MKT.length==0)
					{
						alert("MKT không được để trống");
						document.getElementById("MKT").focus();
						return false;
					}
					else if(MKT!=code)
					{
						alert("Mã kiểm tra không trùng khớp");
						document.getElementById("MKT").focus();
						return false;
					}
					else if(agree == false)
					{
						alert("Bạn cần đọc Chính sách bảo mật thông tin");
						return false;
					}
						return true;
}

