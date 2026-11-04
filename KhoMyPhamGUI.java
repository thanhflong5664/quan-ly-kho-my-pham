package com.mycompany.database;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

public class KhoMyPhamGUI extends JFrame {
    private JTable table;
    private DefaultTableModel tableModel;
    
    // Cấu hình kết nối MySQL
    static final String DB_URL = "jdbc:mysql://localhost:3306/quan_ly_kho_my_pham";
    static final String USER = "root";
    static final String PASS = "04072006"; // Điền mật khẩu MySQL của bạn vào đây (nếu có)

    public KhoMyPhamGUI() {
        setTitle("Hệ Thống Quản Lý Kho Mỹ Phẩm - Cổng Giám Sát & Điều Hành (Manager Dashboard)");
        setSize(1250, 700);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null); // Hiển thị giữa màn hình

        // Thiết kế khung chứa nút bấm chia thành 2 nhóm chuyên biệt cho Quản lý
        JPanel panelTop = new JPanel();
        panelTop.setLayout(new GridLayout(2, 1, 0, 0));

        // --- HÀNG 1: BÁO CÁO & TRUY VẤN NGHIỆP VỤ (6 Yêu cầu cốt lõi) ---
        JPanel panelReports = new JPanel();
        panelReports.setBackground(new Color(41, 128, 185));
        panelReports.setLayout(new FlowLayout(FlowLayout.CENTER, 8, 10));

        JButton btn1 = new JButton("1. Thu Nhập Nhân Viên");
        JButton btn2 = new JButton("2. Bảng Công Cá Nhân");
        JButton btn3 = new JButton("3. Truy Vết Đơn Hàng");
        JButton btn4 = new JButton("4. Quản Lý Kho FEFO");
        JButton btn5 = new JButton("5. Cảnh Báo Hàng Cận Date");
        JButton btn6 = new JButton("6. Thống Kê Đối Soát ĐVVC");

        JButton[] reportButtons = {btn1, btn2, btn3, btn4, btn5, btn6};
        for (JButton btn : reportButtons) {
            btn.setBackground(Color.WHITE);
            btn.setForeground(new Color(41, 128, 185));
            btn.setFont(new Font("Arial", Font.BOLD, 11));
            btn.setFocusPainted(false);
            panelReports.add(btn);
        }

        // --- HÀNG 2: CHỨC NĂNG ĐIỀU HÀNH & GIÁM SÁT CỦA QUẢN LÝ ---
        JPanel panelActions = new JPanel();
        panelActions.setBackground(new Color(44, 62, 80));
        panelActions.setLayout(new FlowLayout(FlowLayout.CENTER, 15, 10));

        JButton btnGhiNhanLoi = new JButton("⚠️ Ghi Nhận Lỗi Phạt Nhân Viên");
        btnGhiNhanLoi.setBackground(new Color(231, 76, 60)); // Màu đỏ cảnh báo
        btnGhiNhanLoi.setForeground(Color.WHITE);
        btnGhiNhanLoi.setFont(new Font("Arial", Font.BOLD, 11));
        btnGhiNhanLoi.setFocusPainted(false);
        panelActions.add(btnGhiNhanLoi);

        panelTop.add(panelReports);
        panelTop.add(panelActions);
        add(panelTop, BorderLayout.NORTH);

        // --- BẢNG HIỂN THỊ DỮ LIỆU Ở GIỮA ---
        tableModel = new DefaultTableModel();
        table = new JTable(tableModel);
        table.setRowHeight(25);
        table.setFont(new Font("Arial", Font.PLAIN, 12));
        JScrollPane scrollPane = new JScrollPane(table);
        add(scrollPane, BorderLayout.CENTER);

        // =========================================================================
        // GÁN SỰ KIỆN CHO 6 YÊU CẦU TRUY VẤN
        // =========================================================================

        // 1. Tính thu nhập nhân viên
        btn1.addActionListener(e -> loadDataToTable(
            "WITH ThongKeChamCong AS (" +
            "    SELECT MaNV, COUNT(MaCa) AS SoCaDaLam, COUNT(DISTINCT NgayLamViec) AS SoNgayDaLam, SUM(CASE WHEN TrangThai = 'muon' THEN 1 ELSE 0 END) AS SoLanMuon " +
            "    FROM ChamCong WHERE MONTH(NgayLamViec) = 10 AND YEAR(NgayLamViec) = 2026 AND TrangThai IN ('co_mat', 'muon') GROUP BY MaNV" +
            "), ThongKeLoi AS (" +
            "    SELECT MaNV, COUNT(MaLoi) AS SoLoi FROM LoiDongHang WHERE MONTH(NgayGhiNhan) = 10 AND YEAR(NgayGhiNhan) = 2026 GROUP BY MaNV" +
            "), MaxCa AS (" +
            "    SELECT MAX(SoCaDaLam) AS CaMax FROM ThongKeChamCong" +
            ") " +
            "SELECT nv.MaNV, nv.HoTen, COALESCE(cc.SoCaDaLam, 0) AS SoCaDaLam, COALESCE(cc.SoNgayDaLam, 0) AS SoNgayDaLam, " +
            "COALESCE(cc.SoLanMuon, 0) AS SoLanMuon, COALESCE(l.SoLoi, 0) AS SoLoiDongHang, " +
            "(COALESCE(cc.SoCaDaLam, 0) * 108000) AS TienCa, (COALESCE(cc.SoNgayDaLam, 0) * 5000) AS TienGuiXe, " +
            "CASE WHEN cc.SoCaDaLam = (SELECT CaMax FROM MaxCa) THEN 108000 ELSE 0 END AS TienThuong, " +
            "(FLOOR(COALESCE(l.SoLoi, 0)) * 40000) AS TienPhatLoi, (FLOOR(COALESCE(cc.SoLanMuon, 0)) * 20000) AS TienPhatMuon, " +
            "((COALESCE(cc.SoCaDaLam, 0) * 108000) + (COALESCE(cc.SoNgayDaLam, 0) * 5000) + (CASE WHEN cc.SoCaDaLam = (SELECT CaMax FROM MaxCa) THEN 108000 ELSE 0 END) - (FLOOR(COALESCE(l.SoLoi, 0) / 2) * 80000) - (FLOOR(COALESCE(cc.SoLanMuon, 0) / 3) * 40000)) AS TongThuNhap " +
            "FROM NhanVien nv JOIN ThongKeChamCong cc ON nv.MaNV = cc.MaNV LEFT JOIN ThongKeLoi l ON nv.MaNV = l.MaNV;",
            new String[]{"Mã NV", "Họ Tên", "Số Ca", "Số Ngày", "Số Lần Muộn", "Số Lỗi", "Tiền Ca", "Gửi Xe", "Thưởng", "Phạt Lỗi", "Phạt Muộn", "Tổng Thu Nhập"}
        ));

        // 2. Chi tiết bảng công cá nhân
        btn2.addActionListener(e -> {
            String maNV = JOptionPane.showInputDialog(this, "Nhập mã nhân viên cần xem (VD: NV01):", "NV01");
            if (maNV != null && !maNV.trim().isEmpty()) {
                loadDataToTable(
                    "SELECT nv.MaNV, nv.HoTen, cc.NgayLamViec, cl.TenCa, cc.TrangThai, " +
                    "CASE WHEN cc.TrangThai IN ('co_mat', 'muon') THEN 108000 ELSE 0 END AS LuongCa, " +
                    "CASE WHEN cc.TrangThai IN ('co_mat', 'muon') AND cc.MaCa = (SELECT MIN(MaCa) FROM ChamCong WHERE MaNV = cc.MaNV AND NgayLamViec = cc.NgayLamViec AND TrangThai IN ('co_mat', 'muon')) THEN 5000 ELSE 0 END AS TienGuiXe " +
                    "FROM ChamCong cc JOIN NhanVien nv ON cc.MaNV = nv.MaNV JOIN CaLam cl ON cc.MaCa = cl.MaCa " +
                    "WHERE cc.MaNV = '" + maNV.trim() + "' AND MONTH(cc.NgayLamViec) = 10 AND YEAR(cc.NgayLamViec) = 2026 ORDER BY cc.NgayLamViec ASC, cc.MaCa ASC;",
                    new String[]{"Mã NV", "Họ Tên", "Ngày Làm", "Ca Làm", "Trạng Thái", "Lương Ca", "Tiền Gửi Xe"}
                );
            }
        });

        // 3. Truy vết trách nhiệm đơn hàng
        btn3.addActionListener(e -> {
            String maDon = JOptionPane.showInputDialog(this, "Nhập mã đơn hàng cần truy vết (VD: 2):", "2");
            if (maDon != null && !maDon.trim().isEmpty()) {
                loadDataToTable(
                    "SELECT dh.MaDon, dh.ThoiGianDatHang, dh.TrangThaiDon, kh.TenNguoiNhan AS KhachHang, (SELECT GROUP_CONCAT(SDT SEPARATOR ', ') FROM SDT_KhachHang WHERE MaDon = dh.MaDon) AS SdtKhach, kh.DiaChi, " +
                    "dh.NgayLamViec AS NgayDongGoi, cl.TenCa, nv.MaNV AS MaNhanVienDong, nv.HoTen AS NhanVienDong, (SELECT GROUP_CONCAT(SDT SEPARATOR ', ') FROM SDT_NhanVien WHERE MaNV = nv.MaNV) AS SdtNhanVien, " +
                    "GROUP_CONCAT(ldh.LoaiLoi SEPARATOR ', ') AS CacLoiDaGhiNhan " +
                    "FROM DonHang dh JOIN ThongTinKH kh ON dh.MaDon = kh.MaDon LEFT JOIN NhanVien nv ON dh.MaNV = nv.MaNV " +
                    "LEFT JOIN CaLam cl ON dh.MaCa = cl.MaCa LEFT JOIN LoiDongHang ldh ON dh.MaDon = ldh.MaDon " +
                    "WHERE dh.MaDon = " + maDon.trim() + " GROUP BY dh.MaDon, dh.ThoiGianDatHang, dh.TrangThaiDon, kh.TenNguoiNhan, kh.DiaChi, dh.NgayLamViec, cl.TenCa, nv.MaNV, nv.HoTen;",
                    new String[]{"Mã Đơn", "Thời Gian Đặt", "Trạng Thái", "Khách Hàng", "SĐT Khách", "Địa Chỉ", "Ngày Đóng", "Ca Làm", "Mã NV Đóng", "NV Đóng Gói", "SĐT NV", "Các Lỗi"}
                );
            }
        });

        // 4. Quản lý tồn kho theo hạn sử dụng - FEFO
        btn4.addActionListener(e -> loadDataToTable(
            "SELECT LH.MaLo, LH.NgayLap AS NgayNhapKho, HH.MaHang, HH.TenHang, CT.NgaySanXuat, CT.HanSuDung, " +
            "(CT.SoLuong - IFNULL(Xuat.TongXuat, 0)) AS SoLuongTonKho " +
            "FROM HangHoa HH " +
            "JOIN ChiTietLoHang CT ON HH.MaHang = CT.MaHang " +
            "JOIN LoHang LH ON CT.MaLo = LH.MaLo " +
            "LEFT JOIN (SELECT MaHang, MaLo, SUM(SoLuong) AS TongXuat FROM chitietdonhang GROUP BY MaHang, MaLo) Xuat " +
            "ON CT.MaHang = Xuat.MaHang AND CT.MaLo = Xuat.MaLo " +
            "ORDER BY LH.MaLo, LH.NgayLap ASC;",
            new String[]{"Mã Lô", "Ngày Nhập Kho", "Mã Hàng", "Tên Hàng Hóa", "Ngày Sản Xuất", "Hạn Sử Dụng", "Số Lượng Tồn Kho"}
        ));

        // 5. Cảnh báo hàng cận date
        btn5.addActionListener(e -> loadDataToTable(
            "SELECT LH.MaLo, HH.MaHang, HH.TenHang, CT.HanSuDung, " +
            "(CT.SoLuong - IFNULL(Xuat.TongXuat, 0)) AS SoLuongTonKho " +
            "FROM HangHoa HH " +
            "JOIN ChiTietLoHang CT ON HH.MaHang = CT.MaHang " +
            "JOIN LoHang LH ON CT.MaLo = LH.MaLo " +
            "LEFT JOIN (SELECT MaHang, MaLo, SUM(SoLuong) AS TongXuat FROM chitietdonhang GROUP BY MaHang, MaLo) Xuat " +
            "ON CT.MaHang = Xuat.MaHang AND CT.MaLo = Xuat.MaLo " +
            "WHERE CT.HanSuDung > CURDATE() AND CT.HanSuDung < DATE_ADD(CURDATE(), INTERVAL 6 MONTH) " +
            "ORDER BY LH.MaLo ASC;",
            new String[]{"Mã Lô", "Mã Hàng", "Tên Hàng Hóa", "Hạn Sử Dụng", "Số Lượng Tồn Kho"}
        ));

        // 6. Thống kê sản lượng theo đơn vị vận chuyển
        btn6.addActionListener(e -> loadDataToTable(
            "SELECT DVVC.MaDVVC, DVVC.TenDVVC, COUNT(DH.MaDon) AS TongSoDonHang " +
            "FROM DonViVanChuyen DVVC LEFT JOIN DonHang DH ON DVVC.MaDVVC = DH.MaDVVC " +
            "AND DH.ThoiGianBanGiao >= '2026-10-01' AND DH.ThoiGianBanGiao < '2026-11-01' AND DH.TrangThaiDon <> 'da_huy' " +
            "GROUP BY DVVC.MaDVVC, DVVC.TenDVVC ORDER BY TongSoDonHang DESC;",
            new String[]{"Mã ĐVVC", "Tên Đơn Vị Vận Chuyển", "Tổng Số Đơn Hàng"}
        ));


        // =========================================================================
        // CHỨC NĂNG DÀNH RIÊNG CHO QUẢN LÝ: GHI NHẬN LỖI VI PHẠM (TRỪ LƯƠNG)
        // =========================================================================
        btnGhiNhanLoi.addActionListener(e -> {
            JTextField fMaDon = new JTextField(); 
            JTextField fMaNV = new JTextField(); 
            JComboBox<String> cbLoaiLoi = new JComboBox<>(new String[]{"dong_sai", "thieu_hang"});
            JTextField fNgay = new JTextField("2026-10-10");

            Object[] msg = {
                "Mã Đơn Hàng Vi Phạm:", fMaDon,
                "Mã Nhân Viên Phụ Trách:", fMaNV,
                "Loại Lỗi:", cbLoaiLoi,
                "Ngày Ghi Nhận (YYYY-MM-DD):", fNgay
            };

            if (JOptionPane.showConfirmDialog(this, msg, "Quản Lý: Ghi Nhận Lỗi Đóng Hàng", JOptionPane.OK_CANCEL_OPTION) == JOptionPane.OK_OPTION) {
                String sql = "INSERT INTO LoiDongHang (MaDon, MaNV, LoaiLoi, NgayGhiNhan) VALUES (?, ?, ?, ?)";
                try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                     PreparedStatement pst = conn.prepareStatement(sql)) {
                    pst.setInt(1, Integer.parseInt(fMaDon.getText().trim()));
                    pst.setString(2, fMaNV.getText().trim());
                    pst.setString(3, cbLoaiLoi.getSelectedItem().toString());
                    pst.setDate(4, java.sql.Date.valueOf(fNgay.getText().trim()));
                    
                    pst.executeUpdate();
                    JOptionPane.showMessageDialog(this, "Đã ghi nhận lỗi vi phạm thành công! (Sẽ tự động cập nhật vào bảng tính lương)");
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(this, "Lỗi khi ghi nhận: " + ex.getMessage(), "Lỗi", JOptionPane.ERROR_MESSAGE);
                }
            }
        });
    }

    public void loadDataToTable(String query, String[] columnNames) {
        tableModel.setColumnIdentifiers(columnNames);
        tableModel.setRowCount(0);

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            while (rs.next()) {
                Object[] row = new Object[columnCount];
                for (int i = 1; i <= columnCount; i++) {
                    row[i - 1] = rs.getObject(i);
                }
                tableModel.addRow(row);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Lỗi truy vấn SQL: " + ex.getMessage(), "Lỗi Cơ Sở Dữ Liệu", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new KhoMyPhamGUI().setVisible(true);
        });
    }
}