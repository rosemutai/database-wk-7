-- Transform into 1NF by splitting Products into separate rows
-- Write an SQL query to transform this table into 1NF, ensuring that each row represents a single product for an order
SELECT 
  OrderID,
  CustomerName,
  LTRIM(RTRIM(value)) AS Product
  FROM Orders
  CROSS APPLY STRING_SPLIT(Products, ',');

-- Write an SQL query to transform this table into 2NF by removing partial dependencies. 
-- Ensure that each non-key column fully depends on the entire primary key

-- Orders table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderProducts;

-- OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderProducts;

