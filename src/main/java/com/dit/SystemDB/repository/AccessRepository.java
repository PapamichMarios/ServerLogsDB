package com.dit.SystemDB.repository;

import com.dit.SystemDB.model.AccessLog;
import com.dit.SystemDB.model.Log;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccessRepository extends JpaRepository<AccessLog, Long> {

}
