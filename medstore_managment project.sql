-- Create database
CREATE DATABASE medical_store;
USE medical_store;

-- Table: Company
create table Company (
    companyid int primary key auto_increment,
    companyname varchar(30) not null,
    location varchar(50),
    contactnumber bigint
);

insert into Company (companyname, location, contactnumber) values
('Cipla', 'Mumbai', 9876543210),
('Sun Pharma', 'Pune', 9876543211),
('Dr. Reddy', 'Hyderabad', 9876543212),
('Zydus', 'Delhi', 321456987),
('Lupin', 'Chennai', 1234569870);

-- Table: Medicines
create table Medicines (
    medicine_id int primary key auto_increment,
    medicine_name varchar(30) not null,
    companyid int,
    price decimal(10,2),
    manufacturedate date,
    expirydate date,
    foreign key (companyid) references Company(companyid)
);

insert into Medicines (medicine_name, companyid, price, manufacturedate, expirydate) values
('Paracetamol', 1, 40.00, '2024-01-01', '2026-01-01'),
('Dolo 650', 2, 20.00, '2024-03-01', '2026-03-01'),
('Crosin', 3, 10.00, '2024-02-15', '2026-02-15'),
('Vaigra50', 4, 60.00, '2024-04-01', '2026-04-01'),
('Corex', 5, 150.00, '2024-05-01', '2026-05-01');

-- Table: Dealer
create table Dealer (
    dealerid int primary key auto_increment,
    dealername varchar(50) not null,
    contactnumber bigint,
    companyid int,
    email varchar(50),
    foreign key (companyid) references Company(companyid)
);

insert into Dealer (dealername, contactnumber, companyid, email) values
('Rohit Distributer', 9876543222, 1, 'rohitd@gmail.com'),
('Shanu Pharma', 9876543223, 2, 'shanuph@gmail.com'),
('Rohity Traders', 9876543224, 3, 'rohittra@gmail.com'),
('Bunty Medicos', 9876543225, 4, 'buntymed@gmail.com'),
('Quastec Suppliers', 9876543226, 5, 'quatecsup@gmail.com');

-- Table: Employee
create table Employee (
    empid int primary key auto_increment,
    empname varchar(50) not null,
    contactnumber varchar(15),
    emppost varchar(30),
    salary int,
    email varchar(50)
);

insert into Employee (empname, contactnumber, emppost, salary, email) values
('Rohit', '1234567890', 'Cashier', 150000, 'rohit@gmail.com'),
('Shanu', '0321654789', 'Manager', 20000, 'shanu@gmail.com'),
('Yadav', '9965874123', 'Salesman', 12000, 'yadav@gmail.com'),
('Omkar', '9125347805', 'Accountant', 18000, 'omkar@gmail.com'),
('Nassu', '9876543335', 'Stock Keeper', 14000, 'nassu@gmail.com');

-- Table: Login
CREATE TABLE Login (
    username varchar(30) primary key,
    password varchar(30) not null,
    empid int,
    foreign key (empid) references Employee(empid)
);

insert into Login values
('rohit123', 'rohitrd123', 1),
('shanu1137', 'shanu234', 2),
('yadav123', 'yadav345', 3),
('omkar123', 'omkar456', 4),
('nassu123', 'nassu567', 5);

-- Table: Customers
create table Customers (
    customerid int primary key auto_increment,
    customername varchar(50) not null,
    contactnumber varchar(15)
);

insert into Customers (customername, contactnumber) values
('Ramesh', '9876544441'),
('Suresh', '9876544442'),
('Mahesh', '9876544443'),
('Nilesh', '9876544444'),
('Ganesh', '9876544445');

-- Table: Sales
create table Sales (
    saleid int primary key auto_increment,
    customerid int,
    medicineid int,
    saledate date,
    quantity int check (quantity > 0),
    totalprice decimal(10,2),
    foreign key (customerid) references Customers(customerid),
    foreign key (medicineid) references Medicines(medicine_id)
);

insert into Sales (customerid, medicineid, saledate, quantity, totalprice) values
(1, 1, '2025-10-01', 2, 80.00),
(2, 2, '2025-10-02', 1, 20.00),
(3, 3, '2025-10-03', 3, 30.00),
(4, 4, '2025-10-04', 1, 60.00),
(5, 5, '2025-10-05', 4, 600.00);

-- Table: Purchase
create table Purchase (
    purchaseid int primary key auto_increment,
    dealerid int,
    medicineid int,
    purchasedate date,
    quantity int check (quantity > 0),
    totalprice decimal(10,2),
    foreign key (dealerid) references Dealer(dealerid),
    foreign key (medicineid) references Medicines(medicine_id)
);

insert into Purchase (dealerid, medicineid, purchasedate, quantity, totalprice) values
(1, 1, '2025-09-25', 100, 2500.00),
(2, 2, '2025-09-25', 80, 2400.00),
(3, 3, '2025-09-26', 60, 2700.00),
(4, 4, '2025-09-26', 50, 3000.00),
(5, 5, '2025-09-27', 120, 1800.00);

-- Table: Stock
create table Stock (
    medicineid int,
    quantityleft int check (quantityleft >= 0),
    foreign key (medicineid) references Medicines(medicine_id)
);

insert into Stock (medicineid, quantityleft) values
(1, 98),
(2, 79),
(3, 57),
(4, 49),
(5, 116);

-- Table: Payment
CREATE TABLE Payment (
    paymentid INT PRIMARY KEY AUTO_INCREMENT,
    customerid INT,
    amountpaid DECIMAL(10,2),
    paymentdate DATE,
    paymentmode VARCHAR(20),
    FOREIGN KEY (customerid) REFERENCES Customers(customerid)
);

INSERT INTO Payment (customerid, amountpaid, paymentdate, paymentmode) VALUES
(1, 50.00, '2025-10-01', 'Cash'),
(2, 30.00, '2025-10-02', 'UPI'),
(3, 135.00, '2025-10-03', 'Card'),
(4, 60.00, '2025-10-04', 'Cash'),
(5, 60.00, '2025-10-05', 'UPI');

-- Table: Regular Customers
CREATE TABLE Regular_Custom (
    customerid INT,
    totalpurchases INT CHECK (totalpurchases >= 5),
    discountpercent DECIMAL(5,2) DEFAULT 10.00,
    FOREIGN KEY (customerid) REFERENCES Customers(customerid)
);

INSERT INTO Regular_Custom (customerid, totalpurchases, discountpercent) VALUES
(1, 5, 10.00),
(2, 6, 10.00),
(3, 7, 15.00),
(4, 5, 10.00),
(5, 8, 20.00);
