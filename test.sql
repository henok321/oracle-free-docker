SET SERVEROUTPUT ON;

DROP TABLE PERSON;

-- create table
CREATE TABLE PERSON
(
    ID      NUMBER(10)    NOT NULL,
    NAME    VARCHAR2(100) NOT NULL,
    CREATED DATE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PERSON_PK PRIMARY KEY (ID)
);

-- add test data
INSERT INTO PERSON (ID, NAME, CREATED)
VALUES (1, 'John', DEFAULT);
INSERT INTO PERSON (ID, NAME, CREATED)
VALUES (2, 'Mary', DEFAULT);

COMMIT;


-- iterate over cursor with while loop
DECLARE
    CURSOR c_person IS
        SELECT "ID", "NAME", "CREATED"
        FROM PERSON;
    v_person_data c_person%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Start...');
    OPEN c_person;
    FETCH c_person into v_person_data;
    WHILE c_person%FOUND
        loop
            DBMS_OUTPUT.PUT_LINE(v_person_data."NAME" || ' ' || v_person_data."CREATED");
            FETCH c_person into v_person_data;
        end loop;
    close c_person;
    commit;
END;
/

-- iterate over cursor with for loop
DECLARE
    CURSOR c_person IS
        SELECT "ID", "NAME", "CREATED"
        FROM PERSON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Start...');
    FOR v_person_data IN c_person
        loop
            DBMS_OUTPUT.PUT_LINE(v_person_data."NAME" || ' ' || v_person_data."CREATED");
        end loop;
    commit;
END;
/