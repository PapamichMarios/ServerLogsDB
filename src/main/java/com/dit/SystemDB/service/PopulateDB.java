package com.dit.SystemDB.service;

import com.dit.SystemDB.model.Role;
import com.dit.SystemDB.model.RoleName;
import com.dit.SystemDB.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PopulateDB {

    @Autowired
    private RoleRepository roleRepository;

    private static final long FIRST_ID = 1;

    public void populateStaticRoles() {
        if (roleRepository.findById(FIRST_ID).orElse(null) != null) return;
        roleRepository.save(new Role(RoleName.ROLE_ADMIN));
        roleRepository.save(new Role(RoleName.ROLE_USER));
    }

    public void populateTableWithCSV() {
        //todo later
    }
}
