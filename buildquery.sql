--Mason Veljan 101722004
/*
TOUR (TourName, Description)
PK (TourName)

CLIENT (ClientID, Surname, GivenName, Gender)
PK (ClientID)

EVENT(TourName, EventYear, EventMonth, EventDay, Fee)
PK (TourName, EventYear, EventMonth, EventDay)
FK (TourName) References TOUR

BOOKING(TourName, ClientID, EventYear, EventMonth, EventDay, DateBooked, Payment)
PK (TourName, Client ID, EventYear, EventMonth, EventDay)
FK (TourName, EventYear, EventMonth, EventDay) References EVENT
FK (ClientID) References Client
*/

