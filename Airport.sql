CREATE DATABASE AirportDatabase 

USE AirportDatabase

 CREATE TABLE Airport
(
	IATA_code char(10) ,
	Airport_name varchar(20) not null,
	City varchar(20) not null,
	Country varchar(20) not null,
	Established_year int not null CONSTRAINT df_Established_year DEFAULT 2000,
	CONSTRAINT pk_Airport PRIMARY KEY (IATA_code)
	
)

CREATE TABLE Airline
(
	Airline_code char(5),
	Airline_name varchar(20) Not null,
	Company_name varchar(20) not null,
	Address varchar(50) not null,
	Email varchar(50)  null,
	Web_url varchar(50) null,
	Fleet_size int null,
	Number_of_destinations varchar(50) null,
	Commenced_year int null CONSTRAINT df_commenced_year DEFAULT 1998,
	IATA_code char(10) not null,
	CONSTRAINT pk_Airline PRIMARY KEY (Airline_code),
	CONSTRAINT fk_IATA_code FOREIGN KEY (IATA_code) REFERENCES Airport(IATA_code)


)


CREATE TABLE Aircraft
(
	Aircraft_code char(5),
	Aircraft_name varchar(20) not null,
	Manufactured_company varchar(20) not null,
	Max_number_seats int not null,
	Model varchar(20) null,
	Airline_code char(5) not null,
	CONSTRAINT pk_Aircraft PRIMARY KEY (Aircraft_code),
	CONSTRAINT fk_Airline_code FOREIGN KEY (Airline_code) REFERENCES Airline (Airline_code)
)


CREATE TABLE Flight
(
	Flight_number char(5),
	Flight_type varchar (20) not null,
	Duration Time null CONSTRAINT df_duration DEFAULT '01:00:00',
	Estimated_arrival_time Time NOT NULL,
	Estimated_departure_time Time NOT NULL,
	Landing_information varchar(200) NULL,
	Take_off_information varchar(200) NULL,
	Airline_code char(5) not null,
	CONSTRAINT pk_Flight_number PRIMARY KEY(Flight_number),
	CONSTRAINT FK_Flight_Airline_code FOREIGN KEY(Airline_code) REFERENCES Airline (Airline_code)
)


CREATE TABLE Passenger_A
(
	Passport_number char (10),
	First_name varchar (20) not null,
	Minit varchar(5),
	Last_name varchar(20),
	Gender varchar(10) not null,
	Nationalty varchar(20) not null,
	Date_of_Birth date not null,
	Date_of_Issue date not null,
	Date_of_Expire date not null,
	Leg_number char(10) not null,
	Air_ticket_number char(5) not null,
	Guardian_passport_number char (10) null,
	CONSTRAINT pk_Passenger_A PRIMARY KEY(Passport_number),
	CONSTRAINT fk_Passenger_A FOREIGN KEY(Guardian_passport_number) REFERENCES Passenger_A(Passport_number),
	CONSTRAINT fk_Leg_number0 FOREIGN KEY(Leg_number) REFERENCES Flight_leg_A(Leg_number)
)


CREATE TABLE Passenger_B
(
	Leg_number char (10) not null,
	Air_ticket_number char(5) not null,
	Class varchar(15) null,
	Check_in_time Time null,
	Seat_number varchar(6) null,
	CONSTRAINT pk_Passenger_B PRIMARY KEY(Leg_number,Air_ticket_number),
	CONSTRAINT fk_Leg_number FOREIGN KEY(Leg_number) REFERENCES Flight_leg_A(Leg_number),
)



CREATE TABLE Flight_leg_A
(
	Leg_number char(10),
	Date_of_flight date null,
	Arrival_time time(0) null,
	Departure_time time(0) null,
	Arrival_teminal_number char(8) not null,
	Departure_terminal_number char(8) null,
	Aircraft_code char(5) not null,
	Flight_number char(5) not null,
	Staff_ID char(5) null,
	CONSTRAINT pk_Flight_leg_A PRIMARY KEY (Leg_number),
	CONSTRAINT fk_Aircraft_code FOREIGN KEY (Aircraft_code) REFERENCES  Aircraft (Aircraft_code),
	CONSTRAINT fk_Staff_ID FOREIGN KEY (Staff_ID) REFERENCES Aircrew (Staff_ID),
	CONSTRAINT uq_Arrivar_terminal_number UNIQUE (Arrival_teminal_number)
) 


CREATE TABLE Flight_leg_B 
(
	Arrival_teminal_number char(8) not null,
	Status varchar(50) not null,
	Remark varchar (100) null,
	CONSTRAINT pk_Arrival_teminal_number PRIMARY KEY (Arrival_teminal_number),
	CONSTRAINT fk_Arrival_teminal_number FOREIGN KEY (Arrival_teminal_number) REFERENCES Flight_leg_A (Arrival_teminal_number)

)



CREATE TABLE Flight_leg_arrival
(
    Leg_number char(10) NOT NULL,
	Baggage_belt_number varchar(10) NULL ,
	CONSTRAINT pk_Flight_leg_arrival PRIMARY KEY(Leg_number),
	CONSTRAINT fk_Flight_leg_arrival FOREIGN KEY(Leg_number) REFERENCES Flight_leg_A(Leg_number)
)



CREATE TABLE Flight_leg_departure
(
    Leg_number char(10) NOT NULL,
	Boarding_number varchar(10)  NULL ,
	Gate_number varchar(10) null,
	CONSTRAINT pk_Flight_leg_departure PRIMARY KEY(Leg_number),
	CONSTRAINT fk_Flight_leg_departurel FOREIGN KEY(Leg_number) REFERENCES Flight_leg_A(Leg_number)
)




CREATE TABLE Aircrew
(
	Staff_ID char(5),
	First_name varchar(25) not null,
	Minit varchar (5) null,
	Last_name varchar (25) null,
	Date_of_Birth date not null,
	Gender varchar(10) not null,
	Crew_catogary varchar(20) not null,
	Contact_number varchar(15) not null,
	Passport_number varchar(10) not null,
	Join_date date not null,
	Employee_details varchar (200) null,
	Expirience_years int null,
	Airline_code char(5) not null,
	CONSTRAINT pk_Staff_ID PRIMARY KEY (Staff_ID),
	CONSTRAINT uq_Passport_number UNIQUE (Passport_number),
	CONSTRAINT chk_Expirience_years CHECK (Expirience_years>1),
	CONSTRAINT fk_Aircrew_Airline_code FOREIGN KEY (Airline_code) REFERENCES Airline (Airline_code)
)

CREATE TABLE Flight_shedule_date
(
	Flight_number char(5) not null,
	Date date not null,
	CONSTRAINT pk_Flight_shedule_date PRIMARY KEY (Flight_number,Date),
	CONSTRAINT fk_Flight_number FOREIGN KEY (Flight_number) REFERENCES Flight (Flight_number)
)




CREATE TABLE Passenger_catogary
(
	Passport_number char(10) not null,
	Passenger_catogary varchar(30) not null,
	CONSTRAINT pk_Passenger_catogary PRIMARY KEY (Passport_number,Passenger_catogary),
	CONSTRAINT fk_Passport_number FOREIGN KEY (Passport_number) REFERENCES Passenger_A (Passport_number)
)





CREATE TABLE Passenger_requirements
(
	Passport_number char(10) not null,
	Requirement varchar(50) not null,
	CONSTRAINT pk_Passenger_requirements PRIMARY KEY (Passport_number,Requirement),
	CONSTRAINT fk_Passenger_requirements_Passport_number FOREIGN KEY (Passport_number) REFERENCES Passenger_A(Passport_number)
)


CREATE TABLE Airline_contact_number
(
	Airline_code char (5) not null,
	Contact_number1 varchar(15) not null,
	Contact_number2 varchar(15) null,
	COntact_number3 varchar(15) null,
	CONSTRAINT pk_Airline_contact_number PRIMARY KEY (Airline_code,Contact_number1),
	CONSTRAINT fk_Airline_contact_number_Airline_code FOREIGN KEY (Airline_code) REFERENCES Airline(Airline_code)
)

