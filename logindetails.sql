reate database logindetails;
use logindetails;
CREATE TABLE admin (
    id INT AUTO_INCREMENT,
    name VARCHAR(20),
    email VARCHAR(100),
    password VARCHAR(30),
    gender VARCHAR(20),
    age INT,
    status INT,
    PRIMARY KEY (id, email)
);