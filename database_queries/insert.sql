---------------------------------------------------------------------------
INSERT INTO clients (name) VALUES
('Cláudia'),
('Roberto'),
('Ana Maria'),
('Carlos Alberto'),
('Fernanda'), 
('Mariana');

SELECT * FROM clients;
-- DELETE FROM clients;
--------------------------------------------------------------------------

INSERT INTO contracts (client_id, start_date, is_active)
SELECT id, '2025-04-22', TRUE FROM clients WHERE name IN ('Cláudia', 'Roberto');

INSERT INTO contracts (client_id, start_date, is_active)
SELECT id, '2023-10-22', FALSE FROM clients WHERE name IN ('Ana Maria');

INSERT INTO contracts (client_id, start_date, is_active)
SELECT id, '2024-07-27', TRUE FROM clients WHERE name IN ('Carlos Alberto');

INSERT INTO contracts (client_id, start_date, is_active)
SELECT id, '2023-11-15', TRUE FROM clients WHERE name IN ('Fernanda', 'Mariana');

INSERT INTO contracts (client_id, start_date, is_active)
SELECT id, '2025-01-10', TRUE FROM clients WHERE name IN ('Ana Maria', 'Carlos Alberto');

SELECT * FROM contracts;
-- DELETE FROM contracts;
---------------------------------------------------------------------------

INSERT INTO energy_readings (contract_id, reading_date, consumption)
SELECT contracts.id, CURRENT_DATE - INTERVAL '1 month' * generate_series(1,3), RANDOM()*300
FROM contracts;

SELECT * FROM energy_readings;
-- DELETE FROM energy_readings;
---------------------------------------------------------------------------
