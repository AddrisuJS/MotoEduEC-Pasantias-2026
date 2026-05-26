-- ============================================================
-- MotoEdu EC — Esquema de Base de Datos PostgreSQL 16
-- Universidad Politécnica Salesiana — Cuenca 2026
-- Pasantías: Sanango Romero José Addrisu
-- Tutor: Omar Gustavo Bravo Quezada Ph.D
-- ============================================================

-- Extensión para UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ─────────────────────────────────────────────────────────────
-- TABLA: marcas_moto
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS marcas_moto (
    id              SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL UNIQUE,
    origen          VARCHAR(100) NOT NULL,
    distribuidor_ec VARCHAR(200),
    garantia_meses  INTEGER DEFAULT 24,
    sitio_web       VARCHAR(300),
    activa          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT NOW()
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: tipos_moto
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS tipos_moto (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    uso_tipico  VARCHAR(200)
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: motocicletas
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS motocicletas (
    id                  SERIAL PRIMARY KEY,
    marca_id            INTEGER NOT NULL REFERENCES marcas_moto(id),
    tipo_id             INTEGER NOT NULL REFERENCES tipos_moto(id),
    modelo              VARCHAR(150) NOT NULL,
    anio                INTEGER NOT NULL CHECK (anio >= 2020 AND anio <= 2027),
    cilindrada_cc       INTEGER NOT NULL CHECK (cilindrada_cc > 0),
    potencia_hp         DECIMAL(6,2),
    peso_kg             DECIMAL(6,2),
    velocidad_max_kmh   INTEGER,
    precio_usd          DECIMAL(10,2),
    uso_recomendado     VARCHAR(200),
    observaciones       TEXT,
    disponible_ec       BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_motos_marca ON motocicletas(marca_id);
CREATE INDEX IF NOT EXISTS idx_motos_tipo ON motocicletas(tipo_id);
CREATE INDEX IF NOT EXISTS idx_motos_anio ON motocicletas(anio);
CREATE INDEX IF NOT EXISTS idx_motos_precio ON motocicletas(precio_usd);

-- ─────────────────────────────────────────────────────────────
-- TABLA: tipos_llanta
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS tipos_llanta (
    id              SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL UNIQUE,
    descripcion     TEXT,
    terreno_ideal   VARCHAR(200),
    clima_ideal     VARCHAR(200),
    no_recomendada  VARCHAR(200)
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: marcas_llanta
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS marcas_llanta (
    id      SERIAL PRIMARY KEY,
    nombre  VARCHAR(100) NOT NULL UNIQUE,
    origen  VARCHAR(100),
    gama    VARCHAR(20) CHECK (gama IN ('alta','media','economica'))
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: llantas
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS llantas (
    id              SERIAL PRIMARY KEY,
    marca_id        INTEGER NOT NULL REFERENCES marcas_llanta(id),
    tipo_id         INTEGER NOT NULL REFERENCES tipos_llanta(id),
    modelo          VARCHAR(150),
    medida_ejemplo  VARCHAR(50),
    precio_min_usd  DECIMAL(8,2),
    precio_max_usd  DECIMAL(8,2),
    descripcion     TEXT,
    created_at      TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_llantas_marca ON llantas(marca_id);
CREATE INDEX IF NOT EXISTS idx_llantas_tipo ON llantas(tipo_id);

-- ─────────────────────────────────────────────────────────────
-- TABLA: tipos_equipamiento
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS tipos_equipamiento (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: equipamiento
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS equipamiento (
    id              SERIAL PRIMARY KEY,
    tipo_id         INTEGER NOT NULL REFERENCES tipos_equipamiento(id),
    marca           VARCHAR(100) NOT NULL,
    modelo          VARCHAR(150),
    subtipo         VARCHAR(100),
    gama            VARCHAR(20) CHECK (gama IN ('alta','media','economica')),
    certificacion   VARCHAR(100),
    precio_min_usd  DECIMAL(8,2),
    precio_max_usd  DECIMAL(8,2),
    clima_uso       VARCHAR(100),
    descripcion     TEXT,
    created_at      TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_equip_tipo ON equipamiento(tipo_id);
CREATE INDEX IF NOT EXISTS idx_equip_gama ON equipamiento(gama);

-- ─────────────────────────────────────────────────────────────
-- TABLA: perfiles_motociclista
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS perfiles_motociclista (
    id                  SERIAL PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL UNIQUE,
    descripcion         TEXT,
    uso_principal       VARCHAR(200),
    motos_tipicas       VARCHAR(300),
    riesgos_principales VARCHAR(300),
    experiencia_min_anios INTEGER DEFAULT 0,
    velocidad_tipica_kmh  INTEGER,
    created_at          TIMESTAMP DEFAULT NOW()
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: categorias_pregunta
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS categorias_pregunta (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    modulo_app  VARCHAR(100)
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: preguntas_viales
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS preguntas_viales (
    id                  SERIAL PRIMARY KEY,
    categoria_id        INTEGER NOT NULL REFERENCES categorias_pregunta(id),
    pregunta            TEXT NOT NULL,
    respuesta_correcta  TEXT NOT NULL,
    opcion_b            TEXT,
    opcion_c            TEXT,
    opcion_d            TEXT,
    explicacion         TEXT,
    dificultad          VARCHAR(20) CHECK (dificultad IN ('basico','intermedio','avanzado')),
    perfil_objetivo     VARCHAR(100),
    fuente              VARCHAR(300),
    activa              BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_preguntas_cat ON preguntas_viales(categoria_id);
CREATE INDEX IF NOT EXISTS idx_preguntas_dif ON preguntas_viales(dificultad);

-- ─────────────────────────────────────────────────────────────
-- TABLA: brechas_conocimiento
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS brechas_conocimiento (
    id                  SERIAL PRIMARY KEY,
    descripcion         VARCHAR(300) NOT NULL,
    pct_con_brecha      DECIMAL(5,2),
    pct_sin_brecha      DECIMAL(5,2),
    nivel_riesgo        VARCHAR(20) CHECK (nivel_riesgo IN ('ALTO','MEDIO','BAJO')),
    modulo_relacionado  VARCHAR(100),
    fuente              VARCHAR(200),
    created_at          TIMESTAMP DEFAULT NOW()
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: usuarios
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS usuarios (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre              VARCHAR(200),
    email               VARCHAR(200) UNIQUE,
    provincia           VARCHAR(100),
    tipo_moto           VARCHAR(100),
    anos_experiencia    INTEGER DEFAULT 0,
    perfil_id           INTEGER REFERENCES perfiles_motociclista(id),
    nivel               VARCHAR(20) CHECK (nivel IN ('basico','intermedio','avanzado')) DEFAULT 'basico',
    puntos_acumulados   INTEGER DEFAULT 0,
    activo              BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMP DEFAULT NOW(),
    updated_at          TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_usuarios_perfil ON usuarios(perfil_id);
CREATE INDEX IF NOT EXISTS idx_usuarios_provincia ON usuarios(provincia);

-- ─────────────────────────────────────────────────────────────
-- TABLA: historial_evaluaciones
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS historial_evaluaciones (
    id              SERIAL PRIMARY KEY,
    usuario_id      UUID REFERENCES usuarios(id) ON DELETE CASCADE,
    pregunta_id     INTEGER REFERENCES preguntas_viales(id),
    respuesta_dada  TEXT,
    correcta        BOOLEAN NOT NULL,
    tiempo_seg      INTEGER,
    fecha           TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_historial_usuario ON historial_evaluaciones(usuario_id);
CREATE INDEX IF NOT EXISTS idx_historial_pregunta ON historial_evaluaciones(pregunta_id);
CREATE INDEX IF NOT EXISTS idx_historial_fecha ON historial_evaluaciones(fecha);

-- ─────────────────────────────────────────────────────────────
-- TABLA: recomendaciones_moto
-- (relaciona perfil → motos recomendadas)
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS recomendaciones_moto (
    id          SERIAL PRIMARY KEY,
    perfil_id   INTEGER NOT NULL REFERENCES perfiles_motociclista(id),
    moto_id     INTEGER NOT NULL REFERENCES motocicletas(id),
    prioridad   INTEGER DEFAULT 1,
    razon       TEXT,
    UNIQUE(perfil_id, moto_id)
);

-- ─────────────────────────────────────────────────────────────
-- TABLA: recomendaciones_llanta
-- (relaciona tipo de moto → llantas recomendadas)
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS recomendaciones_llanta (
    id          SERIAL PRIMARY KEY,
    tipo_moto_id INTEGER NOT NULL REFERENCES tipos_moto(id),
    llanta_id   INTEGER NOT NULL REFERENCES llantas(id),
    prioridad   INTEGER DEFAULT 1,
    razon       TEXT,
    UNIQUE(tipo_moto_id, llanta_id)
);

-- ─────────────────────────────────────────────────────────────
-- VISTAS útiles
-- ─────────────────────────────────────────────────────────────

-- Vista: motos con nombre de marca y tipo
CREATE OR REPLACE VIEW v_motos_completo AS
SELECT
    m.id,
    ma.nombre AS marca,
    m.modelo,
    m.anio,
    t.nombre AS tipo,
    m.cilindrada_cc,
    m.potencia_hp,
    m.peso_kg,
    m.precio_usd,
    m.uso_recomendado,
    m.disponible_ec
FROM motocicletas m
JOIN marcas_moto ma ON m.marca_id = ma.id
JOIN tipos_moto t ON m.tipo_id = t.id
ORDER BY ma.nombre, m.modelo;

-- Vista: preguntas con categoria
CREATE OR REPLACE VIEW v_preguntas_completo AS
SELECT
    p.id,
    c.nombre AS categoria,
    p.pregunta,
    p.respuesta_correcta,
    p.dificultad,
    p.perfil_objetivo,
    p.activa
FROM preguntas_viales p
JOIN categorias_pregunta c ON p.categoria_id = c.id
ORDER BY c.nombre, p.dificultad;

-- Vista: estadisticas de evaluaciones por usuario
CREATE OR REPLACE VIEW v_estadisticas_usuarios AS
SELECT
    u.id,
    u.nombre,
    u.provincia,
    p.nombre AS perfil,
    u.nivel,
    u.puntos_acumulados,
    COUNT(h.id) AS total_respuestas,
    SUM(CASE WHEN h.correcta THEN 1 ELSE 0 END) AS respuestas_correctas,
    ROUND(
        100.0 * SUM(CASE WHEN h.correcta THEN 1 ELSE 0 END) / NULLIF(COUNT(h.id), 0), 1
    ) AS pct_acierto
FROM usuarios u
LEFT JOIN perfiles_motociclista p ON u.perfil_id = p.id
LEFT JOIN historial_evaluaciones h ON u.id = h.usuario_id
GROUP BY u.id, u.nombre, u.provincia, p.nombre, u.nivel, u.puntos_acumulados;

-- ─────────────────────────────────────────────────────────────
-- FIN DEL ESQUEMA
-- ─────────────────────────────────────────────────────────────
COMMENT ON DATABASE motoeduc IS 'Base de datos MotoEdu EC — Plataforma de educacion vial para motociclistas ecuatorianos — UPS Cuenca 2026';
