SELECT * FROM Tickets;
SELECT * FROM Programmers WHERE Department_ID = 3;
SELECT c.First_Name, t.Title, t.Status
FROM EndUser c
JOIN Tickets t ON c.EndUser_ID = t.EndUser_ID;
