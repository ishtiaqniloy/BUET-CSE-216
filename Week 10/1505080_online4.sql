--1
CREATE OR REPLACE 
FUNCTION default_working_project  (Div_ID in NUMBER)
RETURN VARCHAR2 IS 
	status VARCHAR2 (100);
	avgSal NUMBER;
	counter NUMBER;
BEGIN
	avgSal :=0;
	counter :=0;

	if Div_ID is NULL THEN
		status := 'NULL department' ;
	ELSE
		--SELECT avg(e.SALARY) FROM EMP e GROUP BY e.DEPARTMENT_ID having e.DEPARTMENT_ID = Div_ID INTO avgSal;

		for R in (SELECT SALARY, DEPARTMENT_ID FROM EMP )
		LOOP
			IF R.DEPARTMENT_ID = Div_ID THEN
				avgSal := avgSal + R.SALARY;
				counter := counter + 1;
			end if;
		END LOOP;
		
		avgSal := avgSal / counter;
			
		
		IF avgSal >=10500 THEN
			status := 'GRAND' ;

		ELSIF avgSal <=9000 THEN
			status := 'SMALL' ;

		ELSE
			status := 'MEDIUM' ;
		
		end if;

	end if;
	
	RETURN status;

end;
/


--2--

CREATE OR REPLACE 
FUNCTION default_salary  (Div_ID in NUMBER,  pr in VARCHAR2)
RETURN NUMBER IS 
	sal NUMBER;
	status VARCHAR2 (100);
BEGIN
	IF pr is NULL then
		status := default_working_project (Div_ID);
	ELSE
		status :=pr ;
	end if;

	IF status = 'GRAND' THEN
		sal := 14000;
	ELSIF status = 'MEDIUM' THEN
		sal := 10000;
	ELSE 
		sal := 6000;
	end if;
	
	RETURN	sal;
	

end;
/

--3
--3

CREATE OR REPLACE TRIGGER check_entry 
before INSERT 
on EMP
FOR EACH ROW
DECLARE
	counter NUMBER;

BEGIN
		FOR R in (SELECT e.DEPARTMENT_ID FROM EMP e WHERE e.DEPARTMENT_ID = :NEW.DEPARTMENT_ID)
		LOOP
			counter := counter + 1;
		end LOOP;

		IF counter > 0 THEN
			DBMS_OUTPUT.PUT_LINE('Doing Nothing');
		ELSE
			if :NEW.SALARY is NULL
				:NEW.SALARY := default_salary (NULL, NULL);
			ELSIF :NEW.WORKING_POJECT IS NULL THEN
				:NEW.WORKING_POJECT := default_working_project (NULL);
			ELSE 
				DBMS_OUTPUT.PUT_LINE('NO CANGE');
			end if;

		end IF;



END;
/
