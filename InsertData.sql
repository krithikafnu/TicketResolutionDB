-- 1. Departments Table
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('IT', 'John Smith');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Frontend', 'Alice Johnson');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Database', 'Robert Brown');

-- 2. Categories Table
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Database Issue', 3, 'Problems related to database performance or queries');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Frontend Bug', 2, 'UI/UX related issues');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('IT Support', 1, 'General IT department issues');

-- 3. Programmers Table
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('David', 'Lee', 'dlee@example.com', '555-1234', 3, 'Database Admin');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Sophia', 'Martinez', 'smartinez@example.com', '555-5678', 2, 'Frontend Developer');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Michael', 'Clark', 'mclark@example.com', '555-8765', 1, 'IT Support Engineer');

-- 4. Customers Table
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Emma', 'Wilson', 'ewilson@client.com', '555-1111', 'TechCorp');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('James', 'Taylor', 'jtaylor@client.com', '555-2222', 'FinServe');

-- 5. Tickets Table
INSERT INTO Tickets (Customer_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (1, 1, 3, 'Database Timeout', 'Customer reports frequent DB timeouts', 'HIGH');
INSERT INTO Tickets (Customer_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (2, 2, 2, 'UI Alignment Issue', 'Frontend buttons misaligned on dashboard', 'MEDIUM');

-- 6. EndUser_Tickets Table (Optional Many-to-Many)
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (1, 1);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (2, 2);

-- 7. Ticket_Comments Table (Optional)
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (1, 'Investigating database timeout issue', 'David Lee');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (2, 'UI bug replicated, working on fix', 'Sophia Martinez');

