DROP SEQUENCE LOGS#_SEQ;

--Creating a sequence for logs table
CREATE SEQUENCE LOGS#_SEQ
INCREMENT BY 1
START WITH 100;

--Trigger for inserting into logs when a student is enrolled for a class
CREATE OR REPLACE TRIGGER STUDENT_ENROLLED
BEFORE INSERT ON enrollments
FOR EACH ROW
DECLARE
	value1 varchar(10);
	keyvalue varchar(10);
BEGIN
	SELECT USER INTO value1 
	from dual;
	keyvalue := :NEW.B# || ',' || :NEW.classid;
	INSERT INTO logs VALUES (LOGS#_SEQ.nextval, value1, sysdate, 'Enrollments', 'Insert', keyvalue);
END;  
/

--Trigger for inserting into logs when a student is dropped from a class
CREATE OR REPLACE TRIGGER STUDENT_DELETED
BEFORE DELETE ON enrollments
FOR EACH ROW
DECLARE
	value1 varchar(20);
	keyvalue varchar(20);
BEGIN
	SELECT USER INTO value1 from dual;
	keyvalue := :OLD.B# || ',' || :OLD.classid;
	INSERT INTO logs VALUES (LOGS#_SEQ.nextval, value1, sysdate, 'Enrollments', 'Delete', keyvalue);
END;  
/

--Trigger for inserting into logs when a student is deleted
CREATE OR REPLACE TRIGGER STUDENT_DROPPED
BEFORE DELETE ON students
FOR EACH ROW
DECLARE
	value1 varchar(20);
BEGIN
	SELECT USER INTO value1 from dual;
	INSERT INTO logs VALUES (LOGS#_SEQ.nextval, value1, sysdate, 'Students', 'Delete', :OLD.B#);
END;  
/