-- Configuração inicial do schema

CREATE SCHEMA IF NOT EXISTS  dinasore;



SET search_path TO dinasore;

-- Remove tabelas existentes em ordem inversa de dependência
DROP TABLE IF EXISTS
Measurement,
Sensor,
Actuator,
Station,
Cell,
Production_Line,
Factory,
Rules
CASCADE;

-- Tabela de Regras (define limiares/condições para sensores/atuadores)
CREATE TABLE Rules (
rule_id SERIAL PRIMARY KEY,
rule_value VARCHAR(255) NOT NULL,
rule_priority INTEGER
);

-- Tabela de Fábricas (localizações físicas das fábricas)
CREATE TABLE Factory (
factory_id SERIAL PRIMARY KEY,
"name" VARCHAR(255) NOT NULL,
address TEXT
);

-- Tabela de Linhas de Produção (linhas de montagem dentro das fábricas)
CREATE TABLE Production_Line (
production_line_id SERIAL PRIMARY KEY,
"type" VARCHAR(100) NOT NULL,
"sequence" INTEGER NOT NULL,
rule_id INTEGER REFERENCES Rules(rule_id),
factory_id INTEGER NOT NULL REFERENCES Factory(factory_id)
);

-- Tabela de Células (unidades modulares dentro das linhas de produção)
CREATE TABLE Cell (
cell_id SERIAL PRIMARY KEY,
"type" VARCHAR(100) NOT NULL,
rule_id INTEGER REFERENCES Rules(rule_id),
production_line_id INTEGER NOT NULL REFERENCES Production_Line(production_line_id)
);

-- Tabela de Estações (postos de trabalho dentro das células)
CREATE TABLE Station (
station_id SERIAL PRIMARY KEY,
"type" VARCHAR(100) NOT NULL,
note TEXT,
cell_id INTEGER NOT NULL REFERENCES Cell(cell_id)
);

-- Tabela de Atuadores (atuadores com estado operacional)
CREATE TABLE Actuator (
actuator_id SERIAL PRIMARY KEY,
"type" VARCHAR(100) NOT NULL,
"state" BOOLEAN NOT NULL DEFAULT FALSE,
rule_id INTEGER NOT NULL REFERENCES Rules(rule_id),
station_id INTEGER NOT NULL REFERENCES Station(station_id)
);

-- Tabela de Sensores (sensores com limiares de calibração)
CREATE TABLE Sensor (
sensor_id SERIAL PRIMARY KEY,
"type" VARCHAR(100) NOT NULL,
si_unit VARCHAR(50),
normal_value NUMERIC,
error_value NUMERIC,
rule_id INTEGER NOT NULL REFERENCES Rules(rule_id),
station_id INTEGER NOT NULL REFERENCES Station(station_id),
actuator_id INTEGER REFERENCES Actuator(actuator_id)
);

-- Tabela de Medições (dados de séries temporais dos sensores)
CREATE TABLE Measurement (
"id" SERIAL PRIMARY KEY,
timestamp TIMESTAMP NOT NULL,
measurement_value FLOAT NOT NULL,
anomaly_flag BOOLEAN NOT NULL,
sensor_id INTEGER NOT NULL REFERENCES Sensor(sensor_id)
);

-- Criação de índices para melhorar performance
CREATE INDEX idx_cell_production_line ON Cell(production_line_id);
CREATE INDEX idx_station_cell ON Station(cell_id);
CREATE INDEX idx_actuator_station ON Actuator(station_id);
CREATE INDEX idx_sensor_station ON Sensor(station_id);
CREATE INDEX idx_measurement_sensor ON Measurement(sensor_id);

-- Inserção de dados nas tabelas

-- Factory data
INSERT INTO Factory (factory_id, "name", address) VALUES
(1, 'GMAN Main Factory', '123 Industrial Ave, Porto, PT');

-- Rules data
INSERT INTO Rules (rule_id, rule_value, rule_priority) VALUES
(1, 'normal_mean=200;normal_std=5;anomaly_mean=100;anomaly_std=5', 1),
(2, 'normal_mean=2.0;normal_std=0.5;anomaly_mean=5.0;anomaly_std=0.5', 1),
(3, 'normal_mean=0.003903;normal_std=0.0003;anomaly_mean=0.00600;anomaly_std=0.0003', 1),
(4, 'normal_mean=25;normal_std=2;anomaly_mean=10;anomaly_std=5', 1),
(5, 'normal_mean=500;normal_std=50;anomaly_mean=100;anomaly_std=20', 1),
(6, 'normal_mean=22;normal_std=1.5;anomaly_mean=35;anomaly_std=2', 1),
(7, 'normal_mean=40;normal_std=5;anomaly_mean=60;anomaly_std=5', 1),
(8, 'normal_mean=40;normal_std=2.5;anomaly_mean=20;anomaly_std=4', 1),
(9, 'normal_r=150;normal_g=100;normal_b=40;normal_brightness=300;anomaly_r=80;anomaly_g=60;anomaly_b=10;anomaly_brightness=150', 1),
(10, 'normal_mean=2.0;normal_std=0.4;anomaly_mean=5.0;anomaly_std=0.5', 1),
(11, 'normal_mean=480;normal_std=45;anomaly_mean=90;anomaly_std=25', 1),
(12, 'normal_mean=23;normal_std=1.2;anomaly_mean=36;anomaly_std=2', 1),
(13, 'normal_mean=0.5;normal_std=0.01;anomaly_mean=1.0;anomaly_std=0.01', 1),
(14, 'normal_mean=50;normal_std=5;anomaly_mean=100;anomaly_std=5', 1),
(15, 'normal_mean=40;normal_std=5;anomaly_mean=60;anomaly_std=5', 1),
(16, 'normal_mean=20;normal_std=0.5;anomaly_mean=60;anomaly_std=0.5', 1),
(17, 'normal_mean=2.5;normal_std=0.4;anomaly_mean=4.5;anomaly_std=0.5', 1),
(18, 'normal_mean=450;normal_std=40;anomaly_mean=120;anomaly_std=30', 1),
(19, 'normal_mean=23;normal_std=1.4;anomaly_mean=37;anomaly_std=2', 1),
(20, 'normal_mean=10;normal_std=0.5;anomaly_mean=20;anomaly_std=0.5', 1),
(21, 'normal_mean=3.5;normal_std=0.4;anomaly_mean=5.6;anomaly_std=0.5', 1),
(22, 'normal_mean=0.5;normal_std=0.05;anomaly_mean=1.0;anomaly_std=0.05', 1),
(23, 'normal_mean=460;normal_std=50;anomaly_mean=80;anomaly_std=25', 1),
(24, 'normal_mean=22;normal_std=1.3;anomaly_mean=34;anomaly_std=2', 1),
(25, 'normal_r=150;normal_g=100;normal_b=40;normal_brightness=300;anomaly_r=80;anomaly_g=60;anomaly_b=10;anomaly_brightness=150', 1),
(26, 'normal_mean=3.5;normal_std=0.4;anomaly_mean=5.6;anomaly_std=0.5', 1),
(27, 'normal_mean=470;normal_std=45;anomaly_mean=110;anomaly_std=25', 1),
(28, 'normal_mean=23;normal_std=1.4;anomaly_mean=37;anomaly_std=2', 1),
(29, 'activate_on_pressure_normal', 1),
(30, 'activate_on_stamping_movement', 1),
(31, 'activate_on_drilling_movement', 1),
(32, 'activate_on_proximity_normal', 1),
(33, 'activate_on_position_normal', 1),
(34, 'activate_on_sorting_normal', 1);

-- Production_Line data
INSERT INTO Production_Line (production_line_id, "type", "sequence", rule_id, factory_id) VALUES
(1, 'Front line', 1, NULL, 1);

-- Cell data
INSERT INTO Cell (cell_id, "type", rule_id, production_line_id) VALUES
(1, 'C1', NULL, 1),
(2, 'C2', NULL, 1),
(3, 'C3', NULL, 1),
(4, 'C4', NULL, 1),
(5, 'C5', NULL, 1);

-- Station data
INSERT INTO Station (station_id, "type", note, cell_id) VALUES
(1, 'Distributing Station', NULL, 1),
(2, 'Testing Station', NULL, 1),
(3, 'Processing Station', NULL, 1),
(4, 'Transporting Station', NULL, 1),
(5, 'Sorting Station', NULL, 1);

-- Actuator data
INSERT INTO Actuator (actuator_id, "type", "state", rule_id, station_id) VALUES
(1, 'Pneumatic Actuator lifting', FALSE, 29, 1),
(2, 'Pneumatic Actuator drilling', FALSE, 30, 2),
(3, 'Pneumatic Actuator stamping', FALSE, 31, 3),
(4, 'Pneumatic Actuator handling', FALSE, 32, 4),
(5, 'Robotic Gripper Actuator Lifting', FALSE, 33, 4),
(6, 'Robotic Gripper Actuator Sorting', FALSE, 34, 5);

-- Sensor data
INSERT INTO Sensor (sensor_id, "type", si_unit, normal_value, error_value, rule_id, station_id, actuator_id) VALUES
(1, 'Proximity Sensor', 'cm', 200, 100, 1, 1, 1),
(2, 'Power Consumption Sensor', 'kW', 2.0, 5.0, 2, 1, NULL),
(3, 'Pressure Sensor', 'bar', 0.003903, 0.006, 3, 1, 1),
(4, 'Capacitive Sensor', 'pF', 25, 10, 4, 1, 1),
(5, 'Light Sensor (Lux)', 'lux', 500, 100, 5, 1, NULL),
(6, 'Temperature Sensor', '°C', 22, 35, 6, 1, NULL),
(7, 'Distance Sensor (Height)', 'cm', 40, 60, 7, 2, NULL),
(8, 'Distance Sensor (Diameter)', 'cm', 40, 20, 8, 2, NULL),
(9, 'Color Sensor R', 'byte', 150, 80, 9, 2, NULL),
(10, 'Color Sensor G', 'byte', 100, 60, 9, 2, NULL),
(11, 'Color Sensor B', 'byte', 40, 10, 9, 2, NULL),
(12, 'Color Sensor Brightness', 'lux', 300, 150, 9, 2, NULL),
(13, 'Power Consumption Sensor', 'kW', 2.0, 5.0, 10, 2, NULL),
(14, 'Light Sensor (Lux)', 'lux', 480, 90, 11, 2, NULL),
(15, 'Temperature Sensor', '°C', 23, 36, 12, 2, NULL),
(16, 'Flaw Sensor (Ultrasonic)', 'cm', 0.5, 1.0, 13, 3, 2),
(17, 'Temperature Sensor', '°C', 50, 100, 14, 3, 3),
(18, 'Level Sensor (Laser)', 'cm', 40, 60, 15, 3, 2),
(19, 'Humidity Sensor', '%', 20, 60, 16, 3, NULL),
(20, 'Power Consumption Sensor', 'kW', 2.5, 4.5, 17, 3, NULL),
(21, 'Light Sensor (Lux)', 'lux', 450, 120, 18, 3, NULL),
(22, 'Temperature Sensor', '°C', 23, 37, 19, 3, NULL),
(23, 'Proximity Sensor', 'cm', 10, 20, 20, 4, 4),
(24, 'Power Consumption Sensor', 'kW', 3.5, 5.6, 21, 4, 4),
(25, 'Robotic Position Sensor', 'cm', 0.5, 1.0, 22, 4, 5),
(26, 'Light Sensor (Lux)', 'lux', 460, 80, 23, 4, 4),
(27, 'Temperature Sensor', '°C', 22, 34, 24, 4, NULL),
(28, 'Color Sensor R', 'byte', 150, 80, 25, 5, 6),
(29, 'Color Sensor G', 'byte', 100, 60, 25, 5, 6),
(30, 'Color Sensor B', 'byte', 40, 10, 25, 5, 6),
(31, 'Color Sensor Brightness', 'lux', 300, 150, 25, 5, 6),
(32, 'Power Consumption Sensor', 'kW', 3.5, 5.6, 26, 5, 6),
(33, 'Light Sensor (Lux)', 'lux', 470, 110, 27, 5, 6),
(34, 'Temperature Sensor', '°C', 23, 37, 28, 5, 6);

-- Measurement data(demonstraçao de como os dados sao inseridos)
INSERT INTO Measurement ("id", timestamp, measurement_value, anomaly_flag, sensor_id) VALUES
(1, '2025-05-03 12:53:55', 19.826, TRUE, 23);