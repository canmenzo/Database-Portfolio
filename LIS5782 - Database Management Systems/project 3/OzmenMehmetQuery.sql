SELECT fName, lName
FROM Person
WHERE dob < '1969-12-31';

SELECT fName, lName
FROM Person
WHERE schoolName = 'Columbia University';


select fName, lName
from Person
inner join school on PersonID=schoolID
where schoolName = 'Columbia University';


SELECT fName, lName
FROM Person
WHERE personID IN (SELECT empID from employmenthistory WHERE jobID IN
					(SELECT empID
					FROM Employer
					WHERE empName = 'Hogwarts School of Witchcraft and Wizardry'));


SELECT fName, lName
FROM Person
WHERE personID IN 
	(SELECT ccID
	FROM creditcard
	WHERE ccID IN
		(SELECT ccID
		FROM Transaction
		WHERE ccName = 'BartleyCard' AND purchaseDate < '2014-08-12'));


SELECT fName, lName
FROM Person
WHERE personID IN 
	(SELECT flightID
	FROM flightrecord
	WHERE flightID IN
		(SELECT flightID
		FROM flight
		WHERE destAirportName = 'New York, Kennedy'));