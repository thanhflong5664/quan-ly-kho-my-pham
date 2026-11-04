SELECT
    LH.MaLo,
    HH.MaHang,
    HH.TenHang,
    CT.HanSuDung,
	(CT.SoLuong - IFNULL(Xuat.TongXuat, 0)) AS SoLuongTonKho
FROM HangHoa HH
JOIN ChiTietLoHang CT ON HH.MaHang = CT.MaHang
JOIN LoHang LH ON CT.MaLo = LH.MaLo 
Left join(
	Select Mahang, MaLo, Sum(Soluong) AS TongXuat
    From chitietdonhang
    Group by MaHang, MaLo
) Xuat On CT.mahang = Xuat.MaHang AND CT.MaLo = Xuat.MaLo 
WHERE CT.HanSuDung > CURDATE()
  AND CT.HanSuDung < DATE_ADD(CURDATE(), INTERVAL 6 MONTH)
ORDER BY LH.MaLo ASC;
