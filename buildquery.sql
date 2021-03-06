--Mason Veljan 101722004
/*
TOUR (TourName, Description)
PK (TourName)

CLIENT (ClientId, Surname, GivenName, Gender)
PK (ClientID)

EVENT(TourName, EventYear, EventMonth, EventDay, Fee)
PK (TourName, EventYear, EventMonth, EventDay)
FK (TourName) References TOUR

BOOKING(TourName, ClientId, EventYear, EventMonth, EventDay, DateBooked, Payment)
PK (TourName, ClientId, EventYear, EventMonth, EventDay)
FK (TourName, EventYear, EventMonth, EventDay) References EVENT
FK (ClientId) References Client
*/

CREATE TABLE TOUR(
    TourName NVARCHAR(100),
    Description NVARCHAR(100),
    PRIMARY KEY (TourName)
);

CREATE TABLE CLIENT (
    ClientId int,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(100) CHECK (Gender IN ('M', 'F', 'I'))
    PRIMARY KEY (ClientId)
);

CREATE TABLE EVENT(
    TourName NVARCHAR(100),
    EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb',
    'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    EventDay INT CHECK (EventDay >=1 AND EventDay <=31),
    EventYear INT CHECK (EventYear BETWEEN 0000 AND 9999),
    EventFee MONEY NOT NULL CHECK (EventFee > 0),
    PRIMARY KEY (TourName, EventMonth, EventDay, EventYear),
    FOREIGN KEY (TourName) REFERENCES TOUR
);

CREATE TABLE BOOKING(
    ClientId INT,
    TourName NVARCHAR(100),
    EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb',
    'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    EventDay INT CHECK (EventDay >=1 AND EventDay <=31),
    EventYear INT CHECK (EventYear BETWEEN 0000 AND 9999),
    Payment MONEY CHECK (Payment > 0),
    DateBooked DATE NOT NULL,
    PRIMARY KEY (ClientId, TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY (ClientID) REFERENCES CLIENT,
    FOREIGN KEY (TourName, EventMonth, EventDay, Eventyear) REFERENCES EVENT
);

INSERT INTO CLIENT (ClientId, Surname, GivenName, Gender)
VALUES (1, 'Price', 'Taylor', 'M');

INSERT INTO CLIENT (ClientId, Surname, GivenName, Gender)
VALUES (2, 'Gamble', 'Ellyse', 'F');

INSERT INTO CLIENT (ClientId, Surname, GivenName, Gender)
VALUES (3, 'Tan', 'Tilly', 'F');

INSERT INTO CLIENT (ClientId, Surname, GivenName, Gender)
VALUES (4, 'Veljan', 'Mason', 'M');

INSERT INTO TOUR (TourName, Description)
VALUES ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region')

INSERT INTO TOUR (TourName, Description)
VALUES ('South', 'Tour of wineries and outlets of Mornington Penisula')

INSERT INTO TOUR (TourName, Description)
VALUES ('West', 'Tour of wineries and outlets of the Geelong and Otways region')


INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('North', 'Jan', 9, 2016, 200)

INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('North', 'Feb', 13, 2016, 225)

INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('South', 'Jan', 9, 2016, 200)

INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('South', 'Jan', 16, 2016, 200)

INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES ('West', 'Jan', 20, 2016, 225)


INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (1, 'North', 'Jan', 9, 2016, 200, '12-10-2015');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (2, 'North', 'Jan', 9, 2016, 200, '12-16-2015');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (1, 'North', 'Feb', 13, 2016, 225, '01-08-2016');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (2, 'North', 'Feb', 13, 2016, 125, '01-14-2016');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (3, 'North', 'Feb', 13, 2016, 225, '02-03-2016');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (1, 'South', 'Jan', 9, 2016, 200, '12-10-2015');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (2, 'South', 'Jan', 16, 2016, 200, '12-18-2015');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (3, 'South', 'Jan', 16, 2016, 200, '01-09-2016');


INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (2, 'West', 'Jan', 29, 2016, 225, '12-17-2015');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (3, 'West', 'Jan', 29, 2016, 200, '12-18-2015');

--Task 4
--Q1
SELECT C.GivenName, C.Surname, B.TourName, T.Description, B.EventYear, B.EventMonth,
B.EventDay, E.EventFee, B.DateBooked, B.Payment
FROM BOOKING B

INNER JOIN CLIENT C
ON B.ClientId = C.ClientId

INNER JOIN TOUR T
ON B.TourName = T.TourName

INNER JOIN EVENT E
ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth AND B.EventDay = E.EventDay;

SELECT COUNT(*) FROM BOOKING;

--Q2
SELECT EventMonth, TourName, COUNT(*)
FROM BOOKING
GROUP BY EventMonth, TourName;

--Q3
SELECT * FROM BOOKING
WHERE Payment > (SELECT Avg(Payment)
FROM Booking);

--Task 5:
CREATE VIEW tour_sum AS
SELECT C.GivenName, C.Surname, B.TourName, T.Description, B.EventYear, B.EventMonth, B.EventDay, B.Payment
FROM BOOKING B

INNER JOIN CLIENT C
ON B.ClientId = C.ClientId

INNER JOIN TOUR T
ON B.TourName = T.TourName;

SELECT * FROM tour_sum;

--Task 6:
/*
Task 4 Query 1 Check:
To check that the first query from task 4 is returning the correct amount of entries
I have counted the number of columns from booking on its own using:
SELECT COUNT(*) FROM BOOKING;
which equals 10 columns.

Running Query 1 also returns 10 columns of the same information.

Query 2 Check:
The second query check is done almost the same, running the query that was made for that task:
SELECT EventMonth, TourName, COUNT(*)
FROM BOOKING
GROUP BY EventMonth, TourName;

It lists the columns for each event and the count of each.
Feb North: 3
Jan North: 2
Jan South: 3
Jan West: 2
Total of 10 Entires.
which matches the the 10 entries of events from SELECT COUNT(*) FROM BOOKING;

Query 3 Check:
This query was to list payments that are GREATER than the average.
To check this I made a query that would find the average of the payment column.
SELECT AVG(Payment)
FROM BOOKING;

This equals to 200.
Which means in theory that my query should exlude anything below or equal to that number. Which turns out to be true.
The query lists all the bookins with a payment above that average. This is proved by the lowest payment shown is
equal to 225, where we know from all the bookings the lowest is 125 which gets excluded.

*/