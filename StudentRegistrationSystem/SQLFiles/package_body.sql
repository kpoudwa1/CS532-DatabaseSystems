CREATE OR REPLACE PACKAGE BODY SRS 
AS
  --Procedure for displaying the STUDENTS table 
  PROCEDURE SHOW_STUDENTS (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   STUDENTS ORDER BY B#; 
  END; 
  
  --Procedure for displaying the TAs table
  PROCEDURE SHOW_TAS (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   TAS ORDER BY B#; 
  END; 
  
  --Procedure for displaying the COURSES table
  PROCEDURE SHOW_COURSES (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   COURSES; 
  END; 
  
  --Procedure for displaying the CLASSES table
  PROCEDURE SHOW_CLASSES (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   CLASSES ORDER BY CLASSID; 
  END; 
  
  --Procedure for displaying the ENROLLMENTS table
  PROCEDURE SHOW_ENROLLMENTS (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   ENROLLMENTS ORDER BY B#, CLASSID; 
  END; 
  
  --Procedure for displaying the PREREQUISITES table
  PROCEDURE SHOW_PREREQUISITES (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   PREREQUISITES; 
  END; 
  
  --Procedure for displaying the LOGS table
  PROCEDURE SHOW_LOGS (OUTCURSOR OUT REF_CURSOR) 
  IS 
  BEGIN 
      OPEN OUTCURSOR FOR 
        SELECT * 
        FROM   LOGS ORDER BY LOG#; 
  END; 
  
  --Procedure for getting the TA for a class
  PROCEDURE GET_TA_FOR_CLASS(CLASSID_IN IN CLASSES.CLASSID%TYPE, 
                             OUTCURSOR  OUT REF_CURSOR) 
  AS 
    TEMP_B_NO CLASSES.TA_B#%TYPE; 
    INVALID_TA EXCEPTION; 
  BEGIN 
  
	  --Check if the class id is valid
      BEGIN 
          SELECT TA_B# 
          INTO   TEMP_B_NO 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The classid is invalid.'); 
            RETURN; 
      END; 

	  --Get the TA details from the STUDENTS table
      BEGIN 
          IF TEMP_B_NO IS NOT NULL THEN 
            OPEN OUTCURSOR FOR 
              SELECT B#, 
                     FIRST_NAME, 
                     LAST_NAME 
              FROM   STUDENTS 
              WHERE  B# = TEMP_B_NO; 
          ELSE 
            RAISE INVALID_TA; 
          END IF; 
      EXCEPTION 
          WHEN INVALID_TA THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The class has no TA.'); 
            RETURN; 
      END;
	  
  END; 
  
  --Procedure for getting the prerequisites for a course
  PROCEDURE GET_PREREQUISITE (DEPT_CODE_IN IN PREREQUISITES.DEPT_CODE%TYPE, 
                              COURSE#_IN   IN PREREQUISITES.COURSE#%TYPE, 
                              OUTCURSOR    OUT REF_CURSOR) 
  AS 
    PRE_DEPT_CODE_TEMP PREREQUISITES.PRE_DEPT_CODE%TYPE; 
    PRE_COURSE#_TEMP   PREREQUISITES.PRE_COURSE#%TYPE; 
  BEGIN
  
	  --Check if the given course is valid or not
      BEGIN 
          SELECT DEPT_CODE, 
                 COURSE# 
          INTO   PRE_DEPT_CODE_TEMP, PRE_COURSE#_TEMP 
          FROM   COURSES 
          WHERE  DEPT_CODE = DEPT_CODE_IN 
                 AND COURSE# = COURSE#_IN; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, DEPT_CODE_IN 
                                            || COURSE#_IN 
                                            || ' does not exist.'); 
            RETURN; 
      END; 

	  --Get the prerequisites for the course
      BEGIN 
          OPEN OUTCURSOR FOR 
            WITH N (PRE_DEPT_CODE, PRE_COURSE#, DEPT_CODE, COURSE#) 
                 AS (SELECT PRE_DEPT_CODE, 
                            PRE_COURSE#, 
                            DEPT_CODE, 
                            COURSE# 
                     FROM   PREREQUISITES 
                     WHERE  DEPT_CODE = DEPT_CODE_IN 
                            AND COURSE# = COURSE#_IN 
                     UNION ALL 
                     SELECT P.PRE_DEPT_CODE, 
                            P.PRE_COURSE#, 
                            P.DEPT_CODE, 
                            P.COURSE# 
                     FROM   PREREQUISITES P 
                            INNER JOIN N N 
                                    ON N.PRE_DEPT_CODE = P.DEPT_CODE 
                                       AND N.PRE_COURSE# = P.COURSE#) 
            SELECT CONCAT(PRE_DEPT_CODE, PRE_COURSE#) 
            FROM   N; 
      END; 
	  
  END; 
  
  --Procedure for enrolling a student for a class
  PROCEDURE ENROLL_STUDENT(B#_IN      IN STUDENTS.B#%TYPE, 
                           CLASSID_IN IN CLASSES.CLASSID%TYPE) 
  AS 
    B#_TEMP                  STUDENTS.B#%TYPE; 
    CLASSID_TEMP             CLASSES.CLASSID%TYPE; 
    DUPLICATE_ENROLL         NUMBER; 
    SEATS_AVAILABLE          NUMBER; 
    CURRENT_COURSES_COUNT    NUMBER; 
    DEPT_CODE_TEMP           CLASSES.DEPT_CODE%TYPE; 
    COURSE#_TEMP             CLASSES.COURSE#%TYPE; 
    NOT_SATISIFED_PRECOURSES NUMBER; 
  BEGIN 
      B#_TEMP := 0; 
      CLASSID_TEMP := 0; 
      DUPLICATE_ENROLL := 0; 

	  --Check if the B# is valid or not
      BEGIN 
          SELECT B# 
          INTO   B#_TEMP 
          FROM   STUDENTS 
          WHERE  B# = B#_IN; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.'); 

            RETURN; 
      END; 

	  --Check if the classid is valid or not
      BEGIN 
          SELECT CLASSID 
          INTO   CLASSID_TEMP 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The classid is invalid.'); 

            RETURN; 
      END; 

	  --Check if the class is of current semester or not
      BEGIN 
          SELECT CLASSID 
          INTO   CLASSID_TEMP 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN 
                 AND SEMESTER = 'Fall' 
                 AND YEAR = '2018'; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 
            'Cannot enroll into a class from a previous semester.'); 
            RETURN; 
      END; 

	  --Check if the class is full or not
      BEGIN 
          SELECT ( LIMIT - CLASS_SIZE ) 
          INTO   SEATS_AVAILABLE 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 

		  --If the class is full, throw an error
          IF SEATS_AVAILABLE = 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The class is already full.'); 
          END IF; 
      END; 

	  --Check if the student is already enrolled for the class
      BEGIN 
          SELECT COUNT(*) 
          INTO   DUPLICATE_ENROLL 
          FROM   ENROLLMENTS 
          WHERE  CLASSID = CLASSID_IN 
                 AND B# = B#_IN;

	      --For duplicate enrollment, throw an error
          IF DUPLICATE_ENROLL != 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 
            'The student is already in the class.' 
            ); 
          END IF; 
      END; 

	  --Check the number of courses for which the student has enrolled this semester
      BEGIN 
          SELECT COUNT(*) 
          INTO   CURRENT_COURSES_COUNT 
          FROM   ENROLLMENTS E, 
                 CLASSES C 
          WHERE  E.CLASSID = C.CLASSID 
                 AND E.B# = B#_IN 
                 AND C.SEMESTER = 'Fall' 
                 AND C.YEAR = '2018'; 

	      --If the student is already enrolled for 4 courses,
		  -- enroll the student and throw an exception
		  --If the student is already enrolled for 4 courses,
		  -- throw an exception
          IF CURRENT_COURSES_COUNT = 4 THEN 
            INSERT INTO ENROLLMENTS 
            VALUES      (B#_IN, 
                         CLASSID_IN, 
                         NULL); 
            COMMIT; 
			
			RAISE_APPLICATION_ERROR(-20001, 'The student will be overloaded with the new enrollment.');
			RETURN; 
          ELSIF CURRENT_COURSES_COUNT = 5 THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Students cannot be enrolled in more than five classes in the same semester.'); 
            RETURN; 
          END IF; 
      END; 

	  --Check if the prerequisites have been satisfied
      BEGIN 
          SELECT DEPT_CODE, 
                 COURSE# 
          INTO   DEPT_CODE_TEMP, COURSE#_TEMP 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 

      BEGIN 
          SELECT COUNT(*) 
          INTO   NOT_SATISIFED_PRECOURSES 
          FROM   (SELECT UNIQUE T2.DEPT_CODE, 
                                T2.COURSE#, 
                                T3.B#, 
                                T3.LGRADE 
                  FROM   (SELECT * 
                          FROM   (WITH N (PRE_DEPT_CODE, PRE_COURSE#, DEPT_CODE, 
                                       COURSE#) 
                                       AS (SELECT PRE_DEPT_CODE, 
                                                  PRE_COURSE#, 
                                                  DEPT_CODE, 
                                                  COURSE# 
                                           FROM   PREREQUISITES 
                                           WHERE  DEPT_CODE = DEPT_CODE_TEMP 
                                                  AND COURSE# = COURSE#_TEMP 
                                           UNION ALL 
                                           SELECT P.PRE_DEPT_CODE, 
                                                  P.PRE_COURSE#, 
                                                  P.DEPT_CODE, 
                                                  P.COURSE# 
                                           FROM   PREREQUISITES P 
                                                  INNER JOIN N N1 
                                                          ON N1.PRE_DEPT_CODE = 
                                                             P.DEPT_CODE 
                                                             AND N1.PRE_COURSE# 
                                                                 = 
                                                                 P.COURSE#) 
                                  SELECT PRE_DEPT_CODE, 
                                         PRE_COURSE# 
                                   FROM   N) T1 
                                  JOIN CLASSES C 
                                    ON C.DEPT_CODE = T1.PRE_DEPT_CODE 
                                       AND C.COURSE# = T1.PRE_COURSE#) T2 
                         LEFT JOIN (SELECT E.B#, 
                                           E.LGRADE, 
                                           C.DEPT_CODE, 
                                           C.COURSE# 
                                    FROM   ENROLLMENTS E 
                                           JOIN CLASSES C 
                                             ON C.CLASSID = E.CLASSID 
                                    WHERE  E.B# = B#_IN) T3 
                                ON T2.DEPT_CODE = T3.DEPT_CODE 
                                   AND T2.COURSE# = T3.COURSE#) 
          WHERE  B# IS NULL 
                  OR LGRADE > 'D'; 
      END; 

      IF( NOT_SATISIFED_PRECOURSES > 0 ) THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Prerequisite not satisfied.'); 

        RETURN; 
      END IF; 
  END; 

  --Enroll the student
  BEGIN 
      INSERT INTO ENROLLMENTS 
      VALUES      (B#_IN, 
                   CLASSID_IN, 
                   NULL); 
				   
	  --Increase the class size
      UPDATE CLASSES 
      SET    CLASS_SIZE = CLASS_SIZE + 1 
      WHERE  CLASSID = CLASSID_IN; 

      COMMIT; 
  END; 
  END; 
  
  --Procedure for dropping a student from a class
  PROCEDURE DROP_STUDENT(B#_IN      IN STUDENTS.B#%TYPE, 
                         CLASSID_IN IN CLASSES.CLASSID%TYPE) 
  AS 
    B#_TEMP              STUDENTS.B#%TYPE; 
    CLASSID_TEMP         CLASSES.CLASSID%TYPE; 
    DEPT_CODE_TEMP       CLASSES.DEPT_CODE%TYPE; 
    COURSE#_TEMP         CLASSES.COURSE#%TYPE; 
    COURSE_OFFR_CURR_SEM CHAR(20); 
    DEPENDENT_PRECOURSES NUMBER; 
    --CHECK_B# STUDENTS.B#%TYPE;  
    --CHECK_CLASSID CLASSES.CLASSID%TYPE;  
    IS_ENROLLED          NUMBER; 
    PREREQ_COURSES       NUMBER; 
    CLASSES_LEFT         NUMBER; 
    STUDENTS_LEFT        NUMBER; 
  BEGIN 
      B#_TEMP := 0; 
      CLASSID_TEMP := 0; 
      IS_ENROLLED := 0; 
      PREREQ_COURSES := 0; 
      CLASSES_LEFT := 0; 
      STUDENTS_LEFT := 0; 

      --Check if the B# is valid or not 
      BEGIN 
          SELECT B# 
          INTO   B#_TEMP 
          FROM   STUDENTS 
          WHERE  B# = B#_IN; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.'); 

            RETURN; 
      END; 

      --Check if the classid is valid or not 
      BEGIN 
          SELECT CLASSID 
          INTO   CLASSID_TEMP 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 
      EXCEPTION 
          WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The classid is invalid.'); 

            RETURN; 
      END; 

      --Check if the student is already enrolled for the class or not 
      BEGIN 
          BEGIN 
              SELECT COUNT(*) 
              INTO   IS_ENROLLED 
              FROM   ENROLLMENTS 
              WHERE  CLASSID = CLASSID_IN 
                     AND B# = B#_IN;   
          END; 

          IF IS_ENROLLED = 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 
            'The student is not enrolled in the class.'); 

            RETURN; 
          END IF; 
      END; 

      --Check if the course is offered in Fall 2018 or not
      BEGIN 
          BEGIN 
              SELECT COUNT(*) 
              INTO   COURSE_OFFR_CURR_SEM 
              FROM   CLASSES 
              WHERE  CLASSES.CLASSID = CLASSID_IN 
                     AND CLASSES.SEMESTER = 'Fall' 
                     AND CLASSES.YEAR = '2018'; 
          EXCEPTION 
              WHEN NO_DATA_FOUND THEN 
                COURSE_OFFR_CURR_SEM := 0; 
          END; 

          IF COURSE_OFFR_CURR_SEM = 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 
            'Only enrollment in the current semester can be dropped.'); 

            RETURN; 
          END IF; 
      END; 

	  --Check if the drop is permitted or not due to prerequisites
      BEGIN 
          SELECT DEPT_CODE, 
                 COURSE# 
          INTO   DEPT_CODE_TEMP, COURSE#_TEMP 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 

          BEGIN 
              SELECT COUNT(*) 
              INTO   DEPENDENT_PRECOURSES 
              FROM   (SELECT UNIQUE * 
                      FROM   (SELECT C.DEPT_CODE, 
                                     C.COURSE# 
                              FROM   (WITH N (PRE_DEPT_CODE, PRE_COURSE#, 
                                           DEPT_CODE, 
                                           COURSE#) 
                                           AS (SELECT PRE_DEPT_CODE, 
                                                      PRE_COURSE#, 
                                                      DEPT_CODE, 
                                                      COURSE# 
                                               FROM   PREREQUISITES 
                                               WHERE  PRE_DEPT_CODE = 
                                                      DEPT_CODE_TEMP 
                                                      AND PRE_COURSE# = 
                                                          COURSE#_TEMP 
                                               UNION ALL 
                                               SELECT P.PRE_DEPT_CODE, 
                                                      P.PRE_COURSE#, 
                                                      P.DEPT_CODE, 
                                                      P.COURSE# 
                                               FROM   PREREQUISITES P 
                                                      INNER JOIN N CHLD 
                                                              ON CHLD.DEPT_CODE 
                                                                 = 
                                                                 P.PRE_DEPT_CODE 
                                                                 AND 
                                                      CHLD.COURSE# = 
                                                      P.PRE_COURSE#) 
                                      SELECT DEPT_CODE, 
                                             COURSE# 
                                       FROM   N) T1 
                                      JOIN CLASSES C 
                                        ON C.DEPT_CODE = T1.DEPT_CODE 
                                           AND C.COURSE# = T1.COURSE#) T2 
                             JOIN (SELECT EN.B#, 
                                          C.COURSE#, 
                                          C.DEPT_CODE 
                                   FROM   ENROLLMENTS EN 
                                          JOIN CLASSES C 
                                            ON EN.CLASSID = C.CLASSID 
                                   WHERE  EN.B# = B#_IN 
                                          AND EN.CLASSID != CLASSID_IN) T3 
                               ON T2.DEPT_CODE = T3.DEPT_CODE 
                                  AND T2.COURSE# = T3.COURSE#); 
          EXCEPTION 
              WHEN NO_DATA_FOUND THEN 
                DEPENDENT_PRECOURSES := 0; 
          END; 

          IF DEPENDENT_PRECOURSES > 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 
			'The drop is not permitted because another class uses it as a prerequisite.' 
			); 
			RETURN; 
		  END IF; 
      END; 

      --Delete the student from the class
	  --Decrease the class size
      BEGIN 
          DELETE FROM ENROLLMENTS 
          WHERE  CLASSID = CLASSID_IN 
          AND B# = B#_IN; 

          UPDATE CLASSES 
          SET    CLASS_SIZE = CLASS_SIZE - 1 
          WHERE  CLASSID = CLASSID_IN; 

          COMMIT; 

        BEGIN 
          SELECT COUNT(*) 
          INTO   CLASSES_LEFT 
          FROM   ENROLLMENTS E, 
               CLASSES C 
          WHERE  B# = B#_IN 
               AND E.CLASSID = C.CLASSID 
               AND C.SEMESTER = 'Fall' 
               AND C.YEAR = '2018'; 

		  --Check if the student is not enrolled in any classes this semester
          IF CLASSES_LEFT = 0 THEN 
			RAISE_APPLICATION_ERROR(-20001, 
			'This student is not enrolled in any classes.' 
			); 
			RETURN;  
		  END IF;  
        END; 

        --Check if the student is the last student in the class
        BEGIN 
          SELECT CLASS_SIZE 
          INTO   STUDENTS_LEFT 
          FROM   CLASSES 
          WHERE  CLASSID = CLASSID_IN; 

          IF STUDENTS_LEFT = 0 THEN 
            RAISE_APPLICATION_ERROR(-20001, 'The class now has no students.'); 
            RETURN;  
        END IF; 
        END; 
       END; 
      END; 
	  
	  --Procedure for deleteing a student
      PROCEDURE DELETE_STUDENT(B#_IN IN STUDENTS.B#%TYPE) 
      AS 
      B#_TEMP     STUDENTS.B#%TYPE; 
      B#_TA_CHECK NUMBER; 
      BEGIN 
        B#_TEMP := 0; 

        --Check if the B# is valid or not 
        BEGIN 
            SELECT B# 
            INTO   B#_TEMP 
            FROM   STUDENTS 
            WHERE  B# = B#_IN; 
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN 
              RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.'); 

            RETURN; 
        END; 

        --Delete the student
        BEGIN 
          SELECT COUNT(*) 
          INTO   B#_TA_CHECK 
          FROM   TAS 
          WHERE  B# = B#_IN; 

		  --Check if the student is a TA or not
          IF B#_TA_CHECK = 0 THEN 
		    --Decrease the class size
            UPDATE CLASSES 
            SET    CLASS_SIZE = CLASS_SIZE - 1 
            WHERE  CLASSID IN (SELECT E.CLASSID 
                               FROM   ENROLLMENTS E, 
                                      CLASSES C 
                               WHERE  E.CLASSID = C.CLASSID 
                                      AND B# = B#_IN 
                                      AND C.SEMESTER = 'Fall' 
                                      AND C.YEAR = '2018'); 

  			--Delete from enrollments						  
            DELETE FROM ENROLLMENTS 
            WHERE  B# = B#_IN; 

			--Delete from STUDENTS
            DELETE FROM STUDENTS 
            WHERE  B# = B#_IN; 

            COMMIT; 
          ELSE 
		    --Update TA_B# for classes
            UPDATE CLASSES 
            SET    TA_B# = NULL 
            WHERE  TA_B# = B#_IN; 

			--Delete from TAs
            DELETE FROM TAS 
            WHERE  B# = B#_IN; 

			--Decrease the class size
            UPDATE CLASSES 
            SET    CLASS_SIZE = CLASS_SIZE - 1 
            WHERE  CLASSID IN (SELECT E.CLASSID 
                               FROM   ENROLLMENTS E, 
                                      CLASSES C 
                               WHERE  E.CLASSID = C.CLASSID 
                                      AND B# = B#_IN 
                                      AND C.SEMESTER = 'Fall' 
                                      AND C.YEAR = '2018'); 
            
			--Delete from enrollments
            DELETE FROM ENROLLMENTS 
            WHERE  B# = B#_IN; 

			--Delete from STUDENTS
            DELETE FROM STUDENTS 
            WHERE  B# = B#_IN; 

            COMMIT; 
          END IF; 
      END; 
  END; 
END; 

/ 
show ERRORS