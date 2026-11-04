drop database if exists quan_ly_kho_my_pham;

INSERT INTO ChamCong VALUES ('NV03', 'CA_S', '2026-10-01', 'co_mat');	

INSERT INTO DonHang (TrangThaiDon, NgayLamViec, MaNV, MaCa, MaDVVC)
VALUES ('dang_dong_hang', '2026-10-05', 'NV02', 'CA_C', 'J&T');

INSERT INTO LichLamViec VALUES ('2026-10-01', 'NV01', 'CA_S', 'SPX');

INSERT INTO SDT_NhanVien VALUES ('NV02', '0901000001');

INSERT INTO ChiTietDonHang VALUES (7, 3, 'HH01', 1);

DELETE FROM LoiDongHang WHERE MaLoi > 3;