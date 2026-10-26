# Deploy sườn Spring Boot

Project đã được chuẩn bị để deploy bằng biến môi trường.

## Biến môi trường cần có

- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`
- `PORT` (nền tảng thường tự cấp)

Ví dụ `DB_URL`:

```text
jdbc:mysql://HOST:3306/Quanlydetaisinhvien?useSSL=true&serverTimezone=Asia/Ho_Chi_Minh&useUnicode=true&characterEncoding=UTF-8
```

## Lưu ý quan trọng

Database `localhost` trên máy của bạn KHÔNG dùng trực tiếp được khi deploy.
Cần tạo MySQL trên cloud, import `database/Quanlydetaisinhvien.sql`, rồi cấu hình 3 biến DB ở trên.

## Docker

Project có `Dockerfile` dùng Java 26 để tránh nền tảng tự chọn sai phiên bản Java.

Build local:

```bash
docker build -t quanlydetaisinhvien .
docker run -p 8080:8080   -e DB_URL="jdbc:mysql://..."   -e DB_USERNAME="..."   -e DB_PASSWORD="..."   quanlydetaisinhvien
```

## Trạng thái hiện tại

Có thể deploy để kiểm tra:
- Spring Boot chạy.
- Login.
- Dashboard.
- Danh sách các module.
- Kết nối database cloud.

Nhưng đây vẫn là sườn: nút Thêm mới/Sửa/Xóa chưa mở chức năng thật.
Nên hoàn thiện CRUD và nghiệp vụ chính trước khi dùng bản deploy làm sản phẩm nộp cuối cùng.
