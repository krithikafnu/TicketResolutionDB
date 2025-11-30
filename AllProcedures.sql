CREATE OR REPLACE PROCEDURE Raise_A_Ticket (
    p_enduser_id   IN NUMBER,
    p_title         IN VARCHAR2,
    p_description   IN VARCHAR2,
    p_priority      IN VARCHAR2,
    p_department_id IN NUMBER,
    p_category_id   IN NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Validate Priority
    IF UPPER(p_priority) NOT IN ('LOW','MEDIUM','HIGH','CRITICAL') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Priority not handled by this application.');
    END IF;

    -- Validate Department
    SELECT COUNT(*) INTO v_count
    FROM Departments
    WHERE Department_ID = p_department_id;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Department not handled by this application.');
    END IF;

    -- Validate Category
    SELECT COUNT(*) INTO v_count
    FROM ProblemCategories
    WHERE Category_ID = p_category_id
      AND Department_ID = p_department_id;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Category not handled by this application.');
    END IF;

    -- Insert Ticket
    INSERT INTO Tickets (
        EndUser_ID, Category_ID, Department_ID,
        Title, Description, Priority, Status, Created_At
    ) VALUES (
        p_enduser_id, p_category_id, p_department_id,
        p_title, p_description, UPPER(p_priority), 'OPEN', SYSDATE
    );

    DBMS_OUTPUT.PUT_LINE('Ticket successfully raised.');
END Raise_A_Ticket;
/



CREATE OR REPLACE PROCEDURE Resolve_Ticket (
    p_programmer_id IN NUMBER,
    p_new_status    IN VARCHAR2
) AS
    v_ticket_id NUMBER;
    v_department_id NUMBER;
    v_count NUMBER;
BEGIN
    -- Validate Status
    IF UPPER(p_new_status) NOT IN ('OPEN','IN PROGRESS','RESOLVED','CLOSED') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Status not handled by this application.');
    END IF;

    -- Get Programmer's Department
    SELECT Department_ID INTO v_department_id
    FROM Programmers
    WHERE Programmer_ID = p_programmer_id;

    -- Fetch First Unresolved Ticket
    SELECT Ticket_ID INTO v_ticket_id
    FROM Tickets
    WHERE Department_ID = v_department_id
      AND Status NOT IN ('RESOLVED','CLOSED')
    ORDER BY Created_At
    FETCH FIRST 1 ROWS ONLY;

    -- Update Ticket
    UPDATE Tickets
    SET Status = UPPER(p_new_status),
        Assigned_Programmer_ID = p_programmer_id,
        Resolved_At = CASE WHEN UPPER(p_new_status) IN ('RESOLVED','CLOSED') THEN SYSDATE ELSE NULL END
    WHERE Ticket_ID = v_ticket_id;

    -- Insert into Programmer-Ticket Mapping
    INSERT INTO Customer_Tickets (EndUser_ID, Ticket_ID)
    SELECT EndUser_ID, v_ticket_id
    FROM Tickets
    WHERE Ticket_ID = v_ticket_id;

    DBMS_OUTPUT.PUT_LINE('Ticket ' || v_ticket_id || ' updated to status ' || p_new_status);
END Resolve_Ticket;
/


-- Customer raises a ticket
BEGIN
    Raise_A_Ticket(
        p_customer_id   => 1,
        p_title         => 'Database Timeout',
        p_description   => 'Frequent timeouts during queries',
        p_priority      => 'HIGH',
        p_department_id => 3,
        p_category_id   => 1
    );
END;
/

-- Programmer resolves a ticket
BEGIN
    Resolve_Ticket(
        p_programmer_id => 1,
        p_new_status    => 'Resolved'
    );
END;
/
