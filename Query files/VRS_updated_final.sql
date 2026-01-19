create database VRS;
use VRS;
drop database VRS;

 use mydb;
 
-- ========== 1. Customers ==========
create table Customers(
	CustomerID INT primary key auto_increment,
    CustomerName varchar(50) not null check (CustomerName != ''),
    CustomerCNIC varchar(15) unique not null,
    Phone_no varchar(15) not null unique,     
    Email varchar(100) unique,      -- can also be not null but if a prson dont have email id so what will he do
    check(CustomerCNIC regexp "^[0-9]{5}-[0-9]{7}-[0-9]{1}$"),
    check(Phone_no regexp "^[0-9]{4} [0-9]{7}$"),
    check(Email like'%@%.%')
);
desc Customers;


-- ========== 2. Vehicle Types ==========
create table VehicleType(
	TypeId INT primary key auto_increment,
    Vehicle_type varchar(15) not null unique,
    Average_rent decimal(8,2) not null
);
desc VehicleType;


-- ========== 3. Vehicles ==========
create table Vehicles(
	VehicleID INT primary key auto_increment,
    Vehicle_model varchar(50) not null check(Vehicle_model != ""),          -- vehicle name
    Registration_no varchar(15) unique not null,
    TypeId INT not null,
    VehicleStatus ENUM('available', 'rented', 'sold'),
    Price decimal(10, 2) not null,
    check (Registration_no regexp '^[A-Z]{1,3}-[0-9]{1,4}$'),   -- A to Z can be 1 2 or 3 alphabets and space after from 0-9 can be 1 2 3 or 4 numbers
	foreign key (TypeId ) references VehicleType(TypeId) on update cascade
);
alter table Vehicles modify VehicleStatus ENUM('available', 'rented', 'sold', 'not_available') not null;
desc Vehicles;



-- ========== 4. Drivers ==========
create table Drivers (
    DriverID INT primary key auto_increment,
    DriverName varchar(50) not null check((DriverName) != ''),
    CNIC varchar(15) unique not null,
    Phone_no varchar(15) unique not null,
    Email varchar(100) unique,
    LicenseNo varchar(20) unique not null,
    ExperienceYears INT check(ExperienceYears >= 0),
    Availability ENUM('Available', 'Assigned', 'On Leave') not null,
    check (CNIC regexp '^[0-9]{5}-[0-9]{7}-[0-9]{1}$'),
    check (Phone_no regexp '^[0-9]{4} [0-9]{7}$'),
    check (Email like '%@%.%')
);
desc Drivers;


-- ========== 5. Rentals ==========
create table Rentals(     -- vehicles that are on rent
	Rental_id int  primary key auto_increment,
    VehicleID INT not null unique,                       -- if a vehicle is rented i cant be rented again
    CustomerID INT not null,
																--   DriverID Int,              -- may be some are self drive
    rental_date Date not null default(current_date),
    rental_price decimal(10, 2) not null,
    foreign key (VehicleID) references Vehicles(VehicleID) on update cascade,
    foreign key (CustomerID) references Customers(CustomerID) on update cascade
																--  foreign key (DriverID) references Drivers(DriverID) on update cascade
);
desc Rentals;


-- ========== 6. Drivers Assigned for rentals ==========
create table RentalDrivers (
    RentalDriverID int  primary key auto_increment,
    Rental_id INT not null unique,
    DriverID INT not null unique,                   -- if driver assigned it cant be assigned to other vehicle
    AssignedDate DATE not null default(CURRENT_DATE),
    Shift ENUM('Morning', 'Evening', 'Night') DEFAULT 'Morning',
    foreign key (Rental_id) references Rentals(Rental_id) on update cascade on delete cascade,
    foreign key (DriverID) references Drivers(DriverID) on update cascade
);
desc RentalDrivers;

-- ========== 7. Records (Completed Rentals or Sales) ==========
create table Records(
	Record_id int  primary key auto_increment,
    VehicleID INT not null,
    CustomerID INT not null,
	DriverID Int default null,
    record_date Date not null default(current_date),
    return_date Date ,
    price decimal(10, 2) not null,
    Status ENUM('Rented' , 'Sold'),
	foreign key (VehicleID) references Vehicles(VehicleID) on update cascade on delete cascade,
    foreign key (CustomerID) references Customers(CustomerID) on update cascade on delete cascade,
    foreign key (DriverID) references Drivers(DriverID) on update cascade on delete set null
);
alter table Records modify Status ENUM('Rented' , 'Sold') not null;
desc Records;


-- ========== 8. History Table (keep records all transactions in past and present too) ==========
create table History (
    HistoryID INT primary key auto_increment,
    CustomerName varchar(50),
    CustomerCNIC varchar(15),
    Vehicle_model varchar(50),
    Registration_no varchar(15),
    DriverName varchar(50),
    record_date date not null,    -- DEFAULT (CURRENT_DATE)
    return_date date,
    price DECIMAL(10,2) not null,
    Status ENUM('Rented', 'Sold') not null
);
desc history;


INSERT INTO History (                 -- if i insert id then after deleting record its id will remain same in this table but in actual table on that id there will be other row
    CustomerName, CustomerCNIC, Vehicle_model, Registration_no, DriverName, 
    record_date, return_date, price, Status
)
SELECT 
    C.CustomerName, C.CustomerCNIC,
    V.Vehicle_model, V.Registration_no,
    D.DriverName,
    R.record_date, R.return_date, R.price, R.Status
FROM Records R
JOIN Customers C ON R.CustomerID = C.CustomerID
JOIN Vehicles V ON R.VehicleID = V.VehicleID
LEFT JOIN Drivers D ON R.DriverID = D.DriverID
WHERE NOT EXISTS (
    SELECT 1 FROM History H 
    WHERE H.CustomerCNIC = C.CustomerCNIC 
      AND H.Registration_no = V.Registration_no 
      AND H.record_date = R.record_date
);




INSERT INTO Customers (CustomerName, CustomerCNIC, Phone_no, Email) VALUES
('Ahmed Khan', '42101-1234567-1', '0300 1234567', 'ahmed.khan@example.com'),
('Sara Malik', '35202-7654321-9', '0312 7654321', 'sara.malik@example.com'),
('Zain Ali', '61101-3344556-4', '0321 3344556', 'zain.ali@example.com'),
('Hina Shah', '42201-2233445-2', '0301 2233445', 'hina.shah@example.com'),
('Talha Rizvi', '33102-9988776-6', '0345 9988776', 'talha.rizvi@example.com');

INSERT INTO VehicleType (Vehicle_type, Average_rent) VALUES
('Sedan', 4000),
('SUV', 5000),
('Hatchback', 3000),
('Bike', 2000),
('Van', 3500);

INSERT INTO Vehicles (Vehicle_model, Registration_no, TypeId, VehicleStatus, Price) VALUES
('Toyota Corolla', 'ABC-1234', 1, 'available', 2500000),
('Honda Civic', 'DEF-5678', 1, 'rented', 2800000),
('Suzuki Alto', 'GHI-4321', 3, 'sold', 1600000),
('KIA Sportage', 'JKL-8765', 2, 'available', 5500000),
('Yamaha YBR 125', 'MNO-999', 4, 'rented', 300000),
('Kawasaki Ninja H2R', 'KNH-2424', 4, 'available', 800000),
('Hyundai Elantra', 'HYN-1122', 1, 'available', 2700000),
('Toyota Fortuner', 'TYF-8899', 2, 'available', 9000000),
('Suzuki Wagon R', 'SWG-3344', 3, 'available', 1800000),
('Honda BR-V', 'HBR-5566', 2, 'available', 4300000),
('Yamaha MT-15', 'YMT-777', 4, 'available', 450000),
('Honda CD 70', 'HCD-888', 4, 'available', 150000),
('Suzuki Cultus', 'SCL-1212', 3, 'available', 2000000),
('Kawasaki Z1000', 'KZ1-9090', 4, 'available', 1200000),
('Nissan Dayz', 'NSD-6543', 3, 'available', 1700000),
('Changan Karvaan', 'CHK-8888', 5, 'available', 2100000),
('Toyota Hiace', 'THC-2222', 5, 'available', 3800000),
('Honda Vezel', 'HVZ-3434', 1, 'available', 4700000);



SELECT 
    CONSTRAINT_NAME,
    CHECK_CLAUSE
FROM information_schema.CHECK_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'vehicles_chk_2';



INSERT INTO Drivers (DriverName, CNIC, Phone_no, Email, LicenseNo, ExperienceYears, Availability) VALUES
('Imran Shaikh', '42101-1122334-5', '0300 1122334', 'imran.shaikh@example.com', 'LIC12345', 5, 'Available'),
('Adeel Qureshi', '35202-2233445-7', '0301 2233445', 'adeel.q@example.com', 'LIC67890', 3, 'Assigned'),
('Farhan Aziz', '61101-3344556-2', '0321 3344556', 'farhan.aziz@example.com', 'LIC11122', 7, 'Available');


INSERT INTO Rentals (Rental_id, VehicleID, CustomerID, rental_date, rental_price) VALUES
(1, 25, 1, '2025-05-10', 15000),
(2, 28, 2, '2025-05-11', 3500);

INSERT INTO RentalDrivers (Rental_id, DriverID) VALUES 
(2, 1);

INSERT INTO Records (VehicleID, CustomerID, DriverID, record_date, return_date, price, Status) VALUES
(26, 2, NULL, '2025-03-10', NULL, 1600000, 'Sold'),
(29, 1, 1, '2025-04-01', '2025-04-05', 15000, 'Rented'),
(25, 1, Null, '2025-05-10', NULL, 15000, 'Rented'),
(28, 2, 1, '2025-05-11', Null, 3500, 'Rented');

delete from Records where Record_id = 3;


SELECT * FROM Customers;
SELECT * FROM Vehicles;
SELECT * FROM VehicleType;
SELECT * FROM Rentals;
select * from RentalDrivers;
SELECT * FROM Records;
SELECT * FROM Drivers;
select * from History;


