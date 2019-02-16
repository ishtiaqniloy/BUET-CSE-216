--4
SELECT E1.LAST_NAME , E1.JOB_ID, (select COUNT(E2.Employee_id) From EMPLOYEES E2 Where E1.salary > E2. salary AND E1.JOB_ID = E2.Job_Id)
FROM EMPLOYEES E1
WHERE (select COUNT(E2.Employee_id) From EMPLOYEES E2 Where E1.salary > E2. salary AND E1.JOB_ID = E2.Job_Id) >=3;

--2
SELECT L.CITY, count(E.employee_id)
FROM LOCATIONS L left outer join DEPARTMENTS D 
ON (L.Location_id=d.location_id)
LEFT OUTER JOIN EMPLOYEES E
On (E.department_id = D.department_id)
GROUP BY L.CITY;

--3
SELECT E1.LAST_NAME, E1.DEPARTMENT_ID, E1.SALARY, 
(SELECT avg(E2.SALARY) FROM EMPLOYEES E2 GROUP BY E2.DEPARTMENT_ID HAVING E2.DEPARTMENT_ID = E1.department_id) "AvgSalDept", 
(SELECT count(E2.EMPLOYEE_ID) FROM EMPLOYEES E2 GROUP BY E2.DEPARTMENT_ID HAVING E2.DEPARTMENT_ID = E1.department_id) "CountEmpDept"
FROM EMPLOYEES E1
WHERE E1.SALARY 
BETWEEN (SELECT avg(E2.SALARY) FROM EMPLOYEES E2 GROUP BY E2.DEPARTMENT_ID HAVING E2.DEPARTMENT_ID = E1.department_id)-1000 
AND (SELECT avg(E2.SALARY) FROM EMPLOYEES E2 GROUP BY E2.DEPARTMENT_ID HAVING E2.DEPARTMENT_ID = E1.department_id)+1000;


--1
SELECT C.country_name, "COUNT"(E.EMPLOYEE_ID)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C 
WHERE E.department_id(+) = D.department_id and D.location_id(+) = L.location_id and L.country_id(+) = C.country_id
GROUP BY C.country_id, C.country_name;


--1
--SELECT C.country_name, (SELECT ( SELECT (SELECT COUNT(E.employee_id) FROM EMPLOYEES E GROUP BY E.DEPARTMENT_ID having E.department_id = D.department_id) FROM DEPARTMENTS D GROUP BY D.LOCATION_ID HAVING D.location_id = L.location_id) FROM LOCATIONS L GROUP BY L.COUNTRY_ID HAVING L.country_id = C.country_id )
--FROM COUNTRIES C











