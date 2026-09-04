-- RaceDay Database

-- Project Overview

RaceDay is a SQL Server database designed to manage running and racing events. It stores information about users, participants, organisers, routes, events, categories, enrolments, and race results.

-- Database Technology

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Database Name: RaceDay

-- Database Tables

The database contains 8 main tables:

1. `UserAccount` - Stores user account information.
2. `Participant` - Stores participant details.
3. `Organiser` - Stores organiser information.
4. `Route` - Stores race route information.
5. `Event` - Stores racing event information.
6. `Category` - Stores categories for each event.



-- Relationships

- `Participant` is linked to `UserAccount`.
- `Organiser` is linked to `UserAccount`.
- `Event` is linked to `Organiser`.
- `Event` is linked to `Route`.
- `Category` is linked to `Event`.
- `Enrolment` is linked to `Event`, `Participant`, and `Category`.
- `Result` is linked to `Enrolment`.

-- Database Features

The database uses:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints
- Default Constraints
- Identity Columns

-- Sample Data

The database contains sample data for:

- 2 Organisers
- 2 Participants
- 3 Routes
- 3 Events
- 6 Categories
- 4 Enrolments
- 2 Results

-- How to Run

1. Open SQL Server Management Studio.
2. Open the `RaceDay.sql` file.
3. Execute the database creation script.
4. Select the `RaceDay` database.
5. Execute the table creation statements.
6. Execute the sample data INSERT statements.


-- Database Verification

Use the following SQL statements to check the database:








