----TASK 3
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Weddings;
DROP TABLE IF EXISTS WeddingEvents;
DROP TABLE IF EXISTS CateringServices;
DROP TABLE IF EXISTS MusicBands;
DROP TABLE IF EXISTS WeddingHalls;
DROP TABLE IF EXISTS InvitationCards;
DROP TABLE IF EXISTS InvitationCardTemplates;

--- 1.1 creating the tables
create Table Users (
    UserID integer NOT NULL PRIMARY KEY,
    Name text NOT NULL,
    BirthDate text, 
    Gender text , 
    Education text,  
    CurrentLocation text,
    HomeTown text

);

create table Weddings (
    WeddingID INTEGER PRIMARY KEY,
    Groom integer NOT NULL,
    Bride integer NOT NULL

);

create table WeddingEvents (
    EventID integer not NULL PRIMARY KEY,
    EventType TEXT NOT NULL CHECK (EventType IN ('Main', 'Reception')),
    EventDate Date not NULL ,
    EventStartTime time NOT NULL,
    EventEndTime time NOT NULL,
    Location text not NULL, 
    WeddingID INTEGER NOT NULL,
    MusicBandID INTEGER,
    CateringServiceID INTEGER,
    HallID INTEGER,
    FOREIGN KEY (WeddingID) REFERENCES Weddings(WeddingID),
    FOREIGN KEY (MusicBandID) REFERENCES MusicBands(MusicBandID),
    FOREIGN KEY (CateringServiceID) REFERENCES CateringServices(CateringServiceID),
    FOREIGN KEY (HallID) REFERENCES WeddingHalls(HallID)

);


CREATE TABLE CateringServices (
    CateringServiceID INTEGER NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Contact TEXT NOT NULL,
    Price REAL DEFAULT 0.0
);

CREATE TABLE MusicBands (
    MusicBandID INTEGER NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Genre TEXT,
    Contact TEXT NOT NULL,
    Price REAL DEFAULT 0.0
);


CREATE TABLE WeddingHalls (
    HallID INTEGER NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Location TEXT NOT NULL,
    Capacity INTEGER NOT NULL,
    Price REAL DEFAULT 0.0
);


CREATE TABLE InvitationCardTemplates (
    TemplateID INTEGER NOT NULL PRIMARY KEY,
    Theme TEXT,
    PoemOrText TEXT
);

CREATE TABLE InvitationCards (
    InvitationID INTEGER NOT NULL PRIMARY KEY,
    WeddingID INTEGER NOT NULL,
    TemplateID INTEGER NOT NULL,
    RecipientName TEXT,
    Note TEXT,
    FOREIGN KEY (WeddingID) REFERENCES Weddings(WeddingID),
    FOREIGN KEY (TemplateID) REFERENCES InvitationCardTemplates(TemplateID)
);


--- 1.2 populating the tables
insert into Users (Name, BirthDate, Gender, Education, CurrentLocation, Hometown)
values 
    ('John Doe', '1990-05-15', 'Male', 'Bachelor', 'New York', 'Los Angeles'),
    ('Jane Smith', '1985-10-20', 'Female', 'Master', 'Los Angeles', 'Chicago'),
    ('Alice Johnson', '1995-02-28', 'Female', 'Bachelor', 'Chicago', 'New York'),
    ('Michael Brown', '1982-09-10', 'Male', 'PhD', 'Houston', 'Dallas'),
    ('Emily Davis', '1993-07-05', 'Female', 'Bachelor', 'Miami', 'Orlando'),
    ('William Wilson', '1988-03-20', 'Male', 'Bachelor', 'Boston', 'Seattle'),
    ('Sophia Garcia', '1987-11-12', 'Female', 'Master', 'San Francisco', 'Los Angeles'),
    ('Jacob Martinez', '1992-06-30', 'Male', 'Bachelor', 'Dallas', 'San Antonio'),
    ('Olivia Anderson', '1986-04-18', 'Female', 'PhD', 'Chicago', 'New York'),
    ('Daniel Rodriguez', '1990-09-08', 'Male', 'Bachelor', 'Los Angeles', 'San Diego');
    
INSERT INTO Weddings (Groom, Bride)
VALUES
    (1, 2),
    (3, 4),
    (5, 6),
    (7, 8),
    (9, 10);
    


insert into CateringServices (Name, Contact, Price)
values 
    ('Delicious Catering', 'contact@deliciouscatering.com', 5000),
    ('Elegant Events Catering', 'info@elegantevents.com', 7500),
    ('Gourmet Galore Caterers', 'sales@gourmetgalore.com', 6000),
    ('Savor the Flavor Catering', 'hello@savortheflavor.com', 5500),
    ('Tasty Treats Catering', 'orders@tastytreats.com', 4800);
    
insert into MusicBands (Name, Genre, Contact, Price)
values
    ('The Wedding Singers', 'Pop, Rock', 'bookings@weddingsingers.com', 3000),
    ('Smooth Jazz Trio', 'Jazz', 'info@smoothjazztrio.com', 2500),
    ('Classical Ensemble', 'Classical', 'contact@classicalensemble.com', 2000),
    ('Salsa Rhythms Band', 'Latin', 'salsarhythms@gmail.com', 2800),
    ('Country Serenade', 'Country', 'bookings@countryserenade.com', 2200);

insert into WeddingHalls (Name, Location, Capacity, Price)
values
    ('Grand Ballroom', 'New York', 200, 8000),
    ('Garden Pavilion', 'Chicago', 150, 6000),
    ('Lakeview Terrace', 'Houston', 180, 7000),
    ('Oceanfront Hall', 'Miami', 250, 9000),
    ('Harbor View Room', 'Boston', 180, 7000);
    
--- Wedding Events must go after bands, halls and catering as they use their IDs
    
insert into WeddingEvents ( WeddingID, EventType, EventDate, EventStartTime, EventEndTime, Location, MusicBandID, CateringServiceID, HallID)
values
    (1, 'Main', '2024-06-15', '17:00', '18:00', 'New York City Hall', NULL, NULL, NULL),
    (1, 'Reception', '2024-06-15', '18:00', '20:00', 'Central Park', NULL, 1, 1),
    (2, 'Main', '2024-07-20', '16:00', '17:30', 'Chicago Botanic Garden', 1, 2, 2),
    (2, 'Reception', '2024-07-20', '18:00', '20:30', 'Chicago Botanic Garden', 2, 2, 2),
    (3, 'Main', '2024-08-25', '18:00', '19:00', 'Houston Country Club', NULL, 3, 3),
    (3, 'Reception', '2024-08-25', '19:00', '21:00', 'Houston Country Club', 3, 3, 3),
    (4, 'Main', '2024-09-30', '15:30', '17:00', 'Miami Beach Resort', NULL, 4, 4),
    (4, 'Reception', '2024-09-30', '17:30', '20:00', 'Miami Beach Resort', 4, 4, 4),
    (5, 'Main', '2024-10-05', '14:00', '15:30', 'Boston Harbor Hotel', NULL, 5, 5),
    (5, 'Reception', '2024-10-05', '16:00', '18:00', 'Boston Harbor Hotel', 5, 5, 5);
    
insert into InvitationCardTemplates (Theme, PoemOrText)
VALUES
    ('Classic Elegance', 'You are cordially invited to celebrate the union of...'),
    ('Rustic Charm', 'Join us for an intimate gathering to celebrate...'),
    ('Modern Minimalist', 'Save the date for the wedding of...'),
    ('Vintage Romance', 'Love is in the air! Join us for the wedding of...'),
    ('Tropical Paradise', 'Escape to paradise with us as we exchange vows...');

insert into InvitationCards (WeddingID, TemplateID, RecipientName, Note)
values
    (1, 1, 'Alice Johnson', 'Please join us in celebrating the wedding of John and Jane.'),
    (1, 1, 'Michael Brown', 'You are invited to witness the union of John and Jane.'),
    (2, 2, 'Andrew Wilson', 'Join us for an unforgettable evening of love and joy.'),
    (2, 2, 'Jessica Davis', 'You are cordially invited to the wedding of Emily and Michael.'),
    (3, 3, 'William Wilson', 'Save the date for the wedding of Emily and Michael.'),
    (3, 3, 'Sarah Lee', 'Join us in celebrating the love of Emily and Michael.'),
    (4, 4, 'Sophia Garcia', 'Please join us for a beachside wedding celebration.'),
    (4, 4, 'Jacob Martinez', 'You are invited to witness the marriage of Emily and Michael.'),
    (5, 5, 'Olivia Anderson', 'Join us as we celebrate the union of Emily and Michael.'),
    (5, 5, 'Daniel Rodriguez', 'You are cordially invited to the wedding of Emily and Michael.');
    
--- 1.3 updating queries
UPDATE CateringServices
SET Price = 5500.0
WHERE Name = 'Delicious Catering';

UPDATE MusicBands
SET Genre = 'Latin, Pop'
WHERE Name = 'Salsa Rhythms Band';

UPDATE Users
SET BirthDate = '1993-07-10'
WHERE UserID = 5;

--- 1.4 Deleting from tables

DELETE FROM WeddingEvents
WHERE Location = 'Miami Beach Resort';

DELETE FROM InvitationCards
WHERE TemplateID = 3;

DELETE FROM WeddingEvents
WHERE WeddingID = 3;

--- 1.5 Selecting from tablesdemo

select Name, Price from CateringServices;

Select Name, Genre from MusicBands;

Select EventType, EventDate from WeddingEvents;



--- TASK 2

--- 2.1 Triggers
CREATE TABLE IF NOT EXISTS UserAudit (
    AuditID INTEGER PRIMARY KEY,
    UserID INTEGER,
    Action TEXT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER UserUpdateAuditTrigger
    after UPDATE on Users
    BEGIN
       UserAudit
    END;
    
CREATE TRIGGER PreventDeleteCascadeTrigger
    Before delete on Weddings
    BEGIN
       	if OLD.Groom != NEW.Groom or OLD.Bride != NEW.Bride then 
       	RAISE_APPLICATION_ERROR('Cant delete Groom or Bride!')
    END;

CREATE TRIGGER EventConflictCheckTrigger
    Before INSERT on WeddingEvents
    BEGIN
    for EACH ROW CHECK
        if NEW.EventDate = EventDate then 
        NEW.eventstarttime < eventstarttime
        NEW.eventendtime < eventendtime
        ELSE
       	RAISE_APPLICATION_ERROR('Time slot already filled')
    END;
    
--- 2.2 Views

create view WeddingDetails as 
	select WeddingID, Groom, Bride
    FROM Weddings;
    
---TASK 3

SELECT u.Name, h.Location, h.Capacity
    FROM Users u
    JOIN Weddings w 
        ON u.UserID = w.Groom OR u.UserID = w.Bride
    JOIN WeddingEvents e 
        ON w.WeddingID = e.WeddingID
    JOIN WeddingHalls h 
        ON e.HallID = h.HallID
    WHERE e.EventType = 'Main';

SELECT u.Name AS UserName, mb.Name AS BandName
    FROM Users u
    JOIN Weddings w 
        ON u.UserID = w.Groom OR u.UserID = w.Bride
    JOIN WeddingEvents e 
        ON w.WeddingID = e.WeddingID
    JOIN MusicBands mb 
        ON e.MusicBandID = mb.MusicBandID
    WHERE e.EventType = 'Reception';




    
    


    





