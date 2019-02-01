CREATE FUNCTION Function_find_Passenger (@startDate date, @endDate date)
RETURNS @customer_details TABLE 
	(
		Airline_code char(5),
		Airline_name varchar(20),
		Aircraft_code char(5),
		Flight_number char(5),
		Leg_number char (10),
		Passport_number char(10),
		First_name varchar(20),
		Minit varchar(5),
		Last_name varchar(20),
		Air_ticket_number char(5)
	)

	AS 
		BEGIN

			

			INSERT INTO  @customer_details (Airline_code,Airline_name,Aircraft_code,Flight_number,Leg_number,Passport_number,First_name,Minit,Last_name,Air_ticket_number)
			
			Select Airline.Airline_code , Airline.Airline_name ,Flight_leg_A.Flight_number, Aircraft.Aircraft_code , Flight_leg_A.Leg_number  ,Passport_number ,First_name,Minit,Last_name,Air_ticket_number

			From Passenger_A
			JOIN Flight_leg_A on (Flight_leg_A.Leg_number=Passenger_A.Leg_number)
			JOIN Aircraft on (Flight_leg_A.Aircraft_code=Aircraft.Aircraft_code)
			JOIN Airline on (Aircraft.Airline_code=Airline.Airline_code)
			WHERE
			 
				Passenger_A.Leg_number=Flight_leg_A.Leg_number and Flight_leg_A.Date_of_flight < @endDate and Flight_leg_A.Date_of_flight > @startDate


				ORDER BY Aircraft.Aircraft_code

			Return
		END

		select * from Function_find_Passenger ('2018-12-01' , '2018-12-05')