package com.dit.SystemDB.repository;

import com.dit.SystemDB.model.Log;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
public interface LogRepository extends JpaRepository<Log, Long> {

    @Query(nativeQuery = true, value="SELECT * FROM log_db.function1(:from, :to)")
    List<Object[]> function1(@Param("from") Date from, @Param("to") Date to);

    @Query(nativeQuery = true, value="SELECT * FROM log_db.function2(:from, :to, :type)")
    List<Object[]> function2(@Param("from") Date from, @Param("to") Date to, @Param("type") String type);

    @Query(nativeQuery = true, value="SELECT * FROM log_db.function3(:day )")
    List<Object[]> function3(@Param("day") Date day);
}
