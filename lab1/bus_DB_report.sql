-- Tạo schema
CREATE SCHEMA bus_schema;

-- Bảng driver
CREATE TABLE bus_schema.driver (
  driver_id SERIAL PRIMARY KEY,
  passport VARCHAR(20),
  name VARCHAR(50),
  email VARCHAR(100),
  license_num VARCHAR(20)
);

-- Bảng passenger
CREATE TABLE bus_schema.passenger (
  passport VARCHAR(20) PRIMARY KEY,
  name VARCHAR(50),
  phone VARCHAR(20),
  email VARCHAR(100)
);

-- Bảng ticket
CREATE TABLE bus_schema.ticket (
  ticket_num SERIAL PRIMARY KEY,
  price NUMERIC(10,2), 
  payment_method VARCHAR(50),
  arrival_location VARCHAR(100),
  license_num VARCHAR(20),
  flight_code VARCHAR(10),
  passport VARCHAR(20)
);
-- Bảng stop
CREATE TABLE bus_schema.stop (
  stop_code VARCHAR(10) PRIMARY KEY,
  address VARCHAR(100),
  type VARCHAR(50),
  name VARCHAR(100)
);

-- Bảng flight
CREATE TABLE bus_schema.flight (
  flight_code VARCHAR(10) PRIMARY KEY,
  flight_num VARCHAR(10),
  status VARCHAR(50),
  arrival_time TIMESTAMP,
  arrival_location VARCHAR(100),
  departure_time TIMESTAMP,
  departure_location VARCHAR(100),
  bus_model VARCHAR(10),
  id_driver SERIAL,
  bus_id SERIAL,
  CONSTRAINT fk_flight_driver
    FOREIGN KEY (id_driver)
    REFERENCES bus_schema.driver(driver_id)
);

-- Bảng bus_model
CREATE TABLE bus_schema.bus_model (
  model_code VARCHAR(10) PRIMARY KEY,
  seats INTEGER,
  company VARCHAR(100),
  country VARCHAR(50),
  manufacture_year INTEGER
);  

-- Bảng bus
CREATE TABLE bus_schema.bus (
  bus_id SERIAL PRIMARY KEY,
  model_code VARCHAR(10),
  CONSTRAINT fk_bus_model
    FOREIGN KEY (model_code)
    REFERENCES bus_schema.bus_model(model_code)
);

-- Bảng route 
CREATE TABLE bus_schema.route (
  route_id SERIAL PRIMARY KEY,
  flight_code VARCHAR(10),
  stop_code VARCHAR(10),
  departure_time TIMESTAMP,
  arrival_time TIMESTAMP,
  CONSTRAINT fk_route_flight 
    FOREIGN KEY (flight_code)
    REFERENCES bus_schema.flight(flight_code)
);


ALTER TABLE bus_schema.driver  
  ADD CONSTRAINT uq_driver_license_num
  UNIQUE (license_num);

ALTER TABLE bus_schema.flight
  ADD CONSTRAINT fk_flight_bus
  FOREIGN KEY (bus_id)
  REFERENCES bus_schema.bus(bus_id);


ALTER TABLE bus_schema.route
  ADD CONSTRAINT fk_route_stop
  FOREIGN KEY (stop_code)
  REFERENCES bus_schema.stop(stop_code);

ALTER TABLE bus_schema.ticket
  ADD CONSTRAINT fk_flight_code
  	FOREIGN KEY (flight_code)
  	REFERENCES bus_schema.flight(flight_code),
  ADD CONSTRAINT fk_ticket_passenger 
    FOREIGN KEY (passport) 
    REFERENCES bus_schema.passenger(passport);
  
