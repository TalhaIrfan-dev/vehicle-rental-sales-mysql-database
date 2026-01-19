# 🗄️ Vehicle Rental & Sales (VRS) Database System (MySQL)

## 📑 Table of Contents
- [Summary](#-brief-summary)
- [Overview](#-overview)
- [Problem Statement](#-problem-statement)
- [Features](#features)
- [Database Schema & Data Overview](#database-schema--data-overview)
- [Tools & Technologies](#-tools-and-technologies)
- [Entity Relationships](#entity-relationships)
- [Project Structure](#-project-structure--repository-contents)
- [How to Run the Project](#-how-to-run-the-project)
- [Concepts & Learning Outcomes](#concepts--learning-outcomes)
- [Future Work](#-future-work)
- [Author](#-author) 

---

## 📌 Brief Summary
A relational MySQL database system designed to manage vehicle rental and sales operations, developed in MySQL as an academic database project using proper normalization, constraints, and real-world relationships.

---

## 📖 Overview
The **Vehicle Rental & Sales (VRS) Database System** was developed as an academic project to demonstrate practical implementation of database design concepts using MySQL.

The system models real-world operations of a vehicle rental and sales business by organizing data into well-structured relational tables, 
It supports customers, vehicles, rentals, drivers, completed records, and historical transaction tracking   
It emphasizes **normalization**, **constraint**, **referential integrity**, and **efficient querying**, ensuring accuracy, consistency, scalability, and long-term maintainability.
It supports customers, vehicles, rentals, drivers, completed records, and historical transaction tracking 

---

## 🎯 Problem Statement
Traditional or manual handling of vehicle rental and sales data often leads to:

- Data redundancy and inconsistency  
- Difficulty tracking rentals and sales history  
- Poor reporting and data retrieval  

This project addresses these issues by providing a **centralized relational database system** that enforces business rules through constraints and relationships.  

---

## Features

- Customer management with CNIC, phone, and email validation  
- Vehicle inventory and vehicle type management  
- Vehicle rental handling with single-rental enforcement  
- Driver management and assignment to rentals  
- Sales and completed rental record management  
- Centralized history table for past and present transactions  
- Referential integrity using foreign keys  
- Cascading updates and controlled deletions  
- Sample dataset for testing and demonstration

---

## Database Schema & Data Overview

The database is named **`VRS`** and is designed to support vehicle rental and sales operations.  
It includes structured relational data with sample records for testing and demonstration.

### Tables
- `Customers`
- `VehicleType`
- `Vehicles`
- `Drivers`
- `Rentals`
- `RentalDrivers`
- `Records`
- `History`

### Design Highlights
- Primary and Foreign Keys  
- `NOT NULL`, `UNIQUE`, and `CHECK` constraints  
- ENUM-based controlled attributes  
- Regular expression validation for CNIC, phone, and registration numbers
- Proper data types and default values    
- Fully normalized up to **Third Normal Form (3NF)**

---

## 🛠️ Tools & Technologies

| Category | Technology |
|--------|------------|
| Database | MySQL |
| Query Language | SQL |
| Design Tool | MySQL Workbench |
| Documentation | Word / PDF |
| Optional Integration | Java |

---

## Entities & Relationships

- A **Customer** can rent or purchase multiple **Vehicles**
- Each **Vehicle** belongs to one **VehicleType**
- A **Rental**:
  - Is associated with one **Customer**
  - References one **Vehicle**
  - Can optionally have an assigned **Driver**
- Each **Driver** can be assigned to only one active rental
- **Records** store completed rentals and vehicle sales
- **History** maintains permanent transaction data even after deletions
- All relationships are enforced using foreign keys with cascading rules

---

## 📁 Project Structure & Repository Contents

```text
VRS-Database-Project/
│
├── Dump database file/
│   └── vrs_database_dump.sql    # Complete MySQL database dump (sample data)
│
├── ER Diagrams/
│   └── ERD_of_Database.mwb      # Entity Relationship Diagram (MySQL Workbench)
│
├── Query files/
│   └── VRS_updated_final.sql    # Final Database schema, constraints, and table definitions (Queries)
│       
├── VRS.xlsx                     # Normalization (1NF → 3NF) documentation
│
├── Final Project report by Talha Irfan.docx   # Detailed academic project report
│
└── README.md                    # Project overview and documentation
```

---

## ▶️ How to Run the Project

### Prerequisites
- MySQL Server (8.0 or later recommended)
- MySQL Workbench (or any MySQL client)

### Step 1: Start MySQL Server
- Ensure that your MySQL Server service is running.

### Step 2: Create the Database
- Open **MySQL** or **MySQL Workbench**.

- #### Option 1: Import Using Database Dump (Recommended)
  - Create the database:
    ```sql
    CREATE DATABASE VRS;
    USE VRS;
    ```

  - Import the dump file:
    ```sql
    SOURCE Dump database file/vrs_database_dump.sql;
    ```

- #### Option 2: Create Database from Scratch (Using SQL Files)

  - Run the SQL schema and queries file:
    ```sql
    SOURCE Query files/VRS_updated.sql;
    ```

  - Verify the database:
    ```sql
    SELECT * FROM Customers;
    SELECT * FROM Vehicles;
    SELECT * FROM Rentals;
    SELECT * FROM Records;
    SELECT * FROM History;
    ```

---

## Concepts Applied

- ER Modeling & Relational Mapping  
- Normalization (1NF → 3NF)  
- Primary & Foreign Keys  
- CHECK constraints with REGEXP  
- ENUM-based controlled attributes  
- Cascading referential actions  
- Rental vs Sales transaction modeling  
- SQL DDL & DML  

---

## Learning Outcomes
- Designed a complete real-world relational database  
- Applied normalization and constraints effectively  
- Implemented business rules directly at the database level  
- Modeled rental, sales, and historical data accurately  
- Improved practical understanding of MySQL and SQL  

---

## 🚀 Future Work
- Triggers for automatic history insertion  
- Stored procedures for rentals and returns  
- Role-based user access control  
- Indexing for performance optimization  
- Integration with a Java or web-based application 

---

## 👤 Author

**Talha Irfan**  
*BS Software Engineering — Sukkur IBA University*  
- 💼 LinkedIn: https://www.linkedin.com/in/talha-irfan-dev/
- 🌐 GitHub: https://github.com/TalhaIrfan-dev  
- ✉️ Email: talhairfanchoudry@gmail.com  
- 📍 Location: Sukkur, Pakistan
