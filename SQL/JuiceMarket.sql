CREATE DATABASE JuiceMarket;
USE JuiceMarket;

CREATE TABLE Customer (
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Phone VARCHAR(20),
	Email VARCHAR(100),
	City VARCHAR(100),
	StName VARCHAR(200)
);

CREATE TABLE Orders (
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT, 
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	OrderDate DATE
);

CREATE TABLE Category (
	CategoryID INT IDENTITY(1,1) PRIMARY KEY,
	CategoryName VARCHAR(100),
	NumberOfJuices INT
);

CREATE TABLE Juice (
	JuiceID INT IDENTITY(1,1) PRIMARY KEY,
	JuiceName VARCHAR(100),
	JuiceSize VARCHAR(2),
	Price DECIMAL(10,2),
	CategoryID INT, 
	FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Order_Details (
	OrderID INT,
	JuiceID INT,
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (JuiceID) REFERENCES Juice(JuiceID),
	PRIMARY KEY (OrderID ,JuiceID),
	Quantity INT
);

CREATE TABLE Recipe (
	RecipeID INT IDENTITY(1,1) PRIMARY KEY,
	RecipeName VARCHAR(100),
	PreparationTime INT,
	Instructions VARCHAR(1000),
	JuiceID INT UNIQUE, 
	FOREIGN KEY (JuiceID) REFERENCES Juice(JuiceID)
);

CREATE TABLE Ingredient (
	IngredientID INT IDENTITY(1,1) PRIMARY KEY,
	IngredientName VARCHAR(100),
	MaxStock INT,
	ExpiryDate DATE
);

CREATE TABLE Ingredient_Of_Recipe (
	RecipeID INT,
	IngredientID INT,
	FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID),
	FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID),
	PRIMARY KEY (RecipeID ,IngredientID),
	AmountRequired INT
);

SELECT OD.OrderID, SUM(OD.Quantity * J.Price) AS TotalPrice
FROM Order_Details OD
JOIN Juice J
ON OD.JuiceID = J.JuiceID
GROUP BY OD.OrderID;