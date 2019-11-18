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

    @Query(nativeQuery = true, value="SELECT time_stamp, total FROM log_db.function1(:time1, :time2)")
    List<Log> function1(@Param("time1") Date time1, @Param("time2") Date time2);
}
