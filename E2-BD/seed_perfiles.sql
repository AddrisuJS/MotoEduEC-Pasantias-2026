-- ============================================================
-- SEED: Equipamiento de Seguridad
-- MotoEdu EC — UPS Cuenca 2026
-- ============================================================
DO $$
DECLARE
    casco_id INTEGER; chaqueta_id INTEGER; guantes_id INTEGER;
    botas_id INTEGER; rodill_id INTEGER; espaldera_id INTEGER;
    pechera_id INTEGER; body_id INTEGER; airbag_id INTEGER;
    reflec_id INTEGER;
BEGIN
    SELECT id INTO casco_id      FROM tipos_equipamiento WHERE nombre='Casco';
    SELECT id INTO chaqueta_id   FROM tipos_equipamiento WHERE nombre='Chaqueta';
    SELECT id INTO guantes_id    FROM tipos_equipamiento WHERE nombre='Guantes';
    SELECT id INTO botas_id      FROM tipos_equipamiento WHERE nombre='Botas';
    SELECT id INTO rodill_id     FROM tipos_equipamiento WHERE nombre='Rodilleras';
    SELECT id INTO espaldera_id  FROM tipos_equipamiento WHERE nombre='Espaldera';
    SELECT id INTO pechera_id    FROM tipos_equipamiento WHERE nombre='Pechera';
    SELECT id INTO body_id       FROM tipos_equipamiento WHERE nombre='Body Armor';
    SELECT id INTO airbag_id     FROM tipos_equipamiento WHERE nombre='Chaleco Airbag';
    SELECT id INTO reflec_id     FROM tipos_equipamiento WHERE nombre='Chaleco Reflectivo';

    -- CASCOS
    INSERT INTO equipamiento (tipo_id,marca,modelo,subtipo,gama,certificacion,precio_min_usd,precio_max_usd,descripcion) VALUES
    (casco_id,'Shoei','NXR2','Integral','alta','ECE 22.06, DOT',500,900,'El estandar de oro en cascos. Fabricacion manual. Maxima seguridad.'),
    (casco_id,'Shoei','GT-Air 3','Modular','alta','ECE 22.06, DOT',600,1200,'Modular premium con pantalla solar integrada.'),
    (casco_id,'Shoei','Hornet ADV','Adventure','alta','ECE 22.06',700,1100,'Dual sport premium. Visor + gogles.'),
    (casco_id,'Arai','RX-7V Evo','Integral','alta','ECE 22.06',700,1400,'Rival de Shoei. Preferido en competicion.'),
    (casco_id,'AGV','K6 S','Integral','alta','ECE 22.06, DOT',300,600,'Italiana iconicamente ligada a Rossi. Gran calidad-precio.'),
    (casco_id,'AGV','Tourmodular','Modular','alta','ECE 22.06',400,800,'Modular ligero de alto rendimiento.'),
    (casco_id,'Bell','Race Star Flex','Integral','alta','ECE, DOT, SNELL',400,800,'Historia en carreras. Alta calidad.'),
    (casco_id,'HJC','RPHA 11','Integral','media','ECE 22.06, DOT',250,450,'La marca de volumen mas vendida del mundo.'),
    (casco_id,'HJC','C70','Integral','media','ECE 22.06, DOT',150,280,'Excelente relacion calidad-precio.'),
    (casco_id,'LS2','Stream Evo','Integral','media','ECE 22.06, DOT',120,250,'Disponible en Ecuador via ACCBIKER. Gran calidad-precio.'),
    (casco_id,'LS2','Strobe II','Modular','media','ECE 22.06, DOT',150,320,'Modular asequible. Muy popular en Ecuador.'),
    (casco_id,'MT Helmets','Revenge 2','Integral','media','ECE 22.06',100,220,'Espanola. Excelente calidad a precio accesible.'),
    (casco_id,'Scorpion EXO','Exo-520','Integral','media','ECE 22.06',150,350,'Sistemas de ventilacion avanzados.'),
    (casco_id,'Yohe','YH-950','Integral','economica','DOT basico',40,80,'Disponible en Ecuador. Para uso urbano corto.'),
    (casco_id,'Zeus','ZS-813','Integral','economica','ECE basico',45,90,'Mayor calidad que marcas chinas. Buena ventilacion.'),
    (casco_id,'Kontrol','Sport 950','Integral','economica','Transito EC',35,70,'Presencia en Ecuador y Colombia. Para uso diario economico.'),
    -- CHAQUETAS
    (chaqueta_id,'Alpinestars','T-GP Plus Air','Textil respirante','alta','CE Nivel 2',300,600,'Premium. Clima caliente. Protecciones nivel 2.',),
    (chaqueta_id,'Dainese','Smart Jacket','3 en 1','alta','CE Nivel 2',400,800,'Muy versatil. Ideal para Sierra y Costa Ecuador.'),
    (chaqueta_id,'Rev''It','Sand 4 H2O','Textil impermeable','alta','CE Nivel 2',350,700,'Waterproof. Excelente para clima variable.'),
    (chaqueta_id,'Icon','Raiden DKR','Textil','media','CE Nivel 1',150,300,'Buena proteccion a precio accesible.'),
    (chaqueta_id,'RST','Tractech Evo 4','Cuero','media','CE Nivel 1',200,400,'Cuero de calidad media. Buena durabilidad.'),
    (chaqueta_id,'LS2','Textil con protecciones','3 en 1','economica','CE basico',60,150,'Opcion economica con protecciones basicas.'),
    -- GUANTES
    (guantes_id,'Alpinestars','SP-1 v3','Racing','alta','CE EN 13594',100,250,'Cuero premium. Para deporte y carretera.'),
    (guantes_id,'Dainese','Full Metal 6','Racing','alta','CE EN 13594',150,300,'Articulaciones metalicas. Maxima proteccion.'),
    (guantes_id,'RST','Tractech Evo 4','Touring','media','CE EN 13594',60,120,'Touring reforzado. Buena relacion calidad-precio.'),
    (guantes_id,'Icon','Pursuit2','Urbano','media','CE EN 13594',50,100,'Urbanos con buena proteccion.'),
    (guantes_id,'LS2','Curve','Urbano','economica','Basico',20,50,'Economicos. Para uso diario urbano.'),
    -- BOTAS
    (botas_id,'Alpinestars','Tech 7','Enduro','alta','CE EN 13634',200,400,'Referente mundial en botas de enduro.'),
    (botas_id,'Sidi','Adventure 2','Touring','alta','CE EN 13634',250,500,'Touring premium. Muy duraderas.'),
    (botas_id,'TCX','Track Evo','Racing','media','CE EN 13634',120,280,'Racing de calidad media. Buena proteccion.'),
    (botas_id,'Forma','Adventure Low','Touring','media','CE EN 13634',100,220,'Touring media cana. Muy comoda.'),
    (botas_id,'Generica','Trabajo cuero','Trabajo','economica','Basico',50,120,'Uso intensivo delivery. Economica.'),
    -- PROTECCIONES
    (espaldera_id,'Alpinestars','Bionic Air','Espaldera','alta','CE EN 1621-2 Nivel 2',80,200,'Espaldera de alto rendimiento. Nivel 2.'),
    (espaldera_id,'Dainese','Wave D1','Espaldera','alta','CE EN 1621-2 Nivel 2',70,180,'Italiana. Muy buena absorcion de impactos.'),
    (espaldera_id,'Knox','Aegis','Espaldera','media','CE EN 1621-2 Nivel 1',40,100,'Nivel 1. Buena relacion precio-proteccion.'),
    (pechera_id,'Alpinestars','Nucleon Flex Plus','Pechera','alta','CE EN 1621-3',80,180,'Proteccion de pecho y costillas. Premium.'),
    (body_id,'Alpinestars','Bionic Action V2','Body Armor','alta','CE Nivel 2',120,280,'Proteccion completa de torso. Nivel 2.'),
    (body_id,'Fox','Titan Sport','Body Armor','media','CE Nivel 1',60,150,'Off-road. Muy popular en enduristas.'),
    (airbag_id,'Alpinestars','Tech-Air 5','Chaleco Airbag','alta','CE Nivel 2',700,1200,'Sistema autonomo. No necesita cable. El mas avanzado.'),
    (airbag_id,'Dainese','Smart Jacket D-Air','Chaleco Airbag','alta','CE Nivel 2',600,1000,'Conectado a la moto. Alta precision de activacion.'),
    (reflec_id,'Generico','Chaleco ANT','Chaleco Reflectivo','economica','Transito EC',5,30,'Obligatorio por LOTTTSV. Debe usarse sobre toda la ropa.')
    ON CONFLICT DO NOTHING;
END $$;

-- ============================================================
-- SEED: Perfiles de Motociclista
-- ============================================================
INSERT INTO perfiles_motociclista (nombre, descripcion, uso_principal, motos_tipicas, riesgos_principales, experiencia_min_anios, velocidad_tipica_kmh) VALUES
('Urbano Diario',    'Adulto 25-45 anos. Usa la moto para trabajo diario en ciudad. Trafico intenso.',          'Transporte diario al trabajo',         'Honda CB1, Yamaha YBR, Bajaj Boxer, Scooters',                      'Trafico, semaforos, piso mojado, visibilidad en cruce',     1, 50),
('Delivery',         'Adulto 20-40 anos. Muchas horas diarias. Alta exposicion al riesgo. Sin capacitacion.',   'Delivery de comida y mensajeria',      'Honda CB100, Boxer 150, Shineray 150, Daytona 125',                 'Fatiga, exceso velocidad, semaforos, sin equipo completo',  0, 60),
('Touring',          'Adulto 30-55 anos. Viajes largos de fin de semana. Experiencia alta.',                    'Viajes largos, carretera',             'Yamaha Tenere, KTM Adventure, Royal Enfield, NX500, Dominar',       'Alta velocidad sostenida, fatiga, climatologia variable',   5, 120),
('Aventura Off-road','Adulto 25-50 anos. Fines de semana. Experiencia media-alta.',                             'Off-road, rutas no asfaltadas',        'KTM EXC, Yamaha XTZ250, Daytona Sprinter, Honda CRF300L',          'Terreno irregular, caidas, alejamiento de centros medicos', 3, 80),
('Enduro',           'Adulto 20-45 anos. Competicion o deporte intenso en tierra.',                            'Enduro, competicion off-road',         'KTM EXC, Honda CRF, Yamaha YZ, Kawasaki KX',                       'Velocidades extremas, terreno exigente, colisiones',        3, 90),
('Deportivo',        'Adulto 20-40 anos. Sport bikes. Alta exigencia tecnica en asfalto.',                     'Deporte, carretera, circuito',         'Kawasaki Ninja, Yamaha R3/R6, KTM RC, Honda CBR',                  'Alta velocidad, curvas tecnicas, sobreconfianza',           2, 150)
ON CONFLICT (nombre) DO NOTHING;

-- ============================================================
-- SEED: Categorias de Pregunta y Brechas
-- ============================================================
INSERT INTO categorias_pregunta (nombre, descripcion, modulo_app) VALUES
('Normativa LOTTTSV',         'Ley organica de transporte, velocidades, senales, infracciones',     'RF-06'),
('Conduccion Segura',         'Tecnicas de manejo, frenado, curvas, maniobras de evasion',          'RF-10'),
('Conduccion en Lluvia',      'Tecnicas especificas para piso mojado y lluvia intensa',             'RF-10'),
('Equipamiento de Seguridad', 'Tipos de cascos, ropa, guantes, botas, protecciones',               'RF-07'),
('Tipos de Motocicletas',     'Clasificacion, uso correcto segun tipo y cilindraje',               'RF-08'),
('Llantas y Neumaticos',      'Tipos de llantas, mantenimiento, lectura de medidas',               'RF-09'),
('Primeros Auxilios',         'Que hacer en caso de accidente, llamadas de emergencia',            'RF-10')
ON CONFLICT (nombre) DO NOTHING;

INSERT INTO brechas_conocimiento (descripcion, pct_con_brecha, pct_sin_brecha, nivel_riesgo, modulo_relacionado, fuente) VALUES
('Desconoce velocidad maxima urbana correcta (50 km/h)',         60.0, 40.0, 'ALTO',  'RF-06 Normativa Vial',      'Encuesta E1 Extension UPS 2026 — 60 respuestas'),
('Sin capacitacion formal de manejo',                            35.0, 65.0, 'ALTO',  'RF-10 Conduccion Segura',   'Encuesta E1 Extension UPS 2026'),
('Tecnica incorrecta de frenado en piso mojado',                 30.0, 70.0, 'ALTO',  'RF-10 Conduccion Segura',   'Encuesta E1 Extension UPS 2026'),
('No revisa llantas con frecuencia adecuada',                    45.0, 55.0, 'MEDIO', 'RF-09 Modulo Llantas',      'Encuesta E1 Extension UPS 2026'),
('Desconoce completamente la LOTTTSV',                           20.0, 80.0, 'ALTO',  'RF-06 Normativa Vial',      'Encuesta E1 Extension UPS 2026'),
('Sin licencia de conduccion valida',                            25.0, 75.0, 'ALTO',  'RF-06 Normativa Vial',      'Encuesta E1 Extension UPS 2026'),
('Ha tenido accidentes o caidas',                                60.0, 40.0, 'MEDIO', 'RF-10, RF-07',              'Encuesta E1 Extension UPS 2026'),
('No usa equipamiento completo de seguridad',                    40.0, 60.0, 'ALTO',  'RF-07 Equipamiento',        'Encuesta E1 Extension UPS 2026')
ON CONFLICT DO NOTHING;
