SELECT 
    dh.MaDon,
    dh.ThoiGianDatHang,
    dh.TrangThaiDon,
    kh.TenNguoiNhan AS KhachHang,
    (SELECT GROUP_CONCAT(SDT SEPARATOR ', ') FROM SDT_KhachHang WHERE MaDon = dh.MaDon) AS SdtKhach,
    kh.DiaChi,
    dh.NgayLamViec AS NgayDongGoi,
    cl.TenCa,
    nv.MaNV AS MaNhanVienDong,
    nv.HoTen AS NhanVienDong,
    (SELECT GROUP_CONCAT(SDT SEPARATOR ', ') FROM SDT_NhanVien WHERE MaNV = nv.MaNV) AS SdtNhanVien,
    GROUP_CONCAT(ldh.LoaiLoi SEPARATOR ', ') AS CacLoiDaGhiNhan
FROM DonHang dh
JOIN ThongTinKH kh ON dh.MaDon = kh.MaDon
LEFT JOIN NhanVien nv ON dh.MaNV = nv.MaNV
LEFT JOIN CaLam cl ON dh.MaCa = cl.MaCa
LEFT JOIN LoiDongHang ldh ON dh.MaDon = ldh.MaDon
WHERE dh.MaDon = 2  
GROUP BY 
    dh.MaDon, dh.ThoiGianDatHang, dh.TrangThaiDon, 
    kh.TenNguoiNhan, kh.DiaChi, 
    dh.NgayLamViec, cl.TenCa, nv.MaNV, nv.HoTen;
