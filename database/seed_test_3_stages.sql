-- DỮ LIỆU MẪU CHUẨN ĐỂ TEST ĐẦY ĐỦ 3 GIAI ĐOẠN
-- 1. Giảng viên đề xuất đề tài
-- 2. Sinh viên đăng ký nhóm & đề tài
-- 3. Giảng viên được phân công chấm điểm

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ========================================================
-- GIAI ĐOẠN 1: Tạo Đợt 10 ở trạng thái GIAIDOAN1 (đang mở)
-- Dành cho Giảng viên (gv001 / GV001) vào đề xuất đề tài mới
-- ========================================================
INSERT INTO Dotdangky (Id, Tendot, Loaidot, Batdaugiangvien, Ketthucgiangvien, Batdausinhvien, Ketthucsinhvien, Hanchamphanbien, Ngaybaocaohoidong, Trangthai)
VALUES (10, 'Đợt 1 - Khóa luận tốt nghiệp 2026-2027 (Test Đề xuất đề tài)', 'KLTN', 
        '2026-10-01 00:00:00', '2026-12-31 23:59:59', 
        '2026-11-01 00:00:00', '2026-12-31 23:59:59', 
        '2027-01-10 17:00:00', '2027-01-15 08:00:00', 'GIAIDOAN1')
ON DUPLICATE KEY UPDATE 
    Tendot = VALUES(Tendot),
    Batdaugiangvien = VALUES(Batdaugiangvien),
    Ketthucgiangvien = VALUES(Ketthucgiangvien),
    Trangthai = 'GIAIDOAN1';

-- ========================================================
-- GIAI ĐOẠN 2 & 3: Tạo Đợt 11 ở trạng thái GIAIDOAN2 (đang mở cho SV đăng ký)
-- ========================================================
INSERT INTO Dotdangky (Id, Tendot, Loaidot, Batdaugiangvien, Ketthucgiangvien, Batdausinhvien, Ketthucsinhvien, Hanchamphanbien, Ngaybaocaohoidong, Trangthai)
VALUES (11, 'Đợt 2 - Khóa luận tốt nghiệp 2026-2027 (Test Đăng ký & Chấm điểm)', 'KLTN', 
        '2026-10-01 00:00:00', '2026-10-20 23:59:59', 
        '2026-10-01 00:00:00', '2026-12-31 23:59:59', 
        '2027-01-10 17:00:00', '2027-01-15 08:00:00', 'GIAIDOAN2')
ON DUPLICATE KEY UPDATE 
    Tendot = VALUES(Tendot),
    Batdausinhvien = VALUES(Batdausinhvien),
    Ketthucsinhvien = VALUES(Ketthucsinhvien),
    Trangthai = 'GIAIDOAN2';

-- Đề tài mẫu đã công bố (CONGBO) trong Đợt 11 để Sinh viên 23110001 & 23110002 đăng ký
INSERT INTO Detai (Id, Dotdangkyid, Bomonid, Tendetai, Mota, Giangviendexuatid, Trangthai)
VALUES (60, 11, 1, 'Ứng dụng AI và Blockchain trong quản lý văn bằng chứng chỉ số', 
        'Nghiên cứu ứng dụng công nghệ trí tuệ nhân tạo (AI) kết hợp mạng khối (Blockchain) để xác thực và cấp phát văn bằng tốt nghiệp không thể làm giả cho sinh viên.',
        2, 'CONGBO')
ON DUPLICATE KEY UPDATE 
    Tendetai = VALUES(Tendetai),
    Dotdangkyid = 11,
    Trangthai = 'CONGBO';

INSERT IGNORE INTO Giangvienhuongdan (Detaiid, Giangvienid) VALUES (60, 2);

-- ========================================================
-- GIAI ĐOẠN 3: Đề tài #61 đã duyệt, đã có nhóm, đã nộp báo cáo và phân công chấm điểm
-- ========================================================
INSERT INTO Detai (Id, Dotdangkyid, Bomonid, Tendetai, Mota, Giangviendexuatid, Trangthai)
VALUES (61, 11, 1, 'Hệ thống tự động chấm điểm và đánh giá mã nguồn sinh viên trực tuyến', 
        'Xây dựng nền tảng Auto-grader tích hợp sandbox kiểm thử tự động, phát hiện gian lận và tối ưu hiệu năng thuật toán.',
        2, 'CONGBO')
ON DUPLICATE KEY UPDATE 
    Tendetai = VALUES(Tendetai),
    Dotdangkyid = 11,
    Trangthai = 'CONGBO';

INSERT IGNORE INTO Giangvienhuongdan (Detaiid, Giangvienid) VALUES (61, 2);

-- Nhóm sinh viên đã có sẵn: Nhóm trưởng SV #3 (23110003 - Lê Nhật My)
INSERT INTO Nhomsinhvien (Id, Dotdangkyid, Tennhom, Nhomtruongid)
VALUES (10, 11, 'Nhóm Khởi Nghiệp Công Nghệ', 3)
ON DUPLICATE KEY UPDATE Tennhom = VALUES(Tennhom);

INSERT IGNORE INTO Thanhviennhom (Nhomid, Sinhvienid) VALUES (10, 3), (10, 4);

-- Đăng ký đề tài đã được duyệt (DADUYET)
INSERT INTO Dangkydetai (Id, Nhomid, Detaiid, Trangthai, Ngaydangky)
VALUES (10, 10, 61, 'DADUYET', NOW())
ON DUPLICATE KEY UPDATE Detaiid = 61, Trangthai = 'DADUYET';

-- Đã nộp báo cáo
INSERT INTO Nopbaocao (Id, Dangkydetaiid, Sinhvienid, Duongdanfile, Ngaynop)
VALUES (10, 10, 3, 'https://github.com/Thuthao24/HeThongQLDTSV_CNTT/blob/main/baocao_kltn.pdf', NOW())
ON DUPLICATE KEY UPDATE Duongdanfile = VALUES(Duongdanfile);

-- PHÂN CÔNG PHẢN BIỆN: ThS Đỗ Quốc Khánh (GV006 / GiangvienId = 7)
INSERT INTO Giangvienphanbien (Id, Dangkydetaiid, Giangvienid)
VALUES (10, 10, 7)
ON DUPLICATE KEY UPDATE Giangvienid = 7;

-- HỘI ĐỒNG ĐÁNH GIÁ (3 thành viên hợp lệ quy chế: 1 Chủ tịch, 1 Thư ký, 1 Thành viên)
INSERT INTO Hoidong (Id, Dotdangkyid, Tenhoidong, Ngaybaocao, Phong)
VALUES (10, 11, 'Hội đồng đánh giá KLTN - Tiểu ban 01', '2026-11-15 08:30:00', 'Phòng A1-205')
ON DUPLICATE KEY UPDATE Dotdangkyid = 11, Tenhoidong = VALUES(Tenhoidong);

DELETE FROM Thanhvienhoidong WHERE Hoidongid = 10;
INSERT INTO Thanhvienhoidong (Hoidongid, Giangvienid, Vaitro)
VALUES 
    (10, 3, 'CHUTICH'),    -- TS Lê Hoàng Nam (GV002)
    (10, 7, 'THUKY'),      -- ThS Đỗ Quốc Khánh (GV006)
    (10, 11, 'THANHVIEN'); -- TS Nguyễn Đức Long (GV010)

-- PHÂN CÔNG HỘI ĐỒNG CHO ĐĂNG KÝ ĐỀ TÀI
INSERT INTO Phanconghoidong (Dangkydetaiid, Hinhthuc, Hoidongid)
VALUES (10, 'COHOIDONG', 10)
ON DUPLICATE KEY UPDATE Hinhthuc = 'COHOIDONG', Hoidongid = 10;

-- Xóa điểm cũ của đăng ký 10 để sẵn sàng test nhập điểm mới
DELETE FROM Diem WHERE Dangkydetaiid = 10;

-- Tạo bản ghi Ketqua trung gian sẵn sàng nhận điểm
INSERT INTO Ketqua (Dangkydetaiid, Diemcuoi, Dacongbo)
VALUES (10, NULL, 0)
ON DUPLICATE KEY UPDATE Dacongbo = 0, Diemcuoi = NULL;

SET FOREIGN_KEY_CHECKS = 1;
