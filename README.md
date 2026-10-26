# Sườn toàn bộ đồ án — Hệ thống quản lý đề tài sinh viên

## Công nghệ
- Java 26
- Spring Boot 4.1.1
- Spring MVC
- Spring Data JPA
- Spring Security + BCrypt
- Thymeleaf
- MySQL 8+
- Tomcat nhúng của Spring Boot
- Maven

## Kiến trúc 3 tầng
`Controller -> Service -> Repository -> MySQL`

## Module đã dựng sườn
1. Tài khoản + phân quyền
2. Bộ môn
3. Giảng viên
4. Sinh viên
5. Đợt đăng ký
6. Đề tài
7. GV hướng dẫn
8. Nhóm sinh viên
9. Thành viên nhóm
10. Đăng ký đề tài
11. Nộp báo cáo
12. Hội đồng
13. Thành viên hội đồng
14. GV phản biện
15. Điểm
16. Kết quả
17. Thông báo

## Nghiệp vụ cốt lõi đã đặt sườn trong NghiepvuDetaiService
- Giai đoạn 1: GV đề xuất đề tài -> duyệt -> công bố.
- Giai đoạn 2: nhóm SV đăng ký đề tài đã công bố.
- Nhóm 1-3 SV.
- Mỗi nhóm chỉ đăng ký 1 đề tài.
- Đề tài phải có 1-2 GVHD trước khi công bố.
- Chỉ nhóm trưởng được nộp báo cáo.
- Điểm cuối = trung bình cộng các điểm thành phần.
- Công bố kết quả.

## Chạy project
1. Import `database/Quanlydetaisinhvien.sql` vào MySQL.
2. Sửa `src/main/resources/application.properties` nếu MySQL có mật khẩu:
   `spring.datasource.password=...`
3. Mở terminal tại thư mục project.
4. Chạy:
   `mvn spring-boot:run`
5. Mở:
   `http://localhost:8080`

## Tài khoản mẫu trong SQL
- dean / Abc@12345
- gv001 / Abc@12345
- gv002 / Abc@12345
- gv003 / Abc@12345
- 23110001 / Abc@12345
- 23110002 / Abc@12345
- 23110003 / Abc@12345

## Việc tiếp theo
Sườn này cố tình chưa viết đầy đủ CRUD giao diện để nhóm có thể chia module cho 5 thành viên. Tiếp theo nên hoàn thiện theo thứ tự:
1. Login + role.
2. CRUD tài khoản/GV/SV/bộ môn.
3. CRUD đợt đăng ký.
4. Quy trình đề tài GĐ1.
5. Nhóm SV + đăng ký đề tài GĐ2.
6. Nộp báo cáo.
7. GVPB + hội đồng + điểm.
8. Công bố kết quả.
9. Thông báo.
10. Test + deploy.


## Du lieu mau da bo sung
Database hien co:
- 4 bo mon
- 12 giang vien/tai khoan giang vien
- 60 sinh vien
- 6 dot dang ky
- 24 de tai
- 20 nhom sinh vien
- 60 thanh vien nhom
- 20 dang ky de tai
- 20 bao cao
- 8 hoi dong
- 24 thanh vien hoi dong
- 20 GV phan bien
- 60 diem thanh phan
- 20 ket qua
- 10 thong bao

Mat khau demo chung: `Abc@12345`


## UI/UX đã bổ sung
- Dashboard tổng quan có số liệu thật từ database.
- Sidebar điều hướng toàn hệ thống.
- Topbar người dùng + đăng xuất.
- Login responsive.
- Danh sách riêng cho 12 module.
- Tìm kiếm nhanh dữ liệu ngay trên bảng.
- Trạng thái/badge trực quan.
- Trang 403 khi truy cập sai quyền.
- Responsive cho desktop/tablet/mobile.

## Deploy
Project đã có `Dockerfile`, `DEPLOY.md` và cấu hình biến môi trường cho database cloud.


## Giao diện HCMUTE style
- Toàn bộ UI đã đổi sang tone xanh HCMUTE, xám nhạt và thẻ trắng theo mẫu người dùng cung cấp.
- Login, dashboard, sidebar, bảng dữ liệu, trạng thái, 403/error đều đồng bộ.
- Asset `hcmute-logo.png` được tạo từ hình tham chiếu người dùng cung cấp.


## Cap nhat UI portal + dang nhap MSSV
- Toan bo giao dien ben trong da doi sang bo cuc giong cong thong tin HCMUTE: sidebar xanh, logo/profile o trai, topbar xanh, nen xam, bang header xanh.
- Da xoa khoi dashboard: `Quan ly de tai sinh vien` va day 5 buoc o phia tren.
- Sinh vien dang nhap bang `Masinhvien` (vi du `23110001`).
- Mat khau demo chung: `Abc@12345`.
- Neu database cu da co du lieu, chay `database/Capnhatdangnhap_masinhvien.sql` thay vi import lai toan bo database.
