SELECT
    DVVC.MaDVVC,
    DVVC.TenDVVC,
    COUNT(DH.MaDon) AS TongSoDonHang
FROM DonViVanChuyen DVVC
LEFT JOIN DonHang DH
    ON DVVC.MaDVVC = DH.MaDVVC
    AND DH.ThoiGianBanGiao >= '2026-10-01'
    AND DH.ThoiGianBanGiao < '2026-11-01'
    AND DH.TrangThaiDon <> 'da_huy'
GROUP BY DVVC.MaDVVC, DVVC.TenDVVC
ORDER BY TongSoDonHang DESC;