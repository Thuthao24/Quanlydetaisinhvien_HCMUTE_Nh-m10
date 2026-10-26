package com.example.quanlydetaisinhvien.config;

import com.example.quanlydetaisinhvien.security.CustomUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http,
                                             CustomUserDetailsService userDetailsService) throws Exception {
        http
            .userDetailsService(userDetailsService)
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/css/**", "/js/**", "/images/**", "/login", "/403").permitAll()

                .requestMatchers(
                        HttpMethod.GET,
                        "/taikhoan",
                        "/taikhoan/canhan"
                ).authenticated()

                .requestMatchers(
                        "/bomon/**",
                        "/quanly/danhmuc/**"
                ).hasRole("TRUONGKHOA")

                .requestMatchers("/taikhoan/**").denyAll()

                .requestMatchers("/giai-doan-1/**").hasAnyRole("TRUONGKHOA","GIANGVIEN")
                .requestMatchers("/dotdangky/**").hasAnyRole("TRUONGKHOA")
                .requestMatchers("/giangvien/**", "/sinhvien/**").hasRole("TRUONGKHOA")
                .requestMatchers("/detai/**").hasAnyRole("TRUONGKHOA","GIANGVIEN")

                // Duyệt đăng ký đề tài sinh viên
                .requestMatchers(HttpMethod.POST, "/dangkydetai/*/huy").hasRole("SINHVIEN")
                .requestMatchers(HttpMethod.POST, "/dangkydetai/*/duyet").hasAnyRole("TRUONGKHOA", "GIANGVIEN")
                .requestMatchers("/dangkydetai", "/dangkydetai/**").hasAnyRole("SINHVIEN", "TRUONGKHOA", "GIANGVIEN")
                .requestMatchers("/nhom/**", "/nopbaocao/**").hasAnyRole("SINHVIEN","TRUONGKHOA")

                // ==================== CẤU HÌNH PHÂN CÔNG GVPB ====================
                // 1. Giảng viên, Trưởng BM, Trưởng khoa đều được XEM trang phân công
                .requestMatchers(HttpMethod.GET, "/phanbien", "/phanbien/").hasAnyRole("TRUONGKHOA", "GIANGVIEN")
                // 2. Các đường dẫn Thêm / Sửa / Xóa / Lưu (/phanbien/** còn lại) CHỈ dành cho Trưởng Khoa 
                .requestMatchers("/phanbien/**").hasRole("TRUONGKHOA")
                // ==================================================================

                .requestMatchers(HttpMethod.POST, "/hoidong/**").hasRole("TRUONGKHOA")
                .requestMatchers(HttpMethod.POST, "/diem/**").hasAnyRole("TRUONGKHOA", "GIANGVIEN")
                .requestMatchers("/hoidong/**", "/diem/**").hasAnyRole("TRUONGKHOA","GIANGVIEN")

                .requestMatchers("/ketqua/*/congbo", "/ketqua/*/phancong", "/ketqua/email/**").hasRole("TRUONGKHOA")
                .requestMatchers(HttpMethod.GET, "/ketqua", "/ketqua/**").hasAnyRole("SINHVIEN", "TRUONGKHOA")
                .requestMatchers("/ketqua", "/ketqua/**").hasRole("TRUONGKHOA")

                .requestMatchers("/thongbao/create", "/thongbao/*/edit").hasRole("TRUONGKHOA")
                .requestMatchers(HttpMethod.POST, "/thongbao/*/dadoc")
                    .hasAnyRole("SINHVIEN", "GIANGVIEN")
                .requestMatchers(HttpMethod.POST, "/thongbao", "/thongbao/**").hasRole("TRUONGKHOA")
                .requestMatchers(HttpMethod.GET, "/thongbao", "/thongbao/**")
                    .hasAnyRole("TRUONGKHOA", "GIANGVIEN", "SINHVIEN")
                .requestMatchers("/thongbao", "/thongbao/**").denyAll()

                .requestMatchers(HttpMethod.GET, "/morong/timkiem/detai")
                    .hasAnyRole("TRUONGKHOA", "GIANGVIEN")
                .requestMatchers(HttpMethod.GET, "/morong/timkiem/**").authenticated()
                .requestMatchers(HttpMethod.GET, "/morong/thongke").hasRole("TRUONGKHOA")
                .requestMatchers(HttpMethod.GET, "/morong/xuat/detai.xlsx", "/morong/xuat/detai.pdf")
                    .hasAnyRole("TRUONGKHOA", "GIANGVIEN")
                .requestMatchers(HttpMethod.GET, "/morong/xuat/thongke.xlsx", "/morong/xuat/thongke.pdf")
                    .hasRole("TRUONGKHOA")
                .requestMatchers(HttpMethod.GET, "/morong/xuat/**").authenticated()
                .requestMatchers("/morong", "/morong/**").denyAll()

                .requestMatchers("/").authenticated()
                .anyRequest().authenticated()
            )
            .exceptionHandling(ex -> ex.accessDeniedPage("/403"))
            .formLogin(form -> form
                .loginPage("/login")
                .defaultSuccessUrl("/", true)
                .permitAll()
            )
            .logout(logout -> logout
                .logoutSuccessUrl("/login?logout")
                .permitAll()
            );
        return http.build();
    }
}