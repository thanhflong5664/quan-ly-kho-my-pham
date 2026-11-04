SELECT
	LH.MaLo,
	LH.NgayLap AS NgayNhapKho,
    HH.MaHang,
    HH.TenHang,
    CT.NgaySanXuat,
    CT.HanSuDung,
    (CT.SoLuong - IFNULL(Xuat.TongXuat, 0)) AS SoLuongTonKho
FROM HangHoa HH
JOIN ChiTietLoHang CT ON HH.MaHang = CT.MaHang
JOIN chitietdonhang ctd ON HH.MaHang = ctd.MaHang
JOIN LoHang LH ON CT.MaLo = LH.MaLo
Left join(
	Select Mahang, MaLo, Sum(Soluong) AS TongXuat
    From chitietdonhang
    Group by MaHang, MaLo
) Xuat On CT.mahang = Xuat.MaHang AND CT.MaLo = Xuat.MaLo    
Group by LH.MaLo, LH.NgayLap, HH.MaHang
ORDER BY LH.MaLo, LH.NgayLap ASC;