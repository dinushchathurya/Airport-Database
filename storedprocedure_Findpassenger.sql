CREATE PROCEDURE sp_findPassengers
	@passportNumber char (10)

AS
	DECLARE @legnumber char(10)
	DECLARE @bdate date
	DECLARE @today date
	DECLARE @parentpass varchar (20)
	

	SELECT @parentpass=Passenger_A.Guardian_passport_number from Passenger_A where Passport_number=@passportNumber
	SELECT @today = CAST(GETDATE() as date)
	SELECT @legnumber= Passenger_A.Leg_number from Passenger_A where Passport_number=@passportNumber
	SELECT @bdate=Passenger_A.Date_of_Birth from Passenger_A where Passport_number=@passportNumber

	SELECT Flight_leg_B.Status,Flight_leg_B.Remark,Flight_leg_B.Arrival_teminal_number,Flight_leg_A.Staff_ID,Flight_leg_A.Leg_number,Flight_leg_A.Flight_number,Passenger_A.Passport_number,Passenger_A.First_name+' '+Passenger_A.Minit+' '+Passenger_A.Last_name as Name, Passenger_catogary.Passenger_catogary,Passenger_requirements.Requirement,Flight_shedule_date.Date
		from Flight_leg_B 
		JOIN  Flight_leg_A on (Flight_leg_B.Arrival_teminal_number=Flight_leg_A.Arrival_teminal_number)
		JOIN  Aircrew on (Flight_leg_A.Staff_ID=Aircrew.Staff_ID)
		JOIN Passenger_A on (Flight_leg_A.Leg_number=Passenger_A.Leg_number)
		JOin Passenger_catogary on (Passenger_A.Passport_number=Passenger_catogary.Passport_number)
		JOIN Passenger_requirements on (Passenger_A.Passport_number=Passenger_requirements.Passport_number)
		JOIN Flight_shedule_date on (Flight_leg_A.Flight_number=Flight_shedule_date.Flight_number)

		Where  Passenger_A.Leg_number=@legnumber

	DECLARE @rowcount int

	select  @@ROWCOUNT as [Number of Passengers]
	Print 'There are '+ cast (@@ROWCOUNT as varchar(30))+' passenger With this passenger'

	if(DATEDIFF(hour,@bdate,GETDATE())/8766 <12)
		BEGIN
			Print 'This Passenger is a Minor and his/her guardian is ' +@parentpass
		END

		/* sp_findPassenger Excecution*/
		EXEC sp_findPassengers 'M100123459'