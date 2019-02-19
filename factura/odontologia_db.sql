CREATE DATABASE IF NOT EXISTS odontologia_db;
USE odontologia_db;

CREATE TABLE IF NOT EXISTS user_types(
id INT AUTO_INCREMENT,
name VARCHAR(100),
CONSTRAINT pk_user_types PRIMARY KEY(id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS users(
id INT(255) AUTO_INCREMENT,
user_type_id INT,
name VARCHAR(100) NOT NULL,
surname VARCHAR(100) NOT NULL,
nick VARCHAR(100) NOT NULL,
rfc  VARCHAR(200) NOT NULL,
password VARCHAR(255) NOT NULL,
professional_license VARCHAR(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
remember_token    VARCHAR(255),
CONSTRAINT pk_users_id PRIMARY KEY(id),
CONSTRAINT fk_users_user_types FOREIGN KEY(user_type_id) REFERENCES user_types(id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT uq_rfc_user UNIQUE(rfc)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS patients(
id INT(255) AUTO_INCREMENT NOT NULL,
name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
second_last_name VARCHAR(100) NOT NULL,
rfc VARCHAR(200) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_patients PRIMARY KEY(id),
CONSTRAINT uq_rfc_patient UNIQUE(rfc)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS services(
 id  INT(255) NOT NULL,
name VARCHAR(100) NOT NULL,
description TEXT NOT NULL,
price FLOAT(30,2), 
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_services PRIMARY KEY(id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS bills(
id INT(255) AUTO_INCREMENT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_bills PRIMARY KEY(id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payment_receipts(
id INT(255) AUTO_INCREMENT,
user_id INT(255),
patient_id INT(255),
bill_id INT(255),
total  FLOAT(40,2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_payment_receipts PRIMARY KEY(id),
CONSTRAINT fk_payment_receipts_user FOREIGN KEY(user_id) REFERENCES users(id),
CONSTRAINT fk_payment_receipts_patient FOREIGN KEY(patient_id) REFERENCES patients(id),
CONSTRAINT fk_payment_receipts_bill  FOREIGN KEY(bill_id) REFERENCES bills(id)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payment_receipt_services(
id INT(255) AUTO_INCREMENT,
service_id  INT(255),
payment_receipt_id INT(255),
price FLOAT(20,2),
quantity INT(234),
total FLOAT(20,2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_payment_receipt_services PRIMARY KEY(id),
CONSTRAINT fk_payment_receipt_services_services FOREIGN KEY(service_id) REFERENCES services(id),
CONSTRAINT fk_payment_receipt_services_payment_receipt FOREIGN KEY(payment_receipt_id) REFERENCES payment_receipts(id)
)ENGINE=InnoDB;

