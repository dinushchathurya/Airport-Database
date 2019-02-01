CREATE VIEW upcomingArrivals
AS

	SELECT dbo.Flight.Flight_number AS [Flight Number],
                         dbo.Airline.Airline_name AS [Air Line Name],
						 dbo.Airline.Company_name AS [Company Name],
						 dbo.Flight.Flight_type AS [Flight Type],
						 dbo.Flight_leg_A.Date_of_flight AS [Date of Arrival],
                         dbo.Flight_leg_A.Arrival_time AS [Arrival Time],
						 dbo.Flight_leg_A.Arrival_teminal_number AS [Arrival Terminal]

	FROM  dbo.Airline 
	Inner JOIN dbo.Flight ON dbo.Airline.Airline_code = dbo.Flight.Airline_code 
	INNER JOIN dbo.Flight_leg_A ON dbo.Flight.Flight_number = dbo.Flight_leg_A.Flight_number

	WHERE Flight.Flight_type='Arrival'  AND Flight_Leg_A.Date_of_Flight> GETDATE()


                        

       select * from upcomingArrivals                  
	   select * from Flight
	   select * from Flight_leg_A
 
 update Flight_leg_A set Date_of_flight='2019-02-21' where Leg_number='arl1597456'

/* Execution*/
 select * from upcomingArrivals