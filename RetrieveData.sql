-- Get all the data from Tickets table
SELECT * FROM Tickets;

-- Show all departments with their heads.
SELECT Department_ID, Department_Name, Department_Head, Created_At
FROM Departments;

-- Get the programmers that belong to department 3
SELECT * FROM Programmers WHERE Department_ID = 3;

-- Get selective columns data from endusers and tickets table based on the endusers who raised the tickets. 
SELECT c.First_Name, t.Title, t.Status
FROM EndUser c
JOIN Tickets t ON c.EndUser_ID = t.EndUser_ID;

-- List all tickets with HIGH or CRITICAL priority, newest first.
SELECT Ticket_ID, Title, Priority, Status, Created_At
FROM Tickets
WHERE Priority IN ('HIGH', 'CRITICAL')
ORDER BY Created_At DESC;

--Show full name and email of programmers in the 'Database' department.
SELECT p.Programmer_ID,
       p.First_Name || ' ' || p.Last_Name AS Programmer_Name,
       p.Email
FROM Programmers p
JOIN Departments d ON p.Department_ID = d.Department_ID
WHERE d.Department_Name = 'Database';

-- List ticket title, status and EndUser full name.
SELECT t.Ticket_ID,
       t.Title,
       t.Status,
       e.First_Name || ' ' || e.Last_Name AS EndUser_Name
FROM Tickets t
JOIN EndUser e ON t.EndUser_ID = e.EndUser_ID;

-- Count how many tickets are in each status.
SELECT Status, COUNT(*) AS Ticket_Count
FROM Tickets
GROUP BY Status;

-- Count tickets per department, showing department name.
SELECT d.Department_Name,
       COUNT(t.Ticket_ID) AS Ticket_Count
FROM Departments d
LEFT JOIN Tickets t ON d.Department_ID = t.Department_ID
GROUP BY d.Department_Name;

--Find tickets that have not been assigned to any programmer.
SELECT Ticket_ID, Title, Status, Priority
FROM Tickets
WHERE Assigned_Programmer_ID IS NULL;

--List programmers who have never been assigned a ticket.
SELECT p.Programmer_ID,
       p.First_Name || ' ' || p.Last_Name AS Programmer_Name
FROM Programmers p
WHERE NOT EXISTS (
    SELECT 1
    FROM Tickets t
    WHERE t.Assigned_Programmer_ID = p.Programmer_ID
);


--Show all comments for the ticket titled 'Database Timeout'.
SELECT c.Comment_ID,
       c.Comment_Text,
       c.Commented_By,
       c.Created_At
FROM Ticket_Comments c
WHERE c.Ticket_ID = (
    SELECT Ticket_ID
    FROM Tickets
    WHERE Title = 'Database Timeout'
);


-- List departments that currently have no programmers.
-- Can do it in 2 ways 
--1.
SELECT d.Department_ID, d.Department_Name
FROM Departments d
LEFT JOIN Programmers p ON d.Department_ID = p.Department_ID
WHERE p.Programmer_ID IS NULL;
--2.
SELECT d.Department_ID, d.Department_Name
FROM Departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM Programmers p
    WHERE p.Department_ID = d.Department_ID
);

--Show tickets with their category name and department name.
SELECT t.Ticket_ID,
       t.Title,
       pc.Category_Name,
       d.Department_Name,
       t.Status,
       t.Priority
FROM Tickets t
JOIN ProblemCategories pc ON t.Category_ID = pc.Category_ID
JOIN Departments d ON t.Department_ID = d.Department_ID;

-- Find EndUsers who have raised more than 2 tickets.
SELECT e.EndUser_ID,
       e.First_Name || ' ' || e.Last_Name AS EndUser_Name,
       COUNT(t.Ticket_ID) AS Ticket_Count
FROM EndUser e
JOIN Tickets t ON e.EndUser_ID = t.EndUser_ID
GROUP BY e.EndUser_ID, e.First_Name, e.Last_Name
HAVING COUNT(t.Ticket_ID) > 2;

-- For each department, find the earliest created ticket.
SELECT t.Ticket_ID,
       t.Title,
       t.Department_ID,
       t.Created_At
FROM Tickets t
WHERE t.Created_At = (
    SELECT MIN(t2.Created_At)
    FROM Tickets t2
    WHERE t2.Department_ID = t.Department_ID
);

-- List tickets that were resolved on the same calendar day they were created.
SELECT Ticket_ID, Title, Created_At, Resolved_At
FROM Tickets
WHERE Resolved_At IS NOT NULL
  AND TRUNC(Created_At) = TRUNC(Resolved_At);

-- Retrieve a unified list of all email addresses (Programmers + EndUsers).
SELECT Email, 'PROGRAMMER' AS Source
FROM Programmers
WHERE Email IS NOT NULL

UNION

SELECT Email, 'ENDUSER' AS Source
FROM EndUser
WHERE Email IS NOT NULL;

-- Find tickets whose description contains the word timeout (case-insensitive).
SELECT Ticket_ID, Title, Description
FROM Tickets
WHERE LOWER(Description) LIKE '%timeout%';

-- or 
SELECT Ticket_ID, Title, Description
FROM Tickets
WHERE INSTR(LOWER(Description), 'timeout') > 0;

-- For each ticket, get its latest comment.
SELECT Ticket_ID,
       Comment_ID,
       Comment_Text,
       Commented_By,
       Created_At
FROM (
    SELECT c.*,
           ROW_NUMBER() OVER (PARTITION BY Ticket_ID ORDER BY Created_At DESC) AS rn
    FROM Ticket_Comments c
) x
WHERE x.rn = 1;

-- Compute average resolution time in days per department.
SELECT d.Department_Name,
       AVG(Resolved_At - Created_At) AS Avg_Resolution_Days
FROM Tickets t
JOIN Departments d ON t.Department_ID = d.Department_ID
WHERE t.Resolved_At IS NOT NULL
GROUP BY d.Department_Name;

-- List tickets that have never received any comment.
SELECT t.Ticket_ID, t.Title, t.Status
FROM Tickets t
WHERE NOT EXISTS (
    SELECT 1
    FROM Ticket_Comments c
    WHERE c.Ticket_ID = t.Ticket_ID
);

-- Show all categories that belong to the same department as the 'Frontend Bug' category.
SELECT Category_ID, Category_Name
FROM ProblemCategories
WHERE Department_ID = (
    SELECT Department_ID
    FROM ProblemCategories
    WHERE Category_Name = 'Frontend Bug'
);

-- For each EndUser, show counts of tickets by priority.
SELECT e.EndUser_ID,
       e.First_Name || ' ' || e.Last_Name AS EndUser_Name,
       SUM(CASE WHEN t.Priority = 'LOW' THEN 1 ELSE 0 END) AS Low_Count,
       SUM(CASE WHEN t.Priority = 'MEDIUM' THEN 1 ELSE 0 END) AS Medium_Count,
       SUM(CASE WHEN t.Priority = 'HIGH' THEN 1 ELSE 0 END) AS High_Count,
       SUM(CASE WHEN t.Priority = 'CRITICAL' THEN 1 ELSE 0 END) AS Critical_Count
FROM EndUser e
LEFT JOIN Tickets t ON e.EndUser_ID = t.EndUser_ID
GROUP BY e.EndUser_ID, e.First_Name, e.Last_Name;

-- List all programmers and how many tickets have been assigned to each.
SELECT p.Programmer_ID,
       p.First_Name || ' ' || p.Last_Name AS Programmer_Name,
       COUNT(t.Ticket_ID) AS Assigned_Ticket_Count
FROM Programmers p
LEFT JOIN Tickets t ON p.Programmer_ID = t.Assigned_Programmer_ID
GROUP BY p.Programmer_ID, p.First_Name, p.Last_Name;

-- Show tickets in the Database department with corresponding EndUser names.
SELECT t.Ticket_ID,
       t.Title,
       t.Status,
       e.First_Name || ' ' || e.Last_Name AS EndUser_Name
FROM Tickets t
JOIN Departments d ON t.Department_ID = d.Department_ID
JOIN EndUser e ON t.EndUser_ID = e.EndUser_ID
WHERE d.Department_Name = 'Database';

-- Find EndUsers who have tickets assigned to programmers in the Database department.
SELECT DISTINCT e.EndUser_ID,
       e.First_Name || ' ' || e.Last_Name AS EndUser_Name
FROM EndUser e
JOIN Tickets t ON e.EndUser_ID = t.EndUser_ID
JOIN Programmers p ON t.Assigned_Programmer_ID = p.Programmer_ID
JOIN Departments d ON p.Department_ID = d.Department_ID
WHERE d.Department_Name = 'Database';

-- List tickets that have at least one comment from 'David Lee'.
SELECT t.Ticket_ID, t.Title, t.Status
FROM Tickets t
WHERE EXISTS (
    SELECT 1
    FROM Ticket_Comments c
    WHERE c.Ticket_ID = t.Ticket_ID
      AND c.Commented_By = 'David Lee'
);

-- Add an Urgency_Level column derived from priority.
SELECT Ticket_ID,
       Title,
       Priority,
       CASE
           WHEN Priority = 'CRITICAL' THEN 'Very High'
           WHEN Priority = 'HIGH'     THEN 'High'
           WHEN Priority = 'MEDIUM'   THEN 'Normal'
           ELSE 'Low'
       END AS Urgency_Level
FROM Tickets;

-- Show open tickets as NEEDS_ATTENTION and resolved tickets older than 30 days as ARCHIVED
SELECT Ticket_ID,
       Title,
       Status,
       'NEEDS_ATTENTION' AS Category
FROM Tickets
WHERE Status IN ('OPEN', 'IN PROGRESS')

UNION

SELECT Ticket_ID,
       Title,
       Status,
       'ARCHIVED' AS Category
FROM Tickets
WHERE Status IN ('RESOLVED', 'CLOSED')
  AND Resolved_At IS NOT NULL
  AND Resolved_At < SYSDATE - 30;

-- Show all tickets with programmer name if assigned, otherwise 'Unassigned'.
SELECT t.Ticket_ID,
       t.Title,
       NVL(p.First_Name || ' ' || p.Last_Name, 'Unassigned') AS Assigned_To,
       t.Status
FROM Tickets t
LEFT JOIN Programmers p ON t.Assigned_Programmer_ID = p.Programmer_ID;

-- Find departments that are under-staffed: open tickets count greater than number of programmers.
SELECT d.Department_ID,
       d.Department_Name,
       COUNT(CASE WHEN t.Status NOT IN ('RESOLVED', 'CLOSED') THEN 1 END) AS Open_Tickets,
       (SELECT COUNT(*)
        FROM Programmers p
        WHERE p.Department_ID = d.Department_ID) AS Programmer_Count
FROM Departments d
LEFT JOIN Tickets t ON d.Department_ID = t.Department_ID
GROUP BY d.Department_ID, d.Department_Name
HAVING COUNT(CASE WHEN t.Status NOT IN ('RESOLVED', 'CLOSED') THEN 1 END) >
       (SELECT COUNT(*)
        FROM Programmers p
        WHERE p.Department_ID = d.Department_ID);

-- For each EndUser, rank their tickets by Created_At (latest = 1).
SELECT EndUser_ID,
       Ticket_ID,
       Title,
       Created_At,
       ROW_NUMBER() OVER (
           PARTITION BY EndUser_ID
           ORDER BY Created_At DESC
       ) AS Ticket_Rank
FROM Tickets;
