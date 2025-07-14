-- 1. Create tables
CREATE TABLE Hotel
(
    HotelID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    StarRating DECIMAL(2,1) CHECK (StarRating BETWEEN 1.0 AND 5.0)
);

CREATE TABLE Room
(
    RoomID INT PRIMARY KEY,
    HotelID INT NOT NULL,
    RoomType VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

CREATE TABLE Guest
(
    GuestID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    CheckIn DATE NOT NULL,
    CheckOut DATE NOT NULL,
    TotalPrice  AS (DATEDIFF(day, CheckIn, CheckOut) * (SELECT Price
    FROM Room
    WHERE Room.RoomID = Booking.RoomID)),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    CHECK (CheckOut > CheckIn)
);
-- 2. Insert sample data
INSERT INTO Hotel
VALUES
    (1, 'Grand Palace', 'Bangalore', 4.5),
    (2, 'Sea View Resort', 'Goa', 4.7),
    (3, 'Mountain Retreat', 'Ooty', 4.2);

INSERT INTO Room
VALUES
    (101, 1, 'Deluxe', 5000.00),
    (102, 1, 'Suite', 8000.00),
    (201, 2, 'Standard', 3000.00),
    (202, 3, 'Executive', 6000.00);

INSERT INTO Guest
VALUES
    (1, 'Arjun', 'Kumar', 'arjun@example.com'),
    (2, 'Neha', 'Sharma', 'neha@example.com'),
    (3, 'Priya', 'Patel', 'priya@example.com');

INSERT INTO Booking
    (BookingID, GuestID, RoomID, CheckIn, CheckOut)
VALUES
    (1, 1, 101, '2025-07-10', '2025-07-12'),
    (2, 2, 102, '2025-07-11', '2025-07-15'),
    (3, 3, 201, '2025-07-05', '2025-07-07'),
    (4, 1, 202, '2025-07-13', '2025-07-14');
-- 3. Filter & sort: find all current bookings sorted by Check-in date
SELECT B.BookingID, G.FirstName || ' ' || G.LastName AS GuestName, H.Name AS HotelName,
    R.RoomType, B.CheckIn, B.CheckOut
FROM Booking B
    JOIN Guest G ON B.GuestID = G.GuestID
    JOIN Room R ON B.RoomID = R.RoomID
    JOIN Hotel H ON R.HotelID = H.HotelID
WHERE B.CheckIn BETWEEN '2025-07-01' AND '2025-07-31'
ORDER BY B.CheckIn ASC;
-- 4. Aggregate + GROUP BY: rooms booked per hotel this month
SELECT H.Name AS HotelName,
    COUNT(B.BookingID) AS NumBookings,
    SUM(DATEDIFF(day, B.CheckIn, B.CheckOut) * R.Price) AS TotalRevenue
FROM Booking B
    JOIN Room R ON B.RoomID = R.RoomID
    JOIN Hotel H ON R.HotelID = H.HotelID
WHERE B.CheckIn >= '2025-07-01' AND B.CheckIn < '2025-08-01'
GROUP BY H.Name
HAVING COUNT(B.BookingID) >= 1
ORDER BY TotalRevenue DESC;
-- 5. Operator example: find premium bookings (revenue > ₹10 000)
SELECT B.BookingID, G.FirstName, R.Price,
    DATEDIFF(day, B.CheckIn, B.CheckOut) AS Nights,
    (DATEDIFF(day, B.CheckIn, B.CheckOut) * R.Price) AS BookingAmount
FROM Booking B
    JOIN Guest G ON B.GuestID = G.GuestID
    JOIN Room R ON B.RoomID = R.RoomID
WHERE (DATEDIFF(day, B.CheckIn, B.CheckOut) * R.Price) > 10000
ORDER BY BookingAmount DESC;
