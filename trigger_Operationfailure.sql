CREATE OR ALTER TRIGGER Operationfailure
ON Flight_leg_B
AFTER INSERT 
AS

	DECLARE @Status varchar(50)
	DECLARE @Remark varchar(100)
	DECLARE @Arrival_teminal_number char(8)

	SET @Arrival_teminal_number = (SELECT Arrival_teminal_number from inserted)
	SET @Status  = (SELECT Status FROM inserted)
    SET @Remark = (SELECT Remark FROM inserted)

	IF (@Remark != '') 
           BEGIN 
				SELECT   dbo.Airline.Airline_name AS [Air Line Name], 
					dbo.Airline.Company_name AS [Company Name], 
					dbo.Flight_leg_A.Flight_number AS [Flight Number], 
					dbo.Flight_leg_B.Status, 
					dbo.Flight_leg_B.Remark AS [Special Remark]

				FROM     dbo.Flight_leg_B 
				JOIN dbo.Flight_leg_A ON (dbo.Flight_leg_B.Arrival_teminal_number = dbo.Flight_leg_A.Arrival_teminal_number)
				join Aircraft on (Flight_leg_A.Aircraft_code=Aircraft.Aircraft_code)
				join Airline on (Airline.Airline_code=Aircraft.Airline_code)
				WHERE Remark= @Remark
				ORDER BY [Air Line Name], 
						 [Company Name], 
						 [Flight Number], 
						 dbo.Flight_leg_B.Status,
						 [Special Remark]

			END

	ElSE 
	   BEGIN 
	     PRINT 'Successfully Inserted'+
		 CHAR(10)+'No any special Remark to report' 
		 ROLLBACK
		 insert into Flight_leg_B values (@Arrival_teminal_number,@Status,@Remark)
       END


	   /* Execution*/

	   insert into Flight_leg_B values ('arl25498','Check-in',null)

	   insert into Flight_leg_B values ('arl30215','Delayed','Technical Problem')

