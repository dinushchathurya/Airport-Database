CREATE OR ALTER TRIGGER Passengerdetails
ON Passenger_A
AFTER INSERT,UPDATE
AS
  BEGIN
    DECLARE @Passportnumber CHAR(10), @Firstname VARCHAR(20),@Mint VARCHAR(5),@Lastname VARCHAR(20),@Gender VARCHAR(10),@Nationality VARCHAR(20),@Dateofbirth DATE, @Dateofissue DATE,
		        @Dateofexpire DATE,
		        @Legnumber CHAR(10),
		        @Airticketnumber CHAR(5),
				@Guardian_Passport CHAR(10)
    SELECT @Passportnumber=i.Passport_number,@Firstname=i.First_name,@Mint=i.Minit,@Lastname=i.Last_name,@Gender=i.Gender,@Nationality=i.Nationalty,@Dateofbirth=i.Date_of_Birth,
				@Dateofissue=i.Date_of_Issue,
				@Dateofexpire=i.Date_of_Expire,
				@Legnumber=i.Leg_number,
				@Airticketnumber=i.Air_ticket_number,
				@Guardian_Passport=i.Guardian_passport_number   FROM INSERTED i
		 IF ( @Passportnumber NOT LIKE 'M%')
		     BEGIN
			 PRINT 'Password number is in incorrect format'+CHAR(10)+'Passport Number should begin with "M"'
			 ROLLBACK
         END IF(@Firstname= '' OR @Firstname is null)
		        BEGIN
                PRINT 'You cannot leave First Name field Empty.'
		        ROLLBACK
         END IF (@Gender= '' OR @Gender is null)
		        BEGIN
                PRINT 'You cannot leave Gender field Empty.'
		        ROLLBACK
         END IF (@Nationality= '' OR @Nationality is null)
		        BEGIN
                PRINT 'You cannot leave Nationalty field Empty.'
		        ROLLBACK
         
		 END IF (@Dateofbirth= '' OR @Dateofbirth is null)
		        BEGIN
                PRINT 'You cannot leave Date of Birth field Empty.'
		        ROLLBACK
       
		 END IF (@Dateofissue= '' OR @Dateofissue is null)
		        BEGIN
                PRINT 'You cannot leave Date of issue field Empty.'
		        ROLLBACK
		END IF (@Dateofexpire= '' OR @Dateofexpire is null)
		        BEGIN
                PRINT 'You cannot leave Date of Expire field Empty.'
				ROLLBACK
		END IF (@Legnumber= '' OR @Legnumber is null)
		        BEGIN
                PRINT 'You cannot leave Leg Number field Empty.'
		        ROLLBACK
		END IF (@Airticketnumber= '' OR @Airticketnumber is null)
		        BEGIN
                PRINT 'You cannot leave Air Ticket field Empty.'
		        ROLLBACK
        END 
  
  ELSE
  SELECT * FROM inserted i
	
END



/* Execution*/

insert into Passenger_A values ('M100123155','Devon','H','Jhona','Male','Mexican','1976-04-22','2014-08-16','2019-01-14','dpr1664556','max01',null)
insert into Passenger_A values ('M100179155','Devon','H','Jhona','','Mexican','1976-04-22','2014-08-16','2019-01-14','dpr1664556','max01',null)