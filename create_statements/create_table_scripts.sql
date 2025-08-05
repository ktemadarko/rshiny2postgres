CREATE TABLE PRODUCT (
    -- Column: product_id
    product_id CHAR(3) NOT NULL PRIMARY KEY ,
    product_description VARCHAR(35)
);

SELECT * FROM PRODUCT;

INSERT INTO PRODUCT (product_id, product_description)
VALUES
    ('P01', 'Laptop'),
    ('P02', 'Smartphone'),
    ('P03', 'Smartwatch'),
    ('P04', 'Bluetooth Speaker'),
    ('P05', 'Bluetooth Headset'),
    ('P06', 'Wireless Mouse'),
    ('P07', 'Mechanical Keyboard'),
    ('P08', 'Webcam 1080p'),
    ('P09', 'Monitor 24-inch'),
    ('P10', 'Printer');
    

CREATE TABLE CUSTOMER_TIER ( 
    customer_id VARCHAR(4) PRIMARY KEY,
    customer_name VARCHAR(60),
    customer_category VARCHAR(25),
    tier_code VARCHAR(2) NOT NULL ,
    -- Column : tier_code AA CE
    FOREIGN KEY(tier_code) REFERENCES TIER(tier_code)
);

SELECT tablename FROM pg_tables WHERE schemaname ='public';

-- SPLIT THE TABLE COLUMNS SO AA AND TIER 1 IS IN THE TIER TABLE
-- SO I REMOVED THE TIER_TYPE COLUMN

INSERT INTO CUSTOMER_TIER
VALUES
    ('CT01', 'Global Wholesale Solutions', 'WHOLESALER', 'AA'),     
    ('CT02', 'Premium Distributors Co.', 'WHOLESALER', 'AB'),     
    ('CT03', 'Mega Supply Network'  , 'WHOLESALER', 'AC'),           
    ('CT04', 'City Mart Retail' , 'RETAILER', 'BA'),   
    ('CT05', 'Cornerstone Brands Inc.', 'RETAILER', 'BB'),   
    ('CT06', 'Elite Wholesale Group', 'WHOLESALER', 'AA'),         
    ('CT07', 'Unity Logistics & Supply', 'WHOLESALER', 'AB'),          
    ('CT08', 'Apex Bulk Goods',   'WHOLESALER', 'AC'),                
    ('CT09', 'Horizon Trading Post', 'RETAILER', 'BA'),   
    ('CT10', 'Prime Source Distributors', 'WHOLESALER', 'AB'),        
    ('CT11', 'Grand Scale Supply Co.' , 'WHOLESALER', 'AC'),  
    ('CT12', 'Discount Deals Outlet', 'RETAILER', 'BA'),   
    ('CT13', 'Continental Wholesale Group', 'WHOLESALER', 'AA'),  
    ('CT14', 'The Daily Essentials Store', 'RETAILER', 'BA'),   
    ('CT15', 'Bright Future Electronics', 'RETAILER', 'BB'),   
    ('CT16', 'Pioneer Wholesale Exports',  'WHOLESALER', 'AB'),         
    ('CT17', 'Reliable Trade Partners' , 'WHOLESALER', 'AC'),   
    ('CT18', 'Dynamic Distribution Hub', 'WHOLESALER', 'AA'),
    ('CT19', 'Frontier Global Trading', 'RETAILER', 'BB'),    
    ('CT21', 'Alliance Wholesalers Ltd.', 'WHOLESALER', 'AB'),  
    ('CT22', 'Northern Star Wholesale', 'WHOLESALER', 'AA'),       
    ('CT23', 'Central Bulk Supplies', 'WHOLESALER', 'AC'),         
    ('CT24', 'Tech Gadget Gallery', 'RETAILER', 'BB');       
      
SELECT * FROM CUSTOMER_TIER;

-- MISTAKE IN THE NUMBER OF CUSTOMER TIER NO CT20
-- THE QUERIES BELOW HELP EDIT THEM

UPDATE public.customer_tier SET
customer_id = 'CT20'::character varying WHERE
customer_id = 'CT21';

UPDATE public.customer_tier SET
customer_id = 'CT21'::character varying WHERE
customer_id = 'CT22';

UPDATE public.customer_tier SET
customer_id = 'CT22'::character varying WHERE
customer_id = 'CT23';

UPDATE public.customer_tier SET
customer_id = 'CT23'::character varying WHERE
customer_id = 'CT24';


-- I was getting this error 
-- ERROR:  there is no unique constraint matching given keys for referenced table "customer_tier" 
-- meaning every foreign key must refer to a primary key of another table

CREATE TABLE TIER (
	tier_code VARCHAR(2) NOT NULL PRIMARY KEY,
	tier_type VARCHAR(6) NOT NULL	
);

INSERT INTO TIER
VALUES
	('AA','TIER 1'),
	('AB','TIER 2'),
	('AC','TIER 3'),
	('BA','TIER 1'),
	('BB','TIER 2');
	

-- table to find the price of the product  year = 2025, tier = AA
CREATE TABLE PRICE_BY_YEAR (
    
    year_id DATE ,
    product_id CHAR(3) NOT NULL , 
    tier_code VARCHAR(2) NOT NULL ,
    ghs_price DECIMAL(10,2) NOT NULL ,

    PRIMARY KEY (year_id, product_id, tier_code) ,
    
    -- constraint below was not needed since we want to capture the exact yyyy-mm-dd
    -- CONSTRAINT year_id CHECK MONTH FROM year_id = 1 AND DAY FROM year_id= 1 ,

    -- Setting up a foreign key constraint referencing the 'tier_code' column in the
    -- 'CUSTOMER_TIER' table
    FOREIGN KEY(tier_code) REFERENCES TIER(tier_code) ,

    FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id)
    
    -- constraint below is would have been great if the price always remainder stable
    -- from year to year
    -- UNIQUE(year_id, product_id, tier_code, ghs_price)

);

INSERT INTO PRICE_BY_YEAR
VALUES
    (2024, 'P01', "AA", )


-- table to find the price of the product  year = 2025, tier = AA
-- THIS WILL BE A STANDARD table all to build out the PRICE_BY_YEAR TABLE

CREATE TABLE STANDARD_PRICE_BY_YEAR (
    
    year_id DATE ,
    product_id CHAR(3) NOT NULL , 
    tier_code VARCHAR(2) NOT NULL DEFAULT 'AA' ,
    ghs_price DECIMAL(10,2) NOT NULL ,

    PRIMARY KEY (year_id, product_id, tier_code) ,
    
    FOREIGN KEY(tier_code) REFERENCES TIER(tier_code) ,

    FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id)
    
);