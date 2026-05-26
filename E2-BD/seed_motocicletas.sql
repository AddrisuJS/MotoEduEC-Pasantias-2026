-- ============================================================
-- SEED: Motocicletas disponibles en Ecuador 2024-2026
-- Fuente: INDUMOT, Kawasaki EC, EFLOSA, Moto Power, Patiotuerca
-- MotoEdu EC — UPS Cuenca 2026
-- ============================================================

-- Helper para obtener IDs dinamicamente
DO $$
DECLARE
    honda_id    INTEGER; yamaha_id  INTEGER; kawasaki_id INTEGER;
    suzuki_id   INTEGER; ktm_id     INTEGER; re_id       INTEGER;
    bajaj_id    INTEGER; harley_id  INTEGER; shineray_id INTEGER;
    daytona_id  INTEGER; factory_id INTEGER; akt_id      INTEGER;
    benelli_id  INTEGER; tvs_id     INTEGER;

    util_id     INTEGER; scooter_id INTEGER; naked_id    INTEGER;
    sport_id    INTEGER; dual_id    INTEGER; adv_id      INTEGER;
    enduro_id   INTEGER; mx_id      INTEGER; cruiser_id  INTEGER;
    cafe_id     INTEGER;
BEGIN
    -- Marcas
    SELECT id INTO honda_id    FROM marcas_moto WHERE nombre = 'Honda';
    SELECT id INTO yamaha_id   FROM marcas_moto WHERE nombre = 'Yamaha';
    SELECT id INTO kawasaki_id FROM marcas_moto WHERE nombre = 'Kawasaki';
    SELECT id INTO suzuki_id   FROM marcas_moto WHERE nombre = 'Suzuki';
    SELECT id INTO ktm_id      FROM marcas_moto WHERE nombre = 'KTM';
    SELECT id INTO re_id       FROM marcas_moto WHERE nombre = 'Royal Enfield';
    SELECT id INTO bajaj_id    FROM marcas_moto WHERE nombre = 'Bajaj';
    SELECT id INTO harley_id   FROM marcas_moto WHERE nombre = 'Harley-Davidson';
    SELECT id INTO shineray_id FROM marcas_moto WHERE nombre = 'Shineray';
    SELECT id INTO daytona_id  FROM marcas_moto WHERE nombre = 'Daytona';
    SELECT id INTO factory_id  FROM marcas_moto WHERE nombre = 'Factory Bike';
    SELECT id INTO akt_id      FROM marcas_moto WHERE nombre = 'AKT';
    SELECT id INTO benelli_id  FROM marcas_moto WHERE nombre = 'Benelli';
    SELECT id INTO tvs_id      FROM marcas_moto WHERE nombre = 'TVS';

    -- Tipos
    SELECT id INTO util_id    FROM tipos_moto WHERE nombre = 'Utilitaria';
    SELECT id INTO scooter_id FROM tipos_moto WHERE nombre = 'Scooter';
    SELECT id INTO naked_id   FROM tipos_moto WHERE nombre = 'Naked/Street';
    SELECT id INTO sport_id   FROM tipos_moto WHERE nombre = 'Deportiva';
    SELECT id INTO dual_id    FROM tipos_moto WHERE nombre = 'Doble proposito';
    SELECT id INTO adv_id     FROM tipos_moto WHERE nombre = 'Adventure/Touring';
    SELECT id INTO enduro_id  FROM tipos_moto WHERE nombre = 'Enduro/Trail';
    SELECT id INTO mx_id      FROM tipos_moto WHERE nombre = 'Motocross';
    SELECT id INTO cruiser_id FROM tipos_moto WHERE nombre = 'Cruiser/Custom';
    SELECT id INTO cafe_id    FROM tipos_moto WHERE nombre = 'Cafe Racer';

    -- ─── HONDA ──────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (honda_id, util_id,   'CB100',                     2025, 100,  7.5,  101,  1580,  'Trabajo / delivery',         'Ideal para delivery. Bajo consumo. Credito disponible.'),
    (honda_id, util_id,   'CB1 Star',                  2026, 110,  8.0,  106,  2099,  'Transporte diario',          'Modelo mas vendido en Ecuador desde 2012. Motor economico.'),
    (honda_id, scooter_id,'Navi',                       2025, 110,  7.0,  102,  1690,  'Ciudad / last mile',         'Diseno compacto. Transmision automatica CVT.'),
    (honda_id, dual_id,   'CRF300L',                   2025, 286,  27.0, 140,  6990,  'Off-road / ciudad',          'Versatil. Ideal para carreteras de segundo orden.'),
    (honda_id, dual_id,   'NX500',                     2024, 471,  47.5, 196, 12490,  'Aventura / carretera',       'Inspirada en Africa Twin. Parabrisas de serie.'),
    (honda_id, adv_id,    'CRF1100 Africa Twin DCT',   2024,1084, 101.5, 226, 30990,  'Touring / aventura',         'Control de traccion. 5 modos de conduccion. DCT opcional.'),
    (honda_id, mx_id,     'CRF450R',                   2026, 449,  NULL, 110, 14990,  'Competicion MX',             'Motor 4T de alto rendimiento. Suspension premium.'),
    (honda_id, mx_id,     'CRF250R',                   2026, 249,  NULL, 103, 13990,  'Competicion MX',             '4 tiempos. Control y agilidad superior.'),
    (honda_id, naked_id,  'XBlade 160',                2026, 162,  15.4, 139,  3490,  'Ciudad / sport',             'Nuevo diseno agresivo 2026. Tablero digital. LED.')
    ON CONFLICT DO NOTHING;

    -- ─── YAMAHA ─────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (yamaha_id, util_id,  'YD110-1',       2026, 110,  7.5,  103,  1750,  'Trabajo / ciudad',     'Version economica de trabajo. Alta confiabilidad.'),
    (yamaha_id, util_id,  'YBR125',        2025, 125, 10.3,  115,  2100,  'Ciudad / trabajo',     'Clasico ecuatoriano. Amplia red de repuestos.'),
    (yamaha_id, naked_id, 'FZ150',         2025, 149, 14.7,  132,  2800,  'Ciudad / sport',       'Muy popular en Ecuador. Diseno agresivo.'),
    (yamaha_id, naked_id, 'FZ25',          2025, 249, 20.8,  153,  4500,  'Ciudad / carretera',   'Motor monocilindrico. Comodo para viajes medianos.'),
    (yamaha_id, dual_id,  'XTZ125E',       2026, 124, 10.0,  121,  3278,  'Ciudad / off-road',    'Versatil. Muy vendida en provincias con mal estado vial.'),
    (yamaha_id, dual_id,  'XTZ250',        2025, 249, 20.0,  142,  4800,  'Off-road / touring',   'Clasico del segmento dual en Ecuador.'),
    (yamaha_id, sport_id, 'YZF-R3',        2025, 321, 41.0,  168,  5500,  'Deporte / carretera',  'Moto deportiva para principiantes y nivel intermedio.'),
    (yamaha_id, naked_id, 'MT-03',         2025, 321, 41.0,  168,  5800,  'Ciudad / sport',       'Version naked de la R3. Muy popular en jovenes.'),
    (yamaha_id, naked_id, 'MT-07',         2024, 689, 75.0,  184, 12000,  'Carretera / sport',    'Bicilindrico. Alta potencia para uso mixto.'),
    (yamaha_id, adv_id,   'Tenere 700',    2025, 689, 72.0,  204, 17900,  'Touring / aventura',   'Reconocida mundialmente por aventura y enduro.')
    ON CONFLICT DO NOTHING;

    -- ─── KAWASAKI ───────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (kawasaki_id, adv_id,    'Versys-X 300 ABS',     2024, 296, 40.0, 172,  7500,  'Touring / aventura',   'ABS de serie. Ideal para carreteras mixtas.'),
    (kawasaki_id, naked_id,  'Z400 ABS',              2025, 399, 45.0, 167,  7800,  'Ciudad / carretera',   'Naked deportiva. ABS. Ergonomia confortable.'),
    (kawasaki_id, sport_id,  'Ninja 400 ABS',         2025, 399, 45.0, 167,  8000,  'Deporte / carretera',  'Entry sportbike. ABS. Control de traccion.'),
    (kawasaki_id, sport_id,  'Ninja 500 KRT Edition', 2025, 499, 61.0, 193,  9500,  'Deporte',              'Edicion KRT (colores racing). Bicilindrico.'),
    (kawasaki_id, naked_id,  'Z500 ABS',              2025, 499, 61.0, 193,  9200,  'Ciudad / carretera',   'Naked del segmento medio. Gran relacion potencia/precio.'),
    (kawasaki_id, dual_id,   'KLR 650',               2024, 652, 50.0, 199,  8500,  'Touring / off-road',   'Clasico de aventura. Muy confiable en Ecuador.'),
    (kawasaki_id, adv_id,    'KLE 500 ABS',           2026, 499, 61.0, 196, 10500,  'Touring',              'Nuevo 2026. Touring de segmento medio. ABS.'),
    (kawasaki_id, sport_id,  'Ninja ZX-4RR KRT',      2025, 399, 77.0, 186, 14000,  'Circuito / deporte',   '4 cilindros 400cc. Moto mas tecnica del segmento.'),
    (kawasaki_id, cruiser_id,'Eliminator 500',         2025, 499, 47.0, 211,  8900,  'Paseo / ciudad',       'Estilo cruiser clasico. Comoda para viajes tranquilos.')
    ON CONFLICT DO NOTHING;

    -- ─── KTM ────────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (ktm_id, naked_id,  'Duke 200',      2025, 199, 26.0, 140,  4500,  'Ciudad / sport',       'Entry level de KTM. Muy agil en ciudad.'),
    (ktm_id, naked_id,  'Duke 390',      2025, 373, 43.0, 163,  7500,  'Ciudad / carretera',   'Control de traccion. ABS. Display TFT. Referente del segmento.'),
    (ktm_id, sport_id,  'RC 390',        2025, 373, 43.0, 163,  8200,  'Deporte / carretera',  'Version deportiva del Duke 390. Carenado completo.'),
    (ktm_id, dual_id,   '390 Adventure', 2025, 373, 43.0, 167,  8800,  'Aventura / off-road',  'Doble proposito con tecnologia premium. WP suspension.'),
    (ktm_id, enduro_id, 'EXC 300',       2025, 293, 54.0, 107, 10000,  'Enduro / competicion', '2 tiempos. Especializada en enduro.'),
    (ktm_id, naked_id,  '890 Duke R',    2024, 889,121.0, 169, 18500,  'Carretera / deporte',  'Supernaked de alto rendimiento.')
    ON CONFLICT DO NOTHING;

    -- ─── ROYAL ENFIELD ──────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (re_id, naked_id,  'Hunter 350',        2025, 349, 20.4, 177,  5500,  'Ciudad / paseo',       'Moto retro moderna. La mas accesible de RE.'),
    (re_id, cruiser_id,'Classic 350',       2025, 349, 20.2, 195,  6200,  'Paseo / turismo',      'Iconica. Diseno clasico british. Muy popular.'),
    (re_id, cruiser_id,'Meteor 350',        2025, 349, 20.2, 191,  6500,  'Touring suave',        'Cruiser retro. Comoda para viajes largos tranquilos.'),
    (re_id, adv_id,    'Himalayan 450',     2024, 452, 40.0, 200,  9500,  'Aventura / off-road',  'Motor liquido. 6 velocidades. ABS doble canal. Referente.'),
    (re_id, naked_id,  'Guerrilla 450',     2024, 452, 40.0, 185,  9200,  'Ciudad / carretera',   'Version roadster del Himalayan 450. Velocidad max 170 km/h.'),
    (re_id, cafe_id,   'Continental GT 650',2025, 648, 47.0, 198, 12000,  'Carretera / estilo',   'Bicilindrico paralelo. Estetica cafe racer clasica.'),
    (re_id, naked_id,  'Interceptor 650',   2025, 648, 47.0, 213, 11500,  'Carretera / touring',  'Clasica britanica moderna. Gran confort.')
    ON CONFLICT DO NOTHING;

    -- ─── BAJAJ ──────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (bajaj_id, util_id,   'Boxer 150',        2025, 150, 14.0, 122,  2200,  'Trabajo / delivery',   'Alta durabilidad. Repuestos economicos. Muy usada en delivery.'),
    (bajaj_id, naked_id,  'Pulsar NS200',     2025, 199, 24.5, 156,  3800,  'Ciudad / sport',       'Una de las mas vendidas en el segmento sport-economico.'),
    (bajaj_id, naked_id,  'Pulsar NS160',     2025, 160, 17.0, 147,  3200,  'Ciudad',               'Version entry del NS. Buena relacion precio-rendimiento.'),
    (bajaj_id, adv_id,    'Dominar 400',      2025, 373, 40.0, 187,  6500,  'Touring / carretera',  'Motor KTM derivado. Control de traccion. ABS. Gran touring.'),
    (bajaj_id, cruiser_id,'Avenger Street 220',2025,220, 19.0, 160,  3100,  'Paseo / ciudad',       'Estilo cruiser accesible. Comoda para trayectos largos.')
    ON CONFLICT DO NOTHING;

    -- ─── HARLEY-DAVIDSON ────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (harley_id, cruiser_id,'Iron 883',     2025, 883, 54.0, 259, 12500, 'Paseo / estilo',      'Iconica americana. Simbolo cultural motero.'),
    (harley_id, cruiser_id,'Street 750',   2024, 750, 47.0, 228,  9500, 'Ciudad / carretera',  'La mas accesible de Harley en Ecuador.')
    ON CONFLICT DO NOTHING;

    -- ─── SHINERAY ───────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (shineray_id, dual_id, 'XY200GY',      2025, 200, 14.0, 125, 2000, 'Off-road / carretera', 'Buena relacion precio-prestaciones. Marca mas vendida Ecuador 2024.'),
    (shineray_id, dual_id, 'XY150GY-10A',  2025, 150, 11.0, 115, 1700, 'Campo / trabajo',      'Uso agricola y rural. Alta resistencia.')
    ON CONFLICT DO NOTHING;

    -- ─── DAYTONA ────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (daytona_id, dual_id, 'Sprinter 200', 2025, 200, 15.0, 128, 2100, 'Off-road / trabajo', 'Popular en zonas rurales. Segunda marca mas vendida Ecuador 2024.'),
    (daytona_id, util_id, 'VX 125',       2025, 125, 10.0, 110, 1650, 'Ciudad / trabajo',   'Economica y confiable. Opcion de entrada.')
    ON CONFLICT DO NOTHING;

    -- ─── FACTORY BIKE ───────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (factory_id, dual_id, 'FK200-10', 2025, 200, 15.0, 127, 2200, 'Aventura / trabajo', 'Disponible en Moto Power. Buen equipamiento base.'),
    (factory_id, util_id, 'FK150',    2025, 150, 12.0, 118, 1800, 'Ciudad / delivery',  'Economica. Uso intensivo.')
    ON CONFLICT DO NOTHING;

    -- ─── AKT ────────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (akt_id, dual_id,  'TT 150',  2025, 150, 12.6, 122, 2300, 'Campo / ciudad', 'Marca colombiana presente en Ecuador.'),
    (akt_id, naked_id, 'NKD 125', 2025, 125,  9.0, 115, 1900, 'Ciudad',         'Naked de entrada. Precio accesible.')
    ON CONFLICT DO NOTHING;

    -- ─── BENELLI ────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (benelli_id, adv_id, 'TRK 502', 2025, 500, 47.0, 238, 8500, 'Touring / aventura', 'Italiana. Disponible en Moto Power.')
    ON CONFLICT DO NOTHING;

    -- ─── TVS ────────────────────────────────────────────────
    INSERT INTO motocicletas (marca_id,tipo_id,modelo,anio,cilindrada_cc,potencia_hp,peso_kg,precio_usd,uso_recomendado,observaciones) VALUES
    (tvs_id, naked_id, 'Apache RTR 200', 2025, 199, 20.8, 148, 3200, 'Ciudad / sport', 'India. Buena relacion precio-rendimiento.')
    ON CONFLICT DO NOTHING;

END $$;
