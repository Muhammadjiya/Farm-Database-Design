-- start by creating all tables

-- create a staff table 
CREATE TABLE staff (
    staff_id INT IDENTITY (1,1) NOT NULL,
    first_name NVARCHAR(50), 
    last_name NVARCHAR(50), 
    date_of_birth DATE,
    email NVARCHAR(50),
    department NVARCHAR(50),
    post NVARCHAR (50),
    department_id INT,
    manager_id INT,
    CONSTRAINT staff_id PRIMARY KEY CLUSTERED (staff_id ASC)
);

-- create a manager table 
CREATE TABLE manager (
    manager_id INT NOT NULL,
    full_name NVARCHAR(100),
    department_name NVARCHAR(50),
    department_id INT
    CONSTRAINT manager_id PRIMARY KEY CLUSTERED (manager_id ASC)   
);

--create department table
CREATE TABLE deparment (
    department_id INT IDENTITY (1,1) NOT NULL,
    department_name NVARCHAR (50),
    no_of_staff TINYINT,
    manager_id INT, 
    CONSTRAINT department_id PRIMARY KEY (department_id ASC)
);

--create eqiupment table
CREATE TABLE equipment (
    equipment_id INT IDENTITY (1,1) NOT NULL,
    equipment_type NVARCHAR (50),
    date_of_purcahse DATE,
    cost_of_purchase INT,
    life_span TINYINT,
    department_id INT,
    staff_id INT,
    CONSTRAINT equipment_id PRIMARY KEY CLUSTERED (equipment_id ASC)  
);

--create farm_produce table
CREATE TABLE farm_produce(
    department_id INT NOT NULL,
    date_of_production DATE, 
    produce_type NVARCHAR(50),
    cost_per_unit SMALLMONEY, 
    total_units INT
);

--create budget table
CREATE TABLE budget(
    allocation_id INT IDENTITY (1,1) NOT NULL,
    department_id INT NOT NULL,
    manager_id INT NOT NULL, 
    disbursement_date DATE,
    amount INT,
    CONSTRAINT allocation_id PRIMARY KEY CLUSTERED (allocation_id ASC)
);

--create sales table
CREATE TABLE sales (
    department_id INT, 
    produce_type NVARCHAR(50), 
    recieved_date DATE, 
    units_recieved INT,
    cost_per_unit SMALLMONEY,
    units_sold INT, 
    amount SMALLMONEY, 
);

-- alter tables to set up foreign keys to prevent an error (square brackets and necessary)

ALTER TABLE staff
    ADD CONSTRAINT [FK_staff] FOREIGN KEY ([department_id]) REFERENCES [dbo].[deparment] ([department_id])
ALTER TABLE staff
    ADD CONSTRAINT [FK_staff_2] FOREIGN KEY ([manager_id]) REFERENCES [dbo].[manager] ([manager_id])

ALTER TABLE manager
    ADD CONSTRAINT [FK_manager] FOREIGN KEY ([department_id]) REFERENCES [dbo].[deparment] ([department_id])

ALTER TABLE department
    ADD CONSTRAINT [FK_department] FOREIGN KEY ([manager_id]) REFERENCES [dbo].[manager] ([manager_id])

ALTER TABLE equipment
    ADD CONSTRAINT [FK_equipment] FOREIGN KEY ([department_id]) REFERENCES [dbo].[deparment] ([department_id])
 ALTER TABLE equipment   
    ADD CONSTRAINT [FK_equipment_2] FOREIGN KEY ([staff_id]) REFERENCES [dbo].[staff] ([staff_id])

ALTER TABLE farm_produce
    ADD CONSTRAINT [FK_farm_produce] FOREIGN KEY ([department_id]) REFERENCES [dbo].[deparment] ([department_id])

ALTER TABLE budget
    ADD CONSTRAINT [FK_budget] FOREIGN KEY ([department_id]) REFERENCES [dbo].[deparment] ([department_id])
ALTER TABLE budget    
    ADD CONSTRAINT [FK_budget_2] FOREIGN KEY ([manager_id]) REFERENCES [dbo].[manager] ([manager_id])

ALTER TABLE sales    
    ADD CONSTRAINT [FK_sales] FOREIGN KEY ([department_id]) REFERENCES [dbo].[deparment] ([department_id])

-- add constraints to ensure data consistency

ALTER TABLE department
    ADD CONSTRAINT [CK_deparment_1] CHECK ([no_of_staff] < = 1)

