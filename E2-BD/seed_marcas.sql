-- ============================================================
-- SEED: Marcas de moto, tipos de moto, marcas de llanta,
--       tipos de llanta, tipos de equipamiento
-- MotoEdu EC — UPS Cuenca 2026
-- ============================================================

-- ─── Marcas de Moto ──────────────────────────────────────────
INSERT INTO marcas_moto (nombre, origen, distribuidor_ec, garantia_meses, sitio_web) VALUES
('Honda',          'Japon',       'INDUMOT S.A.',                        60,  'https://motos.honda.com.ec'),
('Yamaha',         'Japon',       'Moto Power Ecuador',                  24,  'https://www.motopower.com.ec'),
('Kawasaki',       'Japon',       'Kawasaki Ecuador',                    24,  'https://ecuador.kawasaki-la.com'),
('Suzuki',         'Japon',       'Distribuidores independientes',       24,  'https://www.suzuki.com.ec'),
('KTM',            'Austria',     'Distribuidores especializados',       24,  'https://www.ktm.com'),
('Royal Enfield',  'India',       'EFLOSA Motos',                        24,  'https://www.eflosa.com'),
('Bajaj',          'India',       'Distribuidores nacionales',           24,  'https://www.bajaj.com.ec'),
('Harley-Davidson','Estados Unidos','Concesionario oficial Ecuador',     24,  'https://www.harley-davidson.com'),
('Shineray',       'China',       'Distribuidores nacionales',           12,  NULL),
('Daytona',        'China',       'Moto Power Ecuador',                  12,  'https://www.motopower.com.ec'),
('Factory Bike',   'Ecuador/China','Moto Power Ecuador',                 12,  'https://www.motopower.com.ec'),
('AKT',            'Colombia',    'Distribuidores independientes',       12,  NULL),
('Benelli',        'Italia/China','Moto Power Ecuador',                  24,  NULL),
('TVS',            'India',       'Distribuidores independientes',       24,  NULL),
('Ranger',         'China',       'Distribuidores nacionales',           12,  NULL),
('Motor Uno',      'Ecuador/China','Distribuidores nacionales',          12,  NULL)
ON CONFLICT (nombre) DO NOTHING;

-- ─── Tipos de Moto ───────────────────────────────────────────
INSERT INTO tipos_moto (nombre, descripcion, uso_tipico) VALUES
('Utilitaria',        'Motos de trabajo y transporte diario. Bajo consumo y alta durabilidad.',         'Delivery, transporte diario, trabajo'),
('Scooter',           'Transmision automatica CVT. Comoda para ciudad. Diametro de rueda pequeno.',     'Ciudad, distancias cortas, commuting'),
('Naked/Street',      'Sin carenado. Posicion de manejo erguida. Versatil en ciudad y carretera.',     'Ciudad, carretera, uso mixto'),
('Deportiva',         'Carenado aerodinamico. Alta potencia. Posicion agresiva.',                       'Deporte, carretera, circuito'),
('Doble proposito',   'Apta para asfalto y tierra. Balance entre comodidad y off-road.',               'Carreteras mixtas, campo, aventura'),
('Adventure/Touring', 'Larga distancia. Alta capacidad de carga. Pantalla y protecciones.',           'Touring, viajes largos, aventura'),
('Enduro/Trail',      'Especializada en off-road. Suspension larga. Manillar alto.',                   'Off-road, enduro, competicion'),
('Motocross',         'Solo competicion. Sin luces ni matricula. Suspension extrema.',                  'Competicion MX, pista de tierra'),
('Cruiser/Custom',    'Estilo chopper. Posicion relajada. Motor de gran cilindrada.',                  'Paseo, estilo, touring suave'),
('Cafe Racer',        'Estilo retro deportivo. Posicion inclinada. Clasica britanica moderna.',        'Ciudad, carretera, estilo')
ON CONFLICT (nombre) DO NOTHING;

-- ─── Tipos de Llanta ─────────────────────────────────────────
INSERT INTO tipos_llanta (nombre, descripcion, terreno_ideal, clima_ideal, no_recomendada) VALUES
('Carretera (Road)',    'Compuesto duro. Labrado fino continuo. Maxima durabilidad en asfalto.',          'Asfalto en buen estado',        'Seco y lluvia leve',   'Off-road, barro, ripio'),
('Trail/Adventure',    'Labrado mixto. Balance asfalto y off-road. La mas versatil.',                    'Asfalto + caminos de tierra',   'Seco, lluvia, barro',  'Enduro intenso, barro profundo'),
('Off-road/Enduro',    'Bloques grandes separados. Maxima traccion en tierra y barro.',                  'Tierra, barro, ripio, piedra',  'Barro, lluvia intensa','Asfalto (desgaste rapido)'),
('Motocross',          'Bloques muy agresivos. Sin homologacion vial. Solo competicion.',                'Pista de tierra preparada',     'Variable',             'Uso en carretera publica'),
('Scooter',            'Diametro pequeno 10-14 pulgadas. Alta durabilidad en ciudad.',                  'Asfalto urbano',                'Seco y lluvia leve',   'Carretera alta velocidad'),
('Lluvia/Rain',        'Canales profundos de evacuacion de agua. Alta adherencia en mojado.',            'Asfalto mojado',                'Lluvia intensa',       'Pista seca (sobrecalentamiento)'),
('Hipersport',         'Minimo labrado. Maximo contacto. Solo alta temperatura en circuito.',            'Circuito pavimentado',          'Seco',                 'Via publica, lluvia')
ON CONFLICT (nombre) DO NOTHING;

-- ─── Marcas de Llanta ────────────────────────────────────────
INSERT INTO marcas_llanta (nombre, origen, gama) VALUES
('Michelin',    'Francia',       'alta'),
('Pirelli',     'Italia',        'alta'),
('Bridgestone', 'Japon',         'alta'),
('Dunlop',      'EE.UU/Goodyear','alta'),
('Metzeler',    'Alemania',      'alta'),
('Continental', 'Alemania',      'alta'),
('Maxxis',      'Taiwan',        'media'),
('Kenda',       'Taiwan',        'media'),
('IRC',         'Japon',         'media'),
('Shinko',      'EE.UU/Asia',    'media'),
('Heidenau',    'Alemania',      'media'),
('CST',         'Taiwan/China',  'economica'),
('Sun-F',       'China',         'economica'),
('Veerubber',   'Tailandia',     'economica'),
('Duro',        'Taiwan',        'economica')
ON CONFLICT (nombre) DO NOTHING;

-- ─── Tipos de Equipamiento ───────────────────────────────────
INSERT INTO tipos_equipamiento (nombre, descripcion) VALUES
('Casco',           'Proteccion de cabeza. Obligatorio por LOTTTSV en Ecuador.'),
('Chaqueta',        'Proteccion de torso y brazos. Con o sin protecciones CE.'),
('Guantes',         'Proteccion de manos y munecas.'),
('Botas',           'Proteccion de pies, tobillos y parte inferior de la pierna.'),
('Pantalon',        'Proteccion de piernas con protectores de cadera y rodilla.'),
('Rodilleras',      'Proteccion especifica de rodillas. Uso externo o integrado.'),
('Espaldera',       'Protector de columna vertebral. Se inserta en chaqueta o independiente.'),
('Pechera',         'Protector de pecho y costillas contra impactos frontales.'),
('Body Armor',      'Proteccion integral de torso: hombros, codos, pecho y espalda.'),
('Chaleco Airbag',  'Sistema de airbag que se infla en milisegundos al detectar caida.'),
('Chaleco Reflectivo', 'Visibilidad nocturna. Obligatorio por LOTTTSV sobre toda la ropa.'),
('Gogles',          'Proteccion ocular para cascos de enduro y cross.')
ON CONFLICT (nombre) DO NOTHING;
