CREATE TABLE PRODUCT (
    -- Column: product_id
    product_id CHAR(3) NOT NULL PRIMARY KEY ,
    product_description VARCHAR(35)
);

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
    -- Column tier_type eg. STANDARD TIER, TIER 1
    tier_type VARCHAR(13) NOT NULL,
    -- Column : tier_code AA CE
    tier_code VARCHAR(2) NOT NULL
);

INSERT INTO CUSTOMER_TIER
VALUES
    ('CT01', 'Global Wholesale Solutions', 'WHOLESALER', 'TIER 1', 'AA'),     
    ('CT02', 'Premium Distributors Co.', 'WHOLESALER', 'TIER 2', 'AB'),     
    ('CT03', 'Mega Supply Network'  , 'WHOLESALER', 'TIER 3', 'AC'),           
    ('CT04', 'City Mart Retail' , 'RETAILER', 'TIER 1', 'BA'),   
    ('CT05', 'Cornerstone Brands Inc.', 'RETAILER', 'TIER 2', 'BB'),   
    ('CT06', 'Elite Wholesale Group', 'WHOLESALER', 'TIER 1', 'AA'),         
    ('CT07', 'Unity Logistics & Supply', 'WHOLESALER', 'TIER 2', 'AB'),          
    ('CT08', 'Apex Bulk Goods',   'WHOLESALER', 'TIER 3', 'AC'),                
    ('CT09', 'Horizon Trading Post', 'RETAILER', 'TIER 1', 'BA'),   
    ('CT10', 'Prime Source Distributors', 'WHOLESALER', 'TIER 2', 'AB'),        
    ('CT11', 'Grand Scale Supply Co.' , 'WHOLESALER', 'TIER 3', 'AC'),  
    ('CT12', 'Discount Deals Outlet', 'RETAILER', 'TIER 1', 'BA'),   
    ('CT13', 'Continental Wholesale Group', 'WHOLESALER', 'TIER 1', 'AA'),  
    ('CT14', 'The Daily Essentials Store', 'RETAILER', 'TIER 1', 'BA'),   
    ('CT15', 'Bright Future Electronics', 'RETAILER', 'TIER 2', 'BB'),   
    ('CT16', 'Pioneer Wholesale Exports',  'WHOLESALER', 'TIER 2', 'AB'),         
    ('CT17', 'Reliable Trade Partners' , 'WHOLESALER', 'TIER 3', 'AC'),   
    ('CT18', 'Dynamic Distribution Hub', 'WHOLESALER', 'TIER 1', 'AA'),
    ('CT19', 'Frontier Global Trading', 'RETAILER', 'TIER 2', 'BB'),    
    ('CT21', 'Alliance Wholesalers Ltd.', 'WHOLESALER', 'TIER 2', 'AB'),  
    ('CT22', 'Northern Star Wholesale', 'WHOLESALER', 'TIER 1', 'AA'),       
    ('CT23', 'Central Bulk Supplies', 'WHOLESALER', 'TIER 3', 'AC'),         
    ('CT24', 'Tech Gadget Gallery', 'RETAILER', 'TIER 2', 'BB');       
      

-- table to find the price of the product  year = 2025, tier = AA
CREATE TABLE PRICE_BY_YEAR (
    
    year_id DATE ,
    product_id CHAR(6) NOT NULL , 
    tier_code VARCHAR(2) NOT NULL ,
    ghs_price DECIMAL(10,2) NOT NULL ,

    PRIMARY KEY (year_id, product_id, tier_code) ,
    
    -- constraint below was not needed since we want to capture the exact yyyy-mm-dd
    -- CONSTRAINT year_id CHECK MONTH FROM year_id = 1 AND DAY FROM year_id= 1 ,

    -- Setting up a foreign key constraint referencing the 'tier_code' column in the
    -- 'CUSTOMER_TIER' table
    FOREIGN KEY(tier_code) REFERENCES CUSTOMER_TIER(tier_code) ,

    FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id)
    
    -- constraint below is would have been great if the price always remainder stable
    -- from year to year
    -- UNIQUE(year_id, product_id, tier_code, ghs_price)

);

