package com.example.quanlydetaisinhvien.repository;

import com.example.quanlydetaisinhvien.entity.Nopbaocao;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NopbaocaoRepository extends JpaRepository<Nopbaocao, Long> {

    List<Nopbaocao> findByDangkydetaiid(Long dangkydetaiid);
    List<Nopbaocao> findByDangkydetaiidIn(java.util.Collection<Long> dangkyids);
    java.util.Optional<Nopbaocao> findFirstByDangkydetaiidOrderByIdDesc(Long dangkydetaiid);
    List<Nopbaocao> findBySinhvienid(Long sinhvienid);
    boolean existsByDangkydetaiid(Long dangkydetaiid);
    void deleteByDangkydetaiid(Long dangkydetaiid);

    boolean existsByDuongdanfileAndDangkydetaiidNot(String duongdanfile, Long dangkydetaiid);
    long countByDuongdanfile(String duongdanfile);

    @org.springframework.data.jpa.repository.Query("SELECT n.duongdanfile FROM Nopbaocao n WHERE n.dangkydetaiid <> :currentDkId AND n.duongdanfile IS NOT NULL")
    List<String> findOtherDuongdanfiles(@org.springframework.data.repository.query.Param("currentDkId") Long currentDkId);

    @org.springframework.data.jpa.repository.Query("SELECT n.duongdanfile FROM Nopbaocao n WHERE n.duongdanfile IS NOT NULL")
    List<String> findAllDuongdanfiles();
}