 -- This real-world case is on a Clinic Booking System
--Entities Involved:
-- 1. Patients
-- 2. Doctors
-- 3. Appointments
-- 4. Departments
-- 5. Treatments
-- 6. Prescriptions
-- 7. Medications

-- Relationships
-- a. A Department can have many Doctors (1:M)
-- b. Doctor can have many Appointments (1:M)
-- c. A Patient can have many Appointments (1:M)
-- d. An Appointment can lead to many Prescriptions (1:M)
-- e. A Prescription can include many Medications and each Medication can appear in many prescriptions (M:M)

-- Create a database called clinicdb
CREATE DATABASE clinicdb;

USE clinicdb;

-- Departments Table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Insert into departments
INSERT INTO departments (name) VALUES ('Cardiology'), ('Pediatrics'), ('Orthopedics');

-- Doctors Table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert into doctors
INSERT INTO doctors (name, email, phone, department_id) VALUES
('Dr. Mary Moyo', 'mmoyo@clinic.com', '1234567890', 1),
('Dr. Tim Zulu', 'tzulu@clinic.com', '0987654321', 2);

-- Patients Table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

-- Insert into patients
INSERT INTO patients (name, date_of_birth, gender, email, phone) VALUES
('Sam Gomo', '1990-05-15', 'Male', 'samgomo@gmail.com', '5551112222'),
('Lisa Kamba', '1985-09-10', 'Female', 'lisakamba@gmail.com', '5553334444');

-- Appointments Table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Insert into appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-10 10:00:00', 'Scheduled'),
(2, 2, '2025-05-11 14:30:00', 'Completed');

-- Treatments Table
CREATE TABLE treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    description TEXT,
    treatment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Insert into treatments
INSERT INTO treatments (appointment_id, description) VALUES
(2, 'Routine check-up and consultation');

-- Medications Table
CREATE TABLE medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    dosage VARCHAR(50)
);

-- Insert into medications
INSERT INTO medications (name, dosage) VALUES
('Amoxicillin', '500mg'),
('Ibuprofen', '200mg');

-- Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    notes TEXT,
    date_prescribed DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Insert into prescriptions
INSERT INTO prescriptions (appointment_id, notes) VALUES
(2, 'Take antibiotics for 7 days');

-- Prescription_Medication (Many-to-Many)
CREATE TABLE prescription_medication (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id)
);

-- Insert into prescription_medication
INSERT INTO prescription_medication (prescription_id, medication_id, quantity) VALUES
(1, 1, 14),
(1, 2, 10);

-- Attached in this folder is the Entity-Relationship Diagram (ERD) for the Clinic Booking System. It visualizes the structure of the database, including tables, primary keys, foreign keys, and their relationships.
