-- ============================================================
-- SEED: Llantas
-- MotoEdu EC — UPS Cuenca 2026
-- ============================================================
DO $$
DECLARE
    michelin_id INTEGER; pirelli_id  INTEGER; bridge_id   INTEGER;
    dunlop_id   INTEGER; metzeler_id INTEGER; conti_id    INTEGER;
    maxxis_id   INTEGER; kenda_id    INTEGER; irc_id      INTEGER;
    shinko_id   INTEGER; heiden_id   INTEGER;
    road_id     INTEGER; trail_id    INTEGER; offroad_id  INTEGER;
    scooter_id  INTEGER; rain_id     INTEGER;
BEGIN
    SELECT id INTO michelin_id  FROM marcas_llanta WHERE nombre='Michelin';
    SELECT id INTO pirelli_id   FROM marcas_llanta WHERE nombre='Pirelli';
    SELECT id INTO bridge_id    FROM marcas_llanta WHERE nombre='Bridgestone';
    SELECT id INTO dunlop_id    FROM marcas_llanta WHERE nombre='Dunlop';
    SELECT id INTO metzeler_id  FROM marcas_llanta WHERE nombre='Metzeler';
    SELECT id INTO conti_id     FROM marcas_llanta WHERE nombre='Continental';
    SELECT id INTO maxxis_id    FROM marcas_llanta WHERE nombre='Maxxis';
    SELECT id INTO kenda_id     FROM marcas_llanta WHERE nombre='Kenda';
    SELECT id INTO irc_id       FROM marcas_llanta WHERE nombre='IRC';
    SELECT id INTO shinko_id    FROM marcas_llanta WHERE nombre='Shinko';
    SELECT id INTO heiden_id    FROM marcas_llanta WHERE nombre='Heidenau';

    SELECT id INTO road_id    FROM tipos_llanta WHERE nombre='Carretera (Road)';
    SELECT id INTO trail_id   FROM tipos_llanta WHERE nombre='Trail/Adventure';
    SELECT id INTO offroad_id FROM tipos_llanta WHERE nombre='Off-road/Enduro';
    SELECT id INTO scooter_id FROM tipos_llanta WHERE nombre='Scooter';
    SELECT id INTO rain_id    FROM tipos_llanta WHERE nombre='Lluvia/Rain';

    INSERT INTO llantas (marca_id,tipo_id,modelo,medida_ejemplo,precio_min_usd,precio_max_usd,descripcion) VALUES
    (michelin_id, road_id,    'Pilot Road 5',        '120/70 ZR17', 110, 200, 'Lider mundial. Alta tecnologia. Excelente vida util y agarre en mojado.'),
    (michelin_id, trail_id,   'Anakee Wild',         '110/80 R19',  100, 180, 'Trail extrema. Uso en aventura exigente.'),
    (michelin_id, trail_id,   'Anakee Adventure',    '120/70 R19',   90, 170, 'Balance perfecto asfalto/tierra. Muy popular en Ecuador.'),
    (pirelli_id,  road_id,    'Diablo Rosso IV',     '120/70 ZR17', 100, 190, 'Referente en deporte. Excelente comportamiento en curva.'),
    (pirelli_id,  trail_id,   'Scorpion Trail II',   '110/80 R19',   90, 170, 'Trail clasica. Alta durabilidad en asfalto y tierra.'),
    (bridge_id,   road_id,    'Battlax T31',         '120/70 ZR17', 100, 190, 'Alta calidad japonesa. Muy equilibrada en confort y performance.'),
    (bridge_id,   trail_id,   'Battlax A41',         '110/80 R19',   90, 180, 'Adventure de alta calidad. Gran durabilidad.'),
    (dunlop_id,   road_id,    'RoadSmart IV',        '120/70 ZR17',  90, 170, 'Excelente en touring y aventura.'),
    (dunlop_id,   trail_id,   'TrailSmart Max',      '110/80 R19',   85, 160, 'Trail duradera. Gran relacion precio-calidad.'),
    (metzeler_id, trail_id,   'Karoo Street',        '110/80 R19',   90, 170, 'Especialidad en enduro y doble proposito. Muy usada en BMW GS.'),
    (metzeler_id, road_id,    'Roadtec 01',          '120/70 ZR17',  85, 160, 'Touring de alta calidad alemana.'),
    (conti_id,    road_id,    'ContiRoadAttack 3',   '120/70 ZR17',  80, 160, 'Tecnologia alemana. Excelente en lluvia.'),
    (conti_id,    trail_id,   'ContiTrailAttack 3',  '110/80 R19',   75, 155, 'Trail premium. Muy buena en condiciones mixtas.'),
    (maxxis_id,   road_id,    'Victra Sport MA-ST2', '120/70 ZR17',  50, 100, 'Alta presencia en Ecuador. Buena relacion calidad-precio.'),
    (maxxis_id,   trail_id,   'SUPERMAXX',           '110/80 R19',   45,  90, 'Trail economica. Disponible en llantas.com.ec.'),
    (kenda_id,    road_id,    'Kenda K671',          '120/70-17',    40,  85, 'Amplia disponibilidad en Ecuador.'),
    (kenda_id,    offroad_id, 'Bear Claw',           '100/90-19',    35,  80, 'Off-road economico. Buena traccion en tierra.'),
    (irc_id,      road_id,    'GP-110',              '100/90-17',    45,  95, 'Marca japonesa de calidad media-alta. Popular en utilitarias.'),
    (shinko_id,   trail_id,   'Shinko 705',          '100/90-19',    40,  85, 'Buena relacion precio-durabilidad.'),
    (heiden_id,   offroad_id, 'Heidenau K60',        '100/90-19',    55, 110, 'Especializacion en off-road y trail. Alta durabilidad en ripio.')
    ON CONFLICT DO NOTHING;
END $$;
