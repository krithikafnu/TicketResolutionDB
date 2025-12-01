-- 1. Departments Table
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('IT', 'John Smith');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Frontend', 'Alice Johnson');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Database', 'Robert Brown');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Backend', 'Linda Green');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('DevOps', 'Kevin White');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Quality Assurance', 'Maria Lopez');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Customer Support', 'Daniel King');
INSERT INTO Departments (Department_Name, Department_Head)
VALUES ('Security', 'Olivia Harris');


-- 2. Categories Table
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Database Issue', 3, 'Problems related to database performance or queries');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Frontend Bug', 2, 'UI/UX related issues');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('IT Support', 1, 'General IT department issues');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Login Issue', 2, 'Problems related to login, authentication, or session handling');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Network Issue', 1, 'VPN, connectivity, or internal network-related issues');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Data Inconsistency', 3, 'Mismatched or corrupted data in database tables');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Configuration Issue', 1, 'Misconfigured applications, services, or environments');
INSERT INTO ProblemCategories (Category_Name, Department_ID, Description)
VALUES ('Accessibility Bug', 2, 'UI accessibility problems impacting usability');

-- 3. Programmers Table
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('David', 'Lee', 'dlee@example.com', '555-1234', 3, 'Database Admin');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Sophia', 'Martinez', 'smartinez@example.com', '555-5678', 2, 'Frontend Developer');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Michael', 'Clark', 'mclark@example.com', '555-8765', 1, 'IT Support Engineer');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Karen', 'Wong', 'kwong@example.com', '555-3333', 2, 'Frontend Developer');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Thomas', 'Young', 'tyoung@example.com', '555-4444', 3, 'Database Engineer');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Laura', 'Adams', 'ladams@example.com', '555-5555', 1, 'IT Support Analyst');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Brian', 'Scott', 'bscott@example.com', '555-6666', 2, 'UI Engineer');
INSERT INTO Programmers (First_Name, Last_Name, Email, Phone, Department_ID, Role)
VALUES ('Priya', 'Patel', 'ppatel@example.com', '555-7777', 3, 'Data Engineer');

-- 4. Customers Table
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Emma', 'Wilson', 'ewilson@client.com', '555-1111', 'TechCorp');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('James', 'Taylor', 'jtaylor@client.com', '555-2222', 'FinServe');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Olivia', 'Brown', 'obrown@client.com', '555-3333', 'HealthPlus');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Liam', 'Anderson', 'landerson@client.com', '555-4444', 'RetailHub');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Noah', 'Davis', 'ndavis@client.com', '555-5555', 'FinCore');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Ava', 'Miller', 'amiller@client.com', '555-6666', 'EduSmart');
INSERT INTO EndUser (First_Name, Last_Name, Email, Phone, Company_Name)
VALUES ('Ethan', 'Johnson', 'ejohnson@client.com', '555-7777', 'LogiTrans');


-- 5. Tickets Table
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (1, 1, 3, 'Database Timeout', 'Customer reports frequent DB timeouts', 'HIGH');
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (2, 2, 2, 'UI Alignment Issue', 'Frontend buttons misaligned on dashboard', 'MEDIUM');
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (1, 2, 2, 'Button Click Not Working', 'User reports dashboard buttons not triggering actions', 'HIGH');
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (3, 1, 3, 'Slow Reporting Queries', 'Long-running queries on analytics reports', 'MEDIUM');
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (4, 3, 1, 'VPN Connection Drops', 'User frequently disconnected from VPN during work', 'CRITICAL');
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (5, 2, 2, 'Text Overlapping on Mobile', 'UI text overlaps on small mobile screens', 'LOW');
INSERT INTO Tickets (EndUser_ID, Category_ID, Department_ID, Title, Description, Priority)
VALUES (6, 3, 1, 'Password Reset Email Not Received', 'Password reset emails not reaching inbox', 'MEDIUM');


-- 6. EndUser_Tickets Table (Optional Many-to-Many)
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (1, 1);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (2, 2);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (3, 3);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (4, 4);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (5, 5);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (6, 6);
INSERT INTO EndUserTickets (EndUser_ID, Ticket_ID)
VALUES (7, 7);


-- 7. Ticket_Comments Table (Optional)
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (1, 'Investigating database timeout issue', 'David Lee');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (2, 'UI bug replicated, working on fix', 'Sophia Martinez');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (1, 'Indexed critical tables to help reduce timeout issues.', 'David Lee');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (3, 'Analyzing execution plan for slow reporting queries.', 'Thomas Young');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (4, 'User provided VPN logs, investigating network stability.', 'Michael Clark');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (5, 'Reproduced layout bug on iPhone simulator, working on CSS fix.', 'Sophia Martinez');
INSERT INTO Ticket_Comments (Ticket_ID, Comment_Text, Commented_By)
VALUES (6, 'Checked SMTP logs, password reset emails are being rate-limited.', 'Laura Adams');

