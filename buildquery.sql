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

--THESE 2 HAD FOREIGN CONSTRAINT ERRORS

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (2, 'West', 'Jan', 29, 2016, 225, '12-17-2015');

INSERT INTO BOOKING (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES (3, 'West', 'Jan', 29, 2016, 200, '12-18-2015');