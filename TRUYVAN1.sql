WITH ThongKeChamCong AS (
    SELECT 
        MaNV,
        COUNT(MaCa) AS SoCaDaLam,
        COUNT(DISTINCT NgayLamViec) AS SoNgayDaLam,
        SUM(CASE WHEN TrangThai = 'muon' THEN 1 ELSE 0 END) AS SoLanMuon
    FROM ChamCong
    WHERE MONTH(NgayLamViec) = 10 AND YEAR(NgayLamViec) = 2026
      AND TrangThai IN ('co_mat', 'muon')
    GROUP BY MaNV
),
ThongKeLoi AS (
    SELECT 
        MaNV,
        COUNT(MaLoi) AS SoLoi
    FROM LoiDongHang
    WHERE MONTH(NgayGhiNhan) = 10 AND YEAR(NgayGhiNhan) = 2026
    GROUP BY MaNV
),
MaxCa AS (
    SELECT MAX(SoCaDaLam) AS CaMax FROM ThongKeChamCong
)
SELECT 
    nv.MaNV,
    nv.HoTen,
    COALESCE(cc.SoCaDaLam, 0) AS SoCaDaLam,
    COALESCE(cc.SoNgayDaLam, 0) AS SoNgayDaLam,
    COALESCE(cc.SoLanMuon, 0) AS SoLanMuon,
    COALESCE(l.SoLoi, 0) AS SoLoiDongHang,
    
    (COALESCE(cc.SoCaDaLam, 0) * 108000) AS TienCa,
    (COALESCE(cc.SoNgayDaLam, 0) * 5000) AS TienGuiXe,
    CASE WHEN cc.SoCaDaLam = (SELECT CaMax FROM MaxCa) THEN 108000 ELSE 0 END AS TienThuong,
    
    (FLOOR(COALESCE(l.SoLoi, 0) ) * 40000) AS TienPhatLoi,
    (FLOOR(COALESCE(cc.SoLanMuon, 0) ) * 20000) AS TienPhatMuon,
    
    (
        (COALESCE(cc.SoCaDaLam, 0) * 108000) 
        + (COALESCE(cc.SoNgayDaLam, 0) * 5000) 
        + (CASE WHEN cc.SoCaDaLam = (SELECT CaMax FROM MaxCa) THEN 108000 ELSE 0 END)
        - (FLOOR(COALESCE(l.SoLoi, 0) / 2) * 80000)
        - (FLOOR(COALESCE(cc.SoLanMuon, 0) / 3) * 40000)
    ) AS TongThuNhap
    
FROM NhanVien nv
JOIN ThongKeChamCong cc ON nv.MaNV = cc.MaNV
LEFT JOIN ThongKeLoi l ON nv.MaNV = l.MaNV;