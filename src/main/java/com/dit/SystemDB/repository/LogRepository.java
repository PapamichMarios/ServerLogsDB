package com.dit.SystemDB.repository;

import com.dit.SystemDB.model.Log;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface LogRepository extends JpaRepository<Log, Long> {

    @Procedure(name="function1")
    List<Log> function1(@Param("time1") Date time1, @Param("time2") Date time2);
}
