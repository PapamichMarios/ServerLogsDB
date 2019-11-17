package com.dit.SystemDB;

import com.dit.SystemDB.service.PopulateDB;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Component;

@SpringBootApplication
public class SystemDbApplication {

	public static void main(String[] args) {
		SpringApplication.run(SystemDbApplication.class, args);
	}

	@Component
	public class CommandLineAppStartupRunner implements CommandLineRunner {

		@Autowired
		private PopulateDB populateDB;

		@Override
		public void run(String... args) throws Exception {

			populateDB.populateStaticRoles();
		}
	}
}
