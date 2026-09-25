INSERT INTO auth.tipos_documento (codigo, descripcion) 
VALUES ('CC', 'Cédula de Ciudadanía'),
       ('CE', 'Cédula de Extranjería'),
	   ('TI', 'Tarjeta de Identidad');
	   
INSERT INTO catalogo.medicamentos (nombre, presentacion, es_pos) VALUES
('Acetaminofén', 'Tabletas 500 mg', TRUE),
('Ibuprofeno', 'Tabletas 400 mg', TRUE),
('Losartán', 'Tabletas 500 mg', TRUE),
('Amoxicilina', 'Cápsulas 500 mg', TRUE),
('Metformina', 'Tabletas 850 mg', TRUE),
('Minoxidil', 'Solución tópica 5%', FALSE),
('Erlotinib', 'Tabletas 150 mg', FALSE),
('Infliximab', 'Solución inyectable 100 mg', FALSE),
('Acetaminofén + Hidrocodona', 'Tabletas 325 mg / 5 mg', FALSE),
('Suplemento Multivitamínico', 'Cápsulas', FALSE);	   
