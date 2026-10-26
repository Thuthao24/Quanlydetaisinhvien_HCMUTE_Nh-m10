-- =========================================================================
-- QUERY ĐỐI CHIẾU: KIỂM TRA ĐIỂM CUỐI (DIEMCUOI) KHỚP DỮ LIỆU THÀNH PHẦN
-- Task 14 - Hữu Lộc: Chấm điểm + Kết quả trung gian
-- =========================================================================

-- 1. Query đối chiếu chi tiết từng đề tài đăng ký
SELECT 
    k.Id AS KetQuaId,
    k.Dangkydetaiid,
    dt.Tendetai AS TenDeTai,
    ns.Tennhom AS TenNhomSinhVien,
    COUNT(d.Id) AS SoLuongDiemThanhPhan,
    ROUND(AVG(d.Diemso), 2) AS DiemTrungBinhThanhPhan,
    k.Diemcuoi AS DiemCuoiDaLuu,
    CASE 
        WHEN k.Diemcuoi = ROUND(AVG(d.Diemso), 2) THEN '✓ KHỚP DỮ LIỆU'
        ELSE '⚠ LỆCH DỮ LIỆU'
    END AS TrangThaiDoiChieu,
    CASE 
        WHEN k.Dacongbo = 1 THEN 'Đã công bố'
        ELSE 'Chưa công bố (Trung gian)'
    END AS TrangThaiCongBo
FROM Ketqua k
JOIN Dangkydetai dk ON k.Dangkydetaiid = dk.Id
JOIN Detai dt ON dk.Detaiid = dt.Id
JOIN Nhomsinhvien ns ON dk.Nhomid = ns.Id
JOIN Diem d ON k.Dangkydetaiid = d.Dangkydetaiid
GROUP BY k.Id, k.Dangkydetaiid, dt.Tendetai, ns.Tennhom, k.Diemcuoi, k.Dacongbo
ORDER BY k.Dangkydetaiid ASC;

-- 2. Query kiểm tra nhanh: Tìm các đề tài bị lệch dữ liệu (nếu có)
-- Nếu query này trả về 0 dòng -> Tất cả dữ liệu điểm cuối đều khớp 100%!
SELECT 
    k.Id,
    k.Dangkydetaiid,
    k.Diemcuoi,
    ROUND(AVG(d.Diemso), 2) AS DiemTBThucTe,
    ABS(k.Diemcuoi - ROUND(AVG(d.Diemso), 2)) AS DoLech
FROM Ketqua k
JOIN Diem d ON k.Dangkydetaiid = d.Dangkydetaiid
GROUP BY k.Id, k.Dangkydetaiid, k.Diemcuoi
HAVING k.Diemcuoi != ROUND(AVG(d.Diemso), 2);
