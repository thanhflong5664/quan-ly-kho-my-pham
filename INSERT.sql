insert into NhanVien values
('NV01','Nguyễn Văn An','2003-05-12','Nam Định','001203000001','Thanh Xuân, Hà Nội','1016700001 VietinBank','nhan_vien'),
('NV02','Trần Thị Bình','2004-08-20','Thái Bình','001204000002','Hà Đông, Hà Nội','1016700002 TechcomaBank','nhan_vien'),
('NV03','Lê Văn Cường','2002-01-03','Hà Nam','001202000003','Hoàng Mai, Hà Nội','1016700003 MbBank','nhan_vien'),
('NV04','Phạm Thị Dung','1995-11-30','Hà Nội','001195000004','Cầu Giấy, Hà Nội','1016700004 ACB','quan_ly');
insert into NhanVien values
('NV05','Ngô Đức Vinh','2006-01-01','Hà Nội','035200123456','Đống Đa, Hà Nội','12348386 AgriBank','nhan_vien');


insert into SDT_NhanVien values
('NV01','0901000001'),
('NV02','0901000002'),
('NV03','0901000003'),
('NV04','0901000004'),
('NV04','0987000004'),
('NV05','0988888888');

insert into DonViVanChuyen values
('GHN','Giao Hàng Nhanh'), ('J&T','J&T Express'), ('SPX','Shopee Express');

insert into CaLam values ('CA_S','sang',4), ('CA_C','chieu',4);

insert into HangHoa values
('HH01','Men vi sinh Probiotic Liguma ','chai'),
('HH02','Nước giặt quần áo','chai'),
('HH03','Son dưỡng môi không chì','thỏi');

insert into LichLamViec values
('2026-09-30','NV01','CA_S','GHN'),
('2026-10-01','NV01','CA_S','GHN'),('2026-10-01','NV01','CA_C','GHN'),
('2026-10-02','NV01','CA_S','GHN'),('2026-10-02','NV01','CA_C','GHN'),
('2026-10-03','NV01','CA_S','GHN'),('2026-10-03','NV01','CA_C','GHN'),
('2026-10-04','NV01','CA_S','GHN'),('2026-10-04','NV01','CA_C','GHN'),
('2026-10-05','NV01','CA_S','GHN'),('2026-10-05','NV01','CA_C','GHN'),

('2026-10-01','NV02','CA_S','J&T'),('2026-10-01','NV02','CA_C','J&T'),
('2026-10-02','NV02','CA_S','J&T'),('2026-10-02','NV02','CA_C','J&T'),
('2026-10-03','NV02','CA_S','GHN'), ('2026-10-04','NV02','CA_S','J&T'),

('2026-10-01','NV03','CA_C','SPX'),('2026-10-02','NV03','CA_C','SPX'),
('2026-10-03','NV03','CA_C','SPX'),('2026-10-04','NV03','CA_C','SPX');

insert into LichLamViec values
('2026-10-05','NV05','CA_S','J&T'),('2026-10-05','NV05','CA_C','SPX'),
('2026-10-06','NV05','CA_S','SPX'),('2026-10-06','NV05','CA_C','GHN');

insert into ChamCong (NgayLamViec, MaNV, MaCa, TrangThai) values
('2026-09-30','NV01','CA_S','co_mat'),
('2026-10-01','NV01','CA_S','co_mat'),('2026-10-01','NV01','CA_C','co_mat'),
('2026-10-02','NV01','CA_S','co_mat'),('2026-10-02','NV01','CA_C','co_mat'),
('2026-10-03','NV01','CA_S','co_mat'),('2026-10-03','NV01','CA_C','co_mat'),
('2026-10-04','NV01','CA_S','co_mat'),('2026-10-04','NV01','CA_C','co_mat'),
('2026-10-05','NV01','CA_S','co_mat'),('2026-10-05','NV01','CA_C','co_mat'),
('2026-10-01','NV02','CA_S','muon'),('2026-10-01','NV02','CA_C','co_mat'),
('2026-10-02','NV02','CA_S','muon'),('2026-10-02','NV02','CA_C','co_mat'),
('2026-10-03','NV02','CA_S','muon'),('2026-10-04','NV02','CA_S','co_mat'),
('2026-10-01','NV03','CA_C','co_mat'),('2026-10-02','NV03','CA_C','co_mat'),
('2026-10-03','NV03','CA_C','vang'),('2026-10-04','NV03','CA_C','co_mat');

insert into ChamCong (NgayLamViec, MaNV, MaCa, TrangThai) values
('2026-10-05','NV05','CA_S','co_mat'),('2026-10-05','NV05','CA_C','co_mat'),
('2026-10-06','NV05','CA_S','muon'),('2026-10-06','NV05','CA_C','vang');

insert into LoHang (MaLo, NgayLap, MaNV) values
(1,'2026-01-10 08:00:00','NV04'),
(2,'2026-06-01 08:00:00','NV04'),
(3,'2026-09-15 08:00:00','NV04'),
(4,'2026-11-11 09:00:00','NV04');

insert into ChiTietLoHang (MaLo, MaHang, SoLuong, NgaySanXuat, HanSuDung) values
(1,'HH01',100,'2024-02-01','2027-02-01'),
(1,'HH02', 50,'2025-01-01','2028-01-01'),
(2,'HH01',200,'2025-06-01','2028-06-01'),
(2,'HH03', 30,'2023-12-15','2026-12-15'),
(3,'HH03', 20,'2024-08-01','2027-08-01'),
(4,'HH01', 10,'2026-11-01','2026-11-01');

insert into DonHang (MaDon, ThoiGianDatHang, TrangThaiDon, NgayLamViec, MaNV, MaCa, MaDVVC, ThoiGianBanGiao) values
(1,'2026-10-01 07:30:45','da_nhan','2026-10-01','NV01','CA_S','GHN', '2026-10-01 15:00:00'),
(2,'2026-10-02 07:45:36','da_nhan','2026-10-02','NV02','CA_S','J&T','2026-10-02 15:00:00'),
(3,'2026-10-03 08:09:10','dang_giao_hang','2026-10-03','NV02','CA_S','GHN', '2026-10-03 15:00:00'),
(4,'2026-10-04 12:34:56','da_huy','2026-10-04','NV03','CA_C','SPX', null),
(5,'2026-10-05 13:01:40','cho_giao_hang','2026-10-05','NV01','CA_C','GHN', null),
(6,'2026-09-30 07:58:34','da_nhan','2026-09-30','NV01','CA_S','GHN', '2026-09-30 15:00:00'),
(7,'2026-10-22 09:01:00','da_xac_nhan', null, null, null,'J&T',null);

insert into ThongTinKH values
(1,'Hoàng Minh Tuấn','12 Trần Phú, Hà Đông, Hà Nội'),
(2,'Vũ Thu Hà','45 Lê Lợi, TP Vinh, Nghệ An'),
(3,'Đỗ Quang Huy','128 Triệu Quốc Đạt, Phường Điện Biên, Thành Phố Thanh Hóa, tỉnh Thanh Hóa'),
(4,'Bùi Lan Anh','142 Hàn Thuyên, Phường Vị Xuyên, Thành Phố Nam Định, Tỉnh Nam Định'),
(5,'Ngô Đức Long','3 Hùng Vương, Đà Nẵng'),
(6,'Mai Thanh Tâm','66B Nguyễn Sỹ Sách , Phường 15 Tân Bình, TPHCM'),
(7,'Đinh Hải Yến','15 Mai Xá, Vĩnh Trụ, Lý Nhân, Hà Nam');

insert into SDT_KhachHang values
(1,'0912000001'),
(2,'0912000002'),
(3,'0912000003'),
(3,'0987000003'),
(4,'0912000004'),
(5,'0912000005'),
(6,'0912000006'),
(7,'0912000007');

insert into ChiTietDonHang values
(1,1,'HH01',5),
(1,1,'HH02',2),
(2,1,'HH01',3),
(3,2,'HH03',4),
(4,1,'HH01',10),     
(5,2,'HH01',7),
(6,1,'HH01',1),
(7,3,'HH03',2);

insert into LoiDongHang (MaDon, MaNV, LoaiLoi, NgayGhiNhan) values
(2,'NV02','dong_sai','2026-10-04'),
(3,'NV02','thieu_hang','2026-10-06'),
(4,'NV03','thieu_hang','2026-10-05');
