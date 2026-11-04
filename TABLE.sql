create database if not exists quan_ly_kho_my_pham;
use quan_ly_kho_my_pham;

create table NhanVien(
    MaNV varchar(20) primary key,
    HoTen varchar(100) not null,
    NgaySinh date not null,
    QueQuan varchar(255),
    CCCD varchar(12) not null unique,
    DiaChiTamTru varchar(255) not null,
    SoTaiKhoan varchar(40) not null,
    ChucVu enum('quan_ly','nhan_vien') not null default 'nhan_vien'
);

create table SDT_NhanVien(
    MaNV varchar(20) not null,
    SDT varchar(15) not null unique,
    primary key (MaNV, SDT),
    foreign key (MaNV) references NhanVien(MaNV)
);

create table DonViVanChuyen(
    MaDVVC varchar(20) primary key,
    TenDVVC varchar(100) not null
);

create table CaLam(
	MaCa varchar(20) primary key,
    TenCa enum('sang','chieu') not null,
    Sogio tinyint unsigned not null
);

create table HangHoa (
    MaHang varchar(20) primary key,
    TenHang varchar(150) not null,
    DonViTinh varchar(30) not null
);

create table LichLamViec(
    NgayLamViec date not null,
    MaNV varchar(20) not null,
    MaCa varchar(20) not null,
    MaDVVC varchar(20) not null,
    primary key (NgayLamViec, MaNV, MaCa),
    foreign key (MaNV) references NhanVien(MaNV),
    foreign key (MaCa) references CaLam(MaCa),
    foreign key (MaDVVC) references DonViVanChuyen(MaDVVC)
);

create table ChamCong(
   MaNV varchar(20) not null,
   MaCa varchar(20) not null,
   NgayLamViec date not null,
   TrangThai enum('co_mat','vang','muon') not null,
   primary key (NgayLamViec, MaNV, MaCa),
   foreign key (NgayLamViec, MaNV, MaCa) references LichLamViec(NgayLamViec, MaNV, MaCa)
);

create table LoHang (
    MaLo int primary key auto_increment,
    NgayLap datetime not null default current_timestamp,
    MaNV varchar(20) not null,
    foreign key (MaNV) references NhanVien(MaNV)
);

create table ChiTietLoHang (
    MaLo int not null,
    MaHang varchar(20) not null,
    SoLuong int not null,
    NgaySanXuat date not null,
    HanSuDung date not null,
    primary key(MaLo, MaHang),
    foreign key (MaLo) references LoHang(MaLo),
    foreign key (MaHang) references HangHoa(MaHang)
);

create table DonHang(
	MaDon int primary key auto_increment,
    ThoiGianDatHang datetime not null default current_timestamp,
    TrangThaiDon enum('da_xac_nhan','dang_dong_hang','cho_giao_hang','dang_giao_hang','da_nhan','da_huy','dang_hoan','da_hoan') not null default 'da_xac_nhan',
    NgayLamViec date,
    MaNV varchar(20),
    MaCa varchar(20),
    MaDVVC varchar(20) not null,
    ThoiGianBanGiao datetime,
    foreign key (NgayLamViec, MaNV, MaCa) references LichLamViec(NgayLamViec, MaNV, MaCa),
    foreign key (MaDVVC) references DonViVanChuyen(MaDVVC)
);

create table ThongTinKH(
	MaDon int primary key,
    TenNguoiNhan varchar(100) not null,
    DiaChi varchar(255) not null,
    foreign key (MaDon) references DonHang(MaDon)
);

create table SDT_KhachHang(
    MaDon int not null,
    SDT varchar(15) not null,
    primary key (MaDon, SDT),
    foreign key (MaDon) references ThongTinKH(MaDon)
);

create table ChiTietDonHang (
    MaDon int not null,
    MaLo int not null,
    MaHang varchar(20) not null,
    SoLuong int not null,
    primary key (MaDon, MaLo, MaHang),
    foreign key (MaDon) references DonHang(MaDon) ,
    foreign key (MaLo, MaHang) references ChiTietLoHang(MaLo, MaHang)
);

create table LoiDongHang (
    MaLoi int primary key auto_increment,
    MaDon int not null,
    MaNV varchar(20) not null,
    LoaiLoi enum('dong_sai','thieu_hang'),
    NgayGhiNhan date not null,
    foreign key (MaDon) references DonHang(MaDon),
    foreign key (MaNV) references NhanVien(MaNV)
);

