CREATE PROCEDURE sp_passExpire
	 @PasportNumber char (10)
AS

	DECLARE @expDate date 
	DECLARE @today date
	


	SELECT @today = CAST(GETDATE() as date)
	Select @expDate = Date_of_Expire from Passenger_A where Passport_number = @PasportNumber

			if(@today>=@expDate)
				BEGIN
					PRINT 'Passenger''s Passport has been expired '
					Delete from Passenger_catogary where Passport_number = @PasportNumber
					Delete from Passenger_requirements where Passport_number = @PasportNumber
					Delete from Passenger_A where Passport_number=@PasportNumber
				END
			ELSE 
				PRINT 'This Passenger has valid Passport' 


/* Insert a Passenger with expired Password*/

	insert into Passenger_A values ('M100123155','Devon','H','Jhona','Male','Mexican','1976-04-22','2014-08-16','2019-01-14','dpr1664556','max01',null)

		/*sp_passExpire Excucution*/
		EXEC dbo.sp_passExpire 'M100123155'



					