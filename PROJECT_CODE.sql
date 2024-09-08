-- Table creation for ADMINISTRATION
CREATE TABLE ADMINISTRATION(
    ADMIN_ID VARCHAR(10) NOT NULL,      -- Unique identifier for admin
    PASSWORD VARCHAR(20),               -- Admin password
    DETAILS VARCHAR(200),               -- Additional details about the admin
    PRIMARY KEY(ADMIN_ID)               -- Primary key constraint
);

-- Table creation for PROCESSOR
CREATE TABLE PROCESSOR(
    PROCESSOR_ID VARCHAR(10) NOT NULL,  -- Unique identifier for processor
    PROCESSOR_TYPE VARCHAR(10),         -- Type of the processor
    PRIMARY_CLOCK_SPEED INT,            -- Primary clock speed in MHz
    SEC_CLOCK_SPEED INT,                -- Secondary clock speed in MHz
    NO_OF_CORE INT,                     -- Number of cores
    NO_OF_THREADS INT,                  -- Number of threads
    PRIMARY KEY (PROCESSOR_ID)          -- Primary key constraint
);

-- Table creation for CAMERA
CREATE TABLE CAMERA(
    CAMERA_ID VARCHAR(10) NOT NULL,     -- Unique identifier for camera
    MACROLENS INT,                      -- Macro lens specifications
    MAINCAMERA INT,                     -- Main camera specifications
    ULTRAWIDE INT,                      -- Ultra-wide camera specifications
    IOS VARCHAR(3),                    -- iOS support (Yes/No)
    SENSOR_NO VARCHAR(10),              -- Sensor number
    PRIMARY KEY(CAMERA_ID)             -- Primary key constraint
);

-- Table creation for PHONE
CREATE TABLE PHONE(
    MODEL_NO VARCHAR(10) NOT NULL,      -- Unique model number of the phone
    RAM INT,                           -- RAM in GB
    ROM INT,                           -- ROM in GB
    CONNECTIVITY VARCHAR(20),          -- Connectivity type (e.g., 5G, 4G)
    BATTERY INT,                       -- Battery capacity in mAh
    PRICE INT,                         -- Price of the phone
    PROCESSOR_ID VARCHAR(10),          -- Foreign key referencing PROCESSOR
    CAMERA_ID VARCHAR(10),             -- Foreign key referencing CAMERA
    ADMIN_ID VARCHAR(10),              -- Foreign key referencing ADMINISTRATION
    TYPE VARCHAR(4),                   -- Type of phone (e.g., A, B, C)
    PRIMARY KEY(MODEL_NO),            -- Primary key constraint
    FOREIGN KEY(PROCESSOR_ID) REFERENCES PROCESSOR(PROCESSOR_ID),
    FOREIGN KEY(CAMERA_ID) REFERENCES CAMERA(CAMERA_ID),
    FOREIGN KEY(ADMIN_ID) REFERENCES ADMINISTRATION(ADMIN_ID)
);

-- Table creation for CUSTOMERS1
CREATE TABLE CUSTOMERS1(
    C_ID VARCHAR(10) NOT NULL,          -- Unique identifier for customer
    USER_NAME VARCHAR(20),              -- Customer's username
    PASS VARCHAR(20),                   -- Customer's password
    MOBILE_NO VARCHAR(15),              -- Customer's mobile number
    EMAIL VARCHAR(255),                -- Customer's email address
    COUNTRY VARCHAR(15),                -- Customer's country
    ADDRESS VARCHAR(100),               -- Customer's address
    PRIMARY KEY(C_ID),                 -- Primary key constraint
    UNIQUE (MOBILE_NO),                -- Unique constraint on mobile number
    UNIQUE (EMAIL)                     -- Unique constraint on email address
);

-- Table creation for PAYMENT
CREATE TABLE PAYMENT(
    PAYMENT_ID VARCHAR(15) NOT NULL,    -- Unique identifier for payment
    AMOUNT INT,                         -- Payment amount
    PAYMENT_MODE VARCHAR(10),          -- Mode of payment (e.g., Credit, Debit)
    PAYMENT_TIME DATETIME,             -- Time of payment
    ADMIN_ID VARCHAR(10),              -- Foreign key referencing ADMINISTRATION
    PRIMARY KEY(PAYMENT_ID),           -- Primary key constraint
    FOREIGN KEY (ADMIN_ID) REFERENCES ADMINISTRATION(ADMIN_ID)
);

-- Table creation for REGISTRATION1
CREATE TABLE REGISTRATION1(
    REGISTRATION_ID VARCHAR(10) NOT NULL, -- Unique identifier for registration
    MODEL_NO VARCHAR(10),                -- Foreign key referencing PHONE
    TOTAL_PRICE INT,                    -- Total price of the registration
    CUSTOMER_ID VARCHAR(10),            -- Foreign key referencing CUSTOMERS1
    PRIMARY KEY (REGISTRATION_ID),     -- Primary key constraint
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS1(C_ID),
    FOREIGN KEY (MODEL_NO) REFERENCES PHONE(MODEL_NO)
);

-- Table creation for CART
CREATE TABLE CART(
    CART_ID VARCHAR(10) NOT NULL,       -- Unique identifier for cart
    NO_OF_PRODUCTS INT,                 -- Number of products in the cart
    TOTAL_PRICE INT,                    -- Total price of items in the cart
    CUSTOMER_ID VARCHAR(10),            -- Foreign key referencing CUSTOMERS1
    REGISTRATION_ID VARCHAR(10),        -- Foreign key referencing REGISTRATION1
    PRIMARY KEY(CART_ID),              -- Primary key constraint
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS1(C_ID),
    FOREIGN KEY (REGISTRATION_ID) REFERENCES REGISTRATION1(REGISTRATION_ID)
);

-- Table creation for MAKE_PAYMENT
CREATE TABLE MAKE_PAYMENT(
    C_ID VARCHAR(10),                   -- Foreign key referencing CUSTOMERS1
    PAYMENT_ID VARCHAR(15),             -- Foreign key referencing PAYMENT
    PRIMARY KEY (C_ID, PAYMENT_ID),    -- Composite primary key constraint
    FOREIGN KEY (C_ID) REFERENCES CUSTOMERS1(C_ID),
    FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT(PAYMENT_ID)
);

-- Inserting data into ADMINISTRATION table
INSERT INTO ADMINISTRATION (ADMIN_ID, PASSWORD, DETAILS) VALUES
('admin1', 'password123', 'Administrator 1 details'),
('admin2', 'pass456', 'Administrator 2 details'),
('admin3', 'adminpass', 'Administrator 3 details'),
('admin4', 'securepass', 'Administrator 4 details'),
('admin5', '123456', 'Administrator 5 details');

-- Inserting data into PROCESSOR table
INSERT INTO PROCESSOR (PROCESSOR_ID, PROCESSOR_TYPE, PRIMARY_CLOCK_SPEED, SEC_CLOCK_SPEED, NO_OF_CORE, NO_OF_THREADS) VALUES
('P3', 'TypeA', 3200, 2800, 6, 12),
('P4', 'TypeB', 2800, 2400, 4, 8),
('P22', 'TypeC', 3000, 2500, 8, 16),
('P23', 'TypeA', 3400, 3000, 4, 8),
('P44', 'TypeG', 3600, 3200, 6, 12),
('P45', 'TypeH', 3200, 2800, 4, 8),
('P62', 'TypeI', 3000, 2500, 6, 12),
('P63', 'TypeJ', 2800, 2400, 4, 8);

-- Inserting data into CAMERA table
INSERT INTO CAMERA (CAMERA_ID, MACROLENS, MAINCAMERA, ULTRAWIDE, IOS, SENSOR_NO) VALUES
('e9X2R7', 16, 8, 4, 'No', 'S78901'),
('K5Y8U2', 12, 12, 8, 'Yes', 'R23456'),
('D9X2R7', 20, 16, 8, 'No', 'A34567'),
('S1B5Q9', 14, 12, 10, 'No', 'E67890'),
('T3X7C1', 20, 16, 8, 'Yes', 'F12345'),
('R8Y2N6', 18, 10, 6, 'Yes', 'D56789');

-- Inserting data into PHONE table
INSERT INTO PHONE (MODEL_NO, RAM, ROM, CONNECTIVITY, BATTERY, PRICE, PROCESSOR_ID, CAMERA_ID, ADMIN_ID, TYPE) VALUES
('model1', 4, 64, '5G', 4000, 20000, 'P3', 'K5Y8U2', 'admin1', 'A'),
('model2', 6, 128, '5G', 4500, 25000, 'P4', 'D9X2R7', 'admin2', 'B'),
('model3', 8, 256, '5G', 5000, 30000, 'P3', 'K5Y8U2', 'admin3', 'C'),
('model4', 4, 64, '4G', 4000, 15000, 'P4', 'S1B5Q9', 'admin4', 'A'),
('model5', 6, 128, '4G', 4500, 20000, 'P44', 'D9X2R7', 'admin2', 'C'),
('model6', 8, 256, '4G', 5000, 25000, 'P45', 'K5Y8U2', 'admin3', 'A'),
('model7', 4, 64, '3G', 4000, 10000, 'P63', 'S1B5Q9', 'admin1', 'C'),
('model8', 6, 128, '3G', 4500, 15000, 'P44', 'D9X2R7', 'admin2', 'D'),
('model9', 8, 256, '3G', 5000, 20000, 'P62', 'K5Y8U2', 'admin4', 'E'),
('model10', 4, 64, '2G', 4000, 5000, 'P3', 'S1B5Q9', 'admin1', 'A'),
('model11', 6, 128, '2G', 4500, 7500, 'P44', 'D9X2R7', 'admin1', 'A'),
('model12', 8, 256, '2G', 5000, 10000, 'P63', 'e9X2R7', 'admin2', 'D'),
('model13', 4, 64, '5G', 4000, 20000, 'P45', 'K5Y8U2', 'admin3', 'A'),
('model14', 6, 128, '5G', 4500, 25000, 'P4', 'D9X2R7', 'admin4', 'A'),
('model15', 8, 256, '5G', 5000, 30000, 'P45', 'e9X2R7', 'admin5', 'B'),
('model16', 4, 64, '4G', 4000, 15000, 'P3', 'D9X2R7', 'admin1', 'D'),
('model17', 6, 128, '4G', 4500, 20000, 'P4', 'K5Y8U2', 'admin1', 'A'),
('model18', 8, 256, '4G', 5000, 25000, 'P22', 'R8Y2N6', 'admin3', 'C'),
('model19', 4, 64, '3G', 4000, 10000, 'P23', 'T3X7C1', 'admin1', 'A'),
('model20', 6, 128, '3G', 4500, 15000, 'P22', 'D9X2R7', 'admin2', 'B');

-- Inserting data into CUSTOMERS1 table
INSERT INTO CUSTOMERS1 (C_ID, USER_NAME, PASS, MOBILE_NO, EMAIL, COUNTRY, ADDRESS) VALUES
('C01', 'John Doe', 'johnpass123', '1234567890', 'johndoe@example.com', 'USA', '123 Elm St'),
('C02', 'Jane Smith', 'janepass456', '0987654321', 'janesmith@example.com', 'Canada', '456 Maple Ave'),
('C03', 'Alice Johnson', 'alicepass789', '1112223333', 'alicejohnson@example.com', 'UK', '789 Oak Ln'),
('C04', 'Bob Brown', 'bobpass123', '4445556666', 'bobbrown@example.com', 'Australia', '321 Pine St'),
('C05', 'Carol White', 'carolpass456', '7778889999', 'carolwhite@example.com', 'India', '654 Cedar Blvd');

-- Inserting data into PAYMENT table
INSERT INTO PAYMENT (PAYMENT_ID, AMOUNT, PAYMENT_MODE, PAYMENT_TIME, ADMIN_ID) VALUES
('Payment1', 20000, 'Credit', '2024-09-08 10:00:00', 'admin1'),
('Payment2', 25000, 'Debit', '2024-09-08 11:00:00', 'admin2'),
('Payment3', 30000, 'Cash', '2024-09-08 12:00:00', 'admin3'),
('Payment4', 15000, 'Online', '2024-09-08 13:00:00', 'admin4'),
('Payment5', 20000, 'Credit', '2024-09-08 14:00:00', 'admin5');

-- Inserting data into REGISTRATION1 table
INSERT INTO REGISTRATION1 (REGISTRATION_ID, MODEL_NO, TOTAL_PRICE, CUSTOMER_ID) VALUES
('R1', 'model1', 20000, 'C01'),
('R2', 'model2', 25000, 'C02'),
('R3', 'model3', 30000, 'C03'),
('R4', 'model4', 15000, 'C04'),
('R5', 'model5', 20000, 'C05');

-- Inserting data into CART table
INSERT INTO CART (CART_ID, NO_OF_PRODUCTS, TOTAL_PRICE, CUSTOMER_ID, REGISTRATION_ID) VALUES
('cart1', 2, 50000, 'C01', 'R1'),
('cart2', 3, 75000, 'C02', 'R2'),
('cart3', 1, 30000, 'C03', 'R3'),
('cart4', 4, 60000, 'C04', 'R4'),
('cart5', 2, 50000, 'C05', 'R5');

-- Inserting data into MAKE_PAYMENT table
INSERT INTO MAKE_PAYMENT (C_ID, PAYMENT_ID) VALUES
('C01', 'Payment1'),
('C02', 'Payment2'),
('C03', 'Payment3'),
('C04', 'Payment4'),
('C05', 'Payment5');

-- Querying data from various tables
SELECT * FROM PHONE;          -- Retrieves all records from PHONE table
SELECT * FROM PAYMENT;        -- Retrieves all records from PAYMENT table
SELECT * FROM REGISTRATION1; -- Retrieves all records from REGISTRATION1 table
SELECT * FROM PROCESSOR;      -- Retrieves all records from PROCESSOR table
SELECT * FROM CAMERA;         -- Retrieves all records from CAMERA table
SELECT * FROM CART;           -- Retrieves all records from CART table
SELECT * FROM CUSTOMERS1;     -- Retrieves all records from CUSTOMERS1 table
SELECT * FROM MAKE_PAYMENT;   -- Retrieves all records from MAKE_PAYMENT table
SELECT * FROM ADMINISTRATION; -- Retrieves all records from ADMINISTRATION table
