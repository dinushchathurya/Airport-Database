CREATE FUNCTION statusInfo (@status varchar(50),@date date)

RETURNS @delay_info TABLE 
	(
		Status varchar (50),
		Remark varchar (50),
		Arrival_teminal_number char (8),
		Staff_ID char (5),
		Leg_number char (10),
		Flight_number char(5),
		Passport_number char(10),
		Passenger_name varchar(50),
		Passenger_catogary varchar(30),
		Passenger_Requirement varchar (50),
		Shedule_date date	
	)

AS
	BEGIN

		INSERT INTO @delay_info (Status,Remark,Arrival_teminal_number,Staff_ID,Leg_number,Flight_number,Passport_number,Passenger_name,Passenger_catogary,Passenger_Requirement,Shedule_date)
		
		SELECT Flight_leg_B.Status,Flight_leg_B.Remark,Flight_leg_B.Arrival_teminal_number,Flight_leg_A.Staff_ID,Flight_leg_A.Leg_number,Flight_leg_A.Flight_number,Passenger_A.Passport_number,Passenger_A.First_name+Passenger_A.Minit+Passenger_A.Last_name as Name, Passenger_catogary.Passenger_catogary,Passenger_requirements.Requirement,Flight_shedule_date.Date
		from Flight_leg_B 
		JOIN  Flight_leg_A on (Flight_leg_B.Arrival_teminal_number=Flight_leg_A.Arrival_teminal_number)
		JOIN  Aircrew on (Flight_leg_A.Staff_ID=Aircrew.Staff_ID)
		JOIN Passenger_A on (Flight_leg_A.Leg_number=Passenger_A.Leg_number)
		JOin Passenger_catogary on (Passenger_A.Passport_number=Passenger_catogary.Passport_number)
		JOIN Passenger_requirements on (Passenger_A.Passport_number=Passenger_requirements.Passport_number)
		JOIN Flight_shedule_date on (Flight_leg_A.Flight_number=Flight_shedule_date.Flight_number)

		Where Status=@status and date=@date

				

		RETURN
		END


		/* Function_statusInfo Excecution */
		SELECT * FROM statusInfo('Canceled','2018-12-21')