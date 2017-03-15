use master
go

--tao database
create database TinTin
go

--Tao table tren database TinTin
use TinTin
go

--Tao bang TheLoai
create table TheLoai
(
	MaTheLoai varchar(5) primary key,
	Ten nvarchar(30) not null
)
go

--Nhap data cho bang TheLoai
insert into TheLoai values('TL1',N'Đồ chơi trí tuệ'),
							('TL2',N'Đồ chơi vận động'),
							('TL3',N'Đồ chơi điện tử')
go

--Tao bang KhachHang
create table KhachHang
(
	MaKH int identity(1,1),
	UserName varchar(20) primary key,
	[Password] varchar(20) not null,
	HoTen nvarchar(50) not null,
	GioiTinh bit not null,
	NgaySinh varchar(30) check (NgaySinh < getDate()) not null,
	Email varchar(50) unique not null
)
go
--Nhap data mau khach hang
insert into KhachHang values
('khsample1','123456','khsample1',1,'1900-01-01','khsample1@gmail.com'),
('khsample2','123456','khsample2',0,'1900-01-01','khsample2@yahoo.com')
go

--Tao bang DoChoi
create table DoChoi
(
	MaDoChoi int identity(1000,1) primary key,
	TenDoChoi nvarchar(30) not null,
	Gia int not null,
	NSX nvarchar(30) not null,
	Hinh nvarchar(300) not null,
	MoTa nvarchar(300) not null,
	MaTheLoai varchar(5) not null,
	constraint fk_theloai foreign key (MaTheLoai) references TheLoai(MaTheLoai)
)
go
--Nhap data vang bang DoChoi
insert into DoChoi values
(N'Đàn điện tử nhỏ',200,'Hasbro','img01.jpg',N'Kiểu dáng đẹp mắt với 37 phím đàn và các chế độ đặt sẵn, Loa to; rõ ràng chất lượng âm thanh tốt','TL3'),
(N'Xe điều khiển từ xa',500,'Megabloks','img05.jpg',N'Tốc độ vượt trội, Điều khiển  đơn giản, Pin AA phổ biến, thay đổi dễ dàng, An toàn tuyệt đối khi sử dụng với trẻ em','TL3'),
(N'Talking Tom',100,'Nintendo','img06.jpg',N'Là đồ chơi thông minh, Có khả năng nhại giọng nói, Thích hợp cho bé từ 3 tuổi trở lên','TL3'),
(N'Xe lửa học số',200,'Lego','img12.jpg',N'Chất liệu nhựa ABS an toàn, Gồm 31 chi tiết, lắp ráp được thành đoàn tàu hỏa và in các chữ số từ 0 đến 9, Các chi tiết đồ chơi nhẵn mịn, không gây tổn thương cho bé','TL1'),
(N'Xỏ dây thông minh',150,'Fisher-Price','img09.jpg',N'Sản phẩm được thiết kế đơn giản nhưng sẽ là một bài toán khó khi muốn lấy sợi dây ra khỏi mê cung. Người chơi  phải suy nghĩ logic thật tốt, thích hợp thư  giãn sau những lúc học tập, làm việc căng thẳng.','TL1'),
(N'Tranh ghép hươu cao cổ',300,'Lego','img11.jpg',N'Giúp trẻ sáng tạo trí tưởng tượng, tăng khả năng tư duy. Làm bằng chất liệu gỗ nhẹ, màu sắc đẹp an toàn cho bé. Sản phẩm là hình Hươu cao cổ - nhân vật hoạt hình mà bé yêu thích.','TL1'),
(N'Đồ chơi thả khối',350,'Megabloks','img07.jpg',N'4 khe rãnh với đầy đủ các khối hình nhiều màu giúp bé phát triển tư duy và tính sáng tạo','TL1'),
(N'Nhà bóng',800,'Fisher-Price','img13.jpg',N'Chất liệu: khung thép dẻo, vải siêu bền, Kích thước lều: 85 x 85 x 100 ( cm ), Dành cho bé từ 3 tuổi trở lên, Dễ dàng gấp gọn khi không sử dụng','TL2'),
(N'Cầu trượt',850,'Hasbro','img15.jpg',N'Chất liệu được làm từ nhựa cao cấp, có thể chơi trong nhà hoặc ngoài trời, phù hợp cho sự phát triển thể chất của trẻ','TL2')
go


--Tao bang GopY
create table GopY
(
	MaGopY int identity(100,1) primary key,
	UserName varchar(20) not null,
	constraint fk_user foreign key (UserName) references KhachHang(UserName),
	NoiDungGopY nvarchar(200) not null,
	NgayGopY date default(getDate()),
	TrangThai bit default 0,
	NoiDungTraLoi nvarchar(300)
)
go
--Nhap mau data cho GopY
insert into GopY values
('khsample1','gopy01',default,default,null),
('khsample1','gopy02',default,1,'traloi02')
go

--Tao bang Admin
create table [Admin]
(
	UserName nvarchar(20) primary key,
	[Password] varchar(20) not null
)
go

insert into [Admin] values
('admin1','123456'),
('admin2','654321')
go

--Tao view chitiet do choi
create view chitietdochoi
as
select d.MaDoChoi,d.TenDoChoi,d.Gia,d.Hinh,d.MoTa as Chitiet,d.NSX,t.Ten as TheLoai
from DoChoi d,TheLoai t
where d.MaTheLoai=t.MaTheLoai
go

--Tao view trang thai cho gopy
create view trangthaigopy
as select MaGopY, TrangThai
from GopY 
where TrangThai = 1
go
