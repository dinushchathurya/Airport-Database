CREATE OR ALTER VIEW Ticketbookingdetails
AS

	SELECT  dbo.Flight.Flight_number,
            dbo.Flight.Flight_type,
		    dbo.Airline.Airline_name,
			dbo.Flight_leg_A.Date_of_flight,
			dbo.Passenger_B.Class AS [Class Type],
			COUNT(dbo.Passenger_B.Seat_number) AS [Booked Seat Amount]

	FROM     dbo.Airline INNER JOIN
	         dbo.Flight ON dbo.Airline.Airline_code = dbo.Flight.Airline_code INNER JOIN
			 dbo.Flight_leg_A ON dbo.Flight.Flight_number = dbo.Flight_leg_A.Flight_number INNER JOIN
			 dbo.Passenger_B ON dbo.Flight_leg_A.Leg_number = dbo.Passenger_B.Leg_number

	GROUP BY  dbo.Flight.Flight_number,
	          dbo.Airline.Airline_name,
			  dbo.Passenger_B.Seat_number,
			  dbo.Flight_leg_A.Leg_number,
			  dbo.Flight_leg_A.Date_of_flight,
			  dbo.Flight.Flight_type,
			  dbo.Passenger_B.Class

/* Execution*/
	select * from Ticketbookingdetails