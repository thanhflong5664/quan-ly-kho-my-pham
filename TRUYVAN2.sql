SELECT 
    nv.MaNV,
    nv.HoTen,
    cc.NgayLamViec,
    cl.TenCa,
    cc.TrangThai,
    CASE 
        WHEN cc.TrangThai IN ('co_mat', 'muon') THEN 108000 
        ELSE 0 
    END AS LuongCa,
    CASE 
        WHEN cc.TrangThai IN ('co_mat', 'muon') 
             AND cc.MaCa = (SELECT MIN(MaCa) FROM ChamCong WHERE MaNV = cc.MaNV AND NgayLamViec = cc.NgayLamViec AND TrangThai IN ('co_mat', 'muon')) 
        THEN 5000 
        ELSE 0 
    END AS TienGuiXe
FROM ChamCong cc
JOIN NhanVien nv ON cc.MaNV = nv.MaNV
JOIN CaLam cl ON cc.MaCa = cl.MaCa
WHERE cc.MaNV = 'NV01' 
  AND MONTH(cc.NgayLamViec) = 10 
  AND YEAR(cc.NgayLamViec) = 2026
ORDER BY cc.NgayLamViec ASC, cc.MaCa ASC;