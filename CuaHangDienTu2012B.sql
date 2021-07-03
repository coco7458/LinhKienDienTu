/*
Created: 27/10/2020
Modified: 01/07/2021
Model: Microsoft SQL Server 2014
Database: MS SQL Server 2014
*/
use master

----------
create database Electronic
ON
	(NAME='Electronic_DATA',
	FILENAME='E:\CSDL\dienmay\Electronic.MDF')
LOG ON
	(NAME='LINHKIEN_LOG',
	FILENAME='E:\CSDL\dienmay\Electronic.LDF')
GO
use Electronic
GO

-- Create tables section -------------------------------------------------

-- Table KhachHang

CREATE TABLE KhachHang
(
 MaKhach Int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL primary key,
 TenKhach Varchar(100) NULL,
 DiaChi Varchar(100) NULL,
 DiaChiEmail Varchar(100) NULL,
 SoDienThoai Varchar(100) NULL,
 NgaySinh Date NULL,
 TinhTrang Char(100) NULL,
 TaiKhoan Varchar(100) NULL,
 MatKhau Varchar(100) NULL
)
go

-- Add keys for table KhachHang

ALTER TABLE [KhachHang] ADD CONSTRAINT [PK_KhachHang] PRIMARY KEY ([MaKhach])
go

-- Table DonHang

CREATE TABLE DonHang
(
 MaDonHang Int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL primary key ,
 TongSoLuong Int NULL,
 TongGiaBan Int NULL,
 TinhTrang Nvarchar(100) NULL,
 MaKhach Int NOT NULL
 Constraint FK_KhachHang Foreign key (MaKhach) References KhachHang(MaKhach),
)
go

-- Add keys for table DonHang

ALTER TABLE [DonHang] ADD CONSTRAINT [PK_DonHang] PRIMARY KEY ([MaDonHang],[MaKhach])
go
-------------
CREATE TABLE Loai
(
 MaLoai Int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL primary key,
 TenLoai Nvarchar(100) NULL
)
-----------------
CREATE TABLE NhaSanXuat
(
 MaNhaSX Int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL primary key,
 TenNhaSX Nvarchar(100) NULL,
 SoDiaChi Nvarchar(100) NULL,
 SoDienThoai Varchar(100) NULL,
 DiaChiEmail Varchar(100) NULL
)

-- Table SanPham

CREATE TABLE SanPham
(
 MaSanPham Int IDENTITY(1,1) NOT FOR REPLICATION NOT NULL primary key,
 TenSanPham Nvarchar(100) NULL,
 GiaBan Int NULL,
 AnhSanPham Varchar(max) NULL,
 MoTa Nvarchar(max) NULL,
 SoLuong Tinyint NULL,
 TinhTrang Nvarchar(100) NULL,
 MaLoai Int NOT NULL,
 MaNhaSX Int NOT NULL,
 Constraint FK_Loai Foreign key (MaLoai) References Loai(MaLoai),
 Constraint FK_NhaSanXuat Foreign key (MaNhaSX) References NhaSanXuat(MaNhaSX),
)
go

-- Add keys for table SanPham

ALTER TABLE [SanPham] ADD CONSTRAINT [PK_SanPham] PRIMARY KEY ([MaSanPham],[MaLoai],[MaNhaSX])
go

-- Table Loai


go

-- Add keys for table Loai

ALTER TABLE [Loai] ADD CONSTRAINT [PK_Loai] PRIMARY KEY ([MaLoai])
go

-- Table NhaSanXuat


go

-- Add keys for table NhaSanXuat

ALTER TABLE [NhaSanXuat] ADD CONSTRAINT [PK_NhaSanXuat] PRIMARY KEY ([MaNhaSX])
go

-- Table ChiTietHoaDon

CREATE TABLE ChiTietHoaDon
(
 MaDonHang Int NOT NULL,
 MaSanPham Int NOT NULL,
 SoLuongMua Tinyint NULL,
 Dongia int check(Dongia>=0),
 NgayMua Date NULL,
 Ngaygiao Date NULL,
 Constraint PK_ChiTietHoaDon PRIMARY KEY( MaDonHang,MaSanPham),
 Constraint FK_MaDonHang Foreign key (MaDonHang) References DonHang(MaDonHang),
 Constraint FK_SanPham Foreign key (MaSanPham) References SanPham(MaSanPham),
)
go

-- Add keys for table ChiTietHoaDon

ALTER TABLE [ChiTietHoaDon] ADD CONSTRAINT [PK_ChiTietHoaDon] PRIMARY KEY ([MaDonHang],[MaSanPham])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [DonHang] ADD CONSTRAINT [Relationship147] FOREIGN KEY ([MaKhach]) REFERENCES [KhachHang] ([MaKhach]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [ChiTietHoaDon] ADD CONSTRAINT [Relationship148] FOREIGN KEY ([MaDonHang], [MaKhach]) REFERENCES [DonHang] ([MaDonHang], [MaKhach]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [ChiTietHoaDon] ADD CONSTRAINT [Relationship149] FOREIGN KEY ([MaSanPham], [MaLoai], [MaNhaSX]) REFERENCES [SanPham] ([MaSanPham], [MaLoai], [MaNhaSX]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [SanPham] ADD CONSTRAINT [Relationship150] FOREIGN KEY ([MaLoai]) REFERENCES [Loai] ([MaLoai]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [SanPham] ADD CONSTRAINT [Relationship151] FOREIGN KEY ([MaNhaSX]) REFERENCES [NhaSanXuat] ([MaNhaSX]) ON UPDATE NO ACTION ON DELETE NO ACTION
go




insert into NhaSanXuat values(N'SamSung',N'USA','098995865','Samsung123@gmail.com')
insert into NhaSanXuat values(N'Alppe',N'USA','098945696','Alppe123@gmail.com')

insert into Loai values(N'Điện Thoại Động')
insert into Loai values(N'Máy Tính Bản')
insert into Loai values(N'Laptop')
insert into Loai values(N'Ipop')

insert into SanPham values(N'SamSung Galaxy A12',4500000,'SamA12.jpn',N'Màu đẹp',50,N'Mới',1,1)
insert into SanPham values(N'SamSung Galaxy A51',2500000,'SamA51.jpn',N'Màu đẹp',50,N'Mới',1,1)
insert into SanPham values(N'SamSung Galaxy Z Fold2',5000000,'SamAZF.jpn',N'Màu đẹp',50,N'Mới',1,1)
insert into SanPham values(N'SamSung Galaxy S21',23900000,'SamS21.jpn',N'Màu đẹp',50,N'Mới',1,1)
insert into SanPham values(N'SamSung Galaxy S21 Ultra',12000000,'SamS21U.jpn',N'Màu đẹp',50,N'Mới',1,1)
insert into SanPham values(N'SamSung Galaxy A52',4500000,'SamA52.jpn',N'Màu đẹp',50,N'Mới',1,1)

insert into SanPham values(N'Iphone 12 Pro',22000000,'I12.jpn',N'Màu đẹp',50,N'Mới',1,2)
insert into SanPham values(N'Iphone 11',20000000,'I11.jpn',N'Màu đẹp',50,N'Mới',1,2)