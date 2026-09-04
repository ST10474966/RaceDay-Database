--RACEDAY DATABASE

CREATE DATABASE RaceDay;

USE RaceDay;

   --1. USER ACCOUNT

CREATE TABLE UserAccount
(
    UserId INT IDENTITY(1,1) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    EmailAddress VARCHAR(100) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    ImageUrl VARCHAR(255) NULL,
    Role VARCHAR(20) NOT NULL,

    CONSTRAINT PK_UserAccount PRIMARY KEY (UserId),
    CONSTRAINT UQ_UserAccount_Email UNIQUE (EmailAddress),
    CONSTRAINT CK_UserAccount_Role
        CHECK (Role IN ('Participant', 'Organiser'))
);

   --2. PARTICIPANT


CREATE TABLE Participant
(
    UserId INT NOT NULL,
    Gender VARCHAR(20) NOT NULL,
    Age INT NOT NULL,

    CONSTRAINT PK_Participant PRIMARY KEY (UserId),

    CONSTRAINT FK_Participant_UserAccount
        FOREIGN KEY (UserId)
        REFERENCES UserAccount(UserId),

    CONSTRAINT CK_Participant_Age
        CHECK (Age >= 18)
);

   --3. ORGANISER
 

CREATE TABLE Organiser
(
    UserId INT NOT NULL,
    AccessLevel VARCHAR(30) NOT NULL
        CONSTRAINT DF_Organiser_AccessLevel
        DEFAULT ('Standard'),

    CONSTRAINT PK_Organiser PRIMARY KEY (UserId),

    CONSTRAINT FK_Organiser_UserAccount
        FOREIGN KEY (UserId)
        REFERENCES UserAccount(UserId)
);

   --4. ROUTE


CREATE TABLE Route
(
    RouteId INT IDENTITY(1,1) NOT NULL,
    RouteName VARCHAR(100) NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    ImageUrl VARCHAR(255) NULL,

    CONSTRAINT PK_Route PRIMARY KEY (RouteId),

    CONSTRAINT CK_Route_Distance
        CHECK (Distance > 0)
);

   --5. EVENT
  

CREATE TABLE Event
(
    EventId INT IDENTITY(1,1) NOT NULL,
    UserId INT NOT NULL,
    RouteId INT NOT NULL,
    Title VARCHAR(120) NOT NULL,
    Description VARCHAR(500) NULL,
    StartLocation VARCHAR(150) NOT NULL,
    EndLocation VARCHAR(150) NOT NULL,
    StartTime TIME NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    EventDate DATE NOT NULL,
    ImageUrl VARCHAR(255) NULL,

    CONSTRAINT PK_Event PRIMARY KEY (EventId),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (UserId)
        REFERENCES Organiser(UserId),

    CONSTRAINT FK_Event_Route
        FOREIGN KEY (RouteId)
        REFERENCES Route(RouteId),

    CONSTRAINT CK_Event_Distance
        CHECK (Distance > 0)
);

   --6. CATEGORY

CREATE TABLE Category
(
    CategoryId INT IDENTITY(1,1) NOT NULL,
    EventId INT NOT NULL,
    Title VARCHAR(80) NOT NULL,
    Description VARCHAR(255) NULL,

    CONSTRAINT PK_Category PRIMARY KEY (CategoryId),

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventId)
        REFERENCES Event(EventId),

    CONSTRAINT UQ_Category_Event_Title
        UNIQUE (EventId, Title)
);

   --7. ENROLMENT
  

CREATE TABLE Enrolment
(
    EnrolmentId INT IDENTITY(1,1) NOT NULL,
    EventId INT NOT NULL,
    UserId INT NOT NULL,
    CategoryId INT NOT NULL,
    CreatedAt DATETIME NOT NULL
        CONSTRAINT DF_Enrolment_CreatedAt
        DEFAULT (GETDATE()),

    CONSTRAINT PK_Enrolment PRIMARY KEY (EnrolmentId),

    CONSTRAINT FK_Enrolment_Event
        FOREIGN KEY (EventId)
        REFERENCES Event(EventId),

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (UserId)
        REFERENCES Participant(UserId),

    CONSTRAINT FK_Enrolment_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId),

    CONSTRAINT UQ_Enrolment_Participant_Category
        UNIQUE (UserId, CategoryId)
);

   --8. RESULT

CREATE TABLE Result
(
    ResultsId INT IDENTITY(1,1) NOT NULL,
    EnrolmentId INT NOT NULL,
    Time TIME NULL,

    CONSTRAINT PK_Result PRIMARY KEY (ResultsId),

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentId)
        REFERENCES Enrolment(EnrolmentId),

    CONSTRAINT UQ_Result_Enrolment
        UNIQUE (EnrolmentId)
);

  -- SAMPLE DATA
  
   --USER ACCOUNTS
   --2 Organisers + 2 Participants
  

INSERT INTO UserAccount
(
    FirstName,
    LastName,
    EmailAddress,
    Password,
    ImageUrl,
    Role
)
VALUES
(
    'Thabo',
    'Mokoena',
    'thabo@raceday.co.za',
    'Password123',
    'images/thabo.jpg',
    'Organiser'
),
(
    'Lerato',
    'Dlamini',
    'lerato@raceday.co.za',
    'Password123',
    'images/lerato.jpg',
    'Organiser'
),
(
    'Sipho',
    'Nkosi',
    'sipho@gmail.com',
    'Password123',
    'images/sipho.jpg',
    'Participant'
),
(
    'Amahle',
    'Khumalo',
    'amahle@gmail.com',
    'Password123',
    'images/amahle.jpg',
    'Participant'
);

   --PARTICIPANTS
  
INSERT INTO Participant
(
    UserId,
    Gender,
    Age
)
VALUES
(
    3,
    'Male',
    24
),
(
    4,
    'Female',
    23
);

   --ORGANISERS

INSERT INTO Organiser
(
    UserId,
    AccessLevel
)
VALUES
(
    1,
    'Admin'
),
(
    2,
    'Standard'
);

   --ROUTES

INSERT INTO Route
(
    RouteName,
    Location,
    Distance,
    ImageUrl
)
VALUES
(
    'Pretoria City Route',
    'Pretoria',
    10.00,
    'images/pretoria-route.jpg'
),
(
    'Soweto Route',
    'Soweto',
    20.00,
    'images/soweto-route.jpg'
),
(
    'Cape Town Coastal Route',
    'Cape Town',
    15.00,
    'images/cape-town-route.jpg'
);

   --EVENTS
   --3 EVENTS

INSERT INTO Event
(
    UserId,
    RouteId,
    Title,
    Description,
    StartLocation,
    EndLocation,
    StartTime,
    Distance,
    EventDate,
    ImageUrl
)
VALUES
(
    1,
    1,
    'Pretoria Spring Run',
    'Annual running event in Pretoria.',
    'Pretoria CBD',
    'Union Buildings',
    '07:00',
    10.00,
    '2027-09-05',
    'images/pretoria-run.jpg'
),
(
    2,
    2,
    'Soweto Challenge',
    'Community running event in Soweto.',
    'Soweto Stadium',
    'Vilakazi Street',
    '06:30',
    20.00,
    '2027-10-17',
    'images/soweto-run.jpg'
),
(
    1,
    3,
    'Cape Town Coastal Run',
    'Scenic running event along the coast.',
    'Sea Point',
    'Camps Bay',
    '07:30',
    15.00,
    '2027-11-21',
    'images/cape-town-run.jpg'
);

   --CATEGORIES
   --CATEGORIES FOR EACH EVENT

INSERT INTO Category
(
    EventId,
    Title,
    Description
)
VALUES
(
    1,
    '5 KM Fun Run',
    'Short recreational running category.'
),
(
    1,
    '10 KM Run',
    'Competitive 10 kilometre running category.'
),
(
    2,
    '10 KM Challenge',
    'Intermediate running category.'
),
(
    2,
    '20 KM Challenge',
    'Advanced running category.'
),
(
    3,
    '5 KM Coastal Walk',
    'Short scenic coastal category.'
),
(
    3,
    '15 KM Coastal Run',
    'Long coastal running category.'
);

   --ENROLMENTS

INSERT INTO Enrolment
(
    EventId,
    UserId,
    CategoryId
)
VALUES
(
    1,
    3,
    1
),
(
    1,
    4,
    2
),
(
    2,
    3,
    3
),
(
    3,
    4,
    5
);

   --RESULTS
  

INSERT INTO Result
(
    EnrolmentId,
    Time
)
VALUES
(
    1,
    '00:32:15'
),
(
    2,
    '01:05:30'
);

   --CHECK THE DATABASE
 

SELECT * FROM UserAccount;
SELECT * FROM Participant;
SELECT * FROM Organiser;
SELECT * FROM Route;
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Enrolment;
SELECT * FROM Result;

