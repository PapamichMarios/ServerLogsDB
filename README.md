# ServerLogs
Project for Post-Graduate class Database Management Systems

# Authors
- [Papadopoulos Christos](https://github.com/Christosc96)
- [Papamichalopoulos Marios](https://github.com/PapamichMarios)

# Tools Used
- Spring Boot 
- React
- PostgresSQL 11.6
- IntelliJ IDEA
- Webpack
- Various NPM dependencies (package.json)

# How to run
- Import project as Maven project in IntelliJ
- Extract the ```logs.tar.gz``` from the ```logs``` directory
- Use the python script ```csv_parser.py``` within the directory to parse the logs to CSV format.
- Import CSV files using pgAdmin 4.
- Run in the project folder the commands: 

```
sudo npm install
sudo npm run build
```

- Start from IntelliJ and you should be able to browse it from:
```
https://localhost:8080/
```

# Final Schema

# Functions

# Sample Snapshots

- Homepage
![alt text](Wiki%20Photos/homepage.png "Homepage")

- Sign Up
![alt text](Wiki%20Photos/signup.png "Sign Up")

- Log In
![alt text](Wiki%20Photos/login.png "Log In")
![alt text](Wiki%20Photos/homepage_logged.png "Homepage Logged In")

- Insert any type of Log
![alt text](Wiki%20Photos/insert_log.png "Insert Log")
![alt text](Wiki%20Photos/insertion_example.png "Example of Insert")

- Execute server procedures
![alt text](Wiki%20Photos/procedure1_before.png "Procedure 1 Before Results")
![alt text](Wiki%20Photos/procedure1_after.png "Procedure 1 After Results")

# Github Link
[ServerLogs](https://github.com/PapamichMarios/ServerLogs)