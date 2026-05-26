# 🏍️ MotoEdu EC — Pasantías 2026

**Universidad Politécnica Salesiana — Sede Cuenca**  
**Carrera de Ingeniería de Sistemas**

> Construcción de la base de conocimiento, servicios inteligentes e infraestructura tecnológica para la plataforma de educación vial y recomendación de motocicletas.

**Estudiante:** Sanango Romero José Addrisu — jsanangor@est.ups.edu.ec  
**Tutor:** Omar Gustavo Bravo Quezada Ph.D — obravo@ups.edu.ec  
**Periodo:** 03 al 27 de junio de 2026 · 200 horas

---

## 🚀 Levantar todo el proyecto con 1 comando

```bash
git clone https://github.com/AddrisuJS/MotoEduEC-Pasantias-2026
cd MotoEduEC-Pasantias-2026
cp .env.example .env
docker-compose up -d
```

### Accesos después de ejecutar:

| Servicio | URL | Descripción |
|---------|-----|-------------|
| **API + Swagger** | http://localhost:8000/docs | Documentación interactiva completa |
| **API ReDoc** | http://localhost:8000/redoc | Documentación alternativa |
| **pgAdmin** | http://localhost:5050 | Administrador visual de PostgreSQL |
| **PostgreSQL** | localhost:5432 | BD directa (user: motoeduc_user) |
| **ChromaDB** | http://localhost:8001 | Base de datos vectorial RAG |

---

## 📦 Estructura del Proyecto

```
MotoEduEC-Pasantias-2026/
├── README.md
├── docker-compose.yml
├── .env.example
├── E1-ER/
│   ├── create_tables.sql        ← Esquema completo PostgreSQL
│   └── README.md
├── E2-BD/
│   ├── seed_marcas.sql          ← Marcas, tipos, llantas, equipamiento
│   ├── seed_motocicletas.sql    ← 40+ modelos Ecuador 2024-2026
│   ├── seed_llantas.sql         ← 20+ llantas con precios
│   ├── seed_equipamiento.sql    ← Equipamiento + perfiles + brechas
│   └── README.md
├── E3-API/
│   ├── main.py                  ← FastAPI app principal
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── routers/
│   │   ├── motos.py             ← GET /motos, recomendaciones
│   │   ├── llantas.py           ← GET /llantas, recomendaciones
│   │   ├── equipamiento.py      ← GET /equipamiento
│   │   ├── perfiles.py          ← GET /perfiles, POST /clasificar
│   │   ├── preguntas.py         ← GET /preguntas, GET /quiz
│   │   ├── evaluaciones.py      ← POST evaluaciones, GET historial
│   │   └── estadisticas.py      ← GET brechas, catalogo, resumen
│   ├── models/
│   │   └── database.py          ← Conexión SQLAlchemy
│   └── tests/
│       └── test_endpoints.py
├── E4-DATASET/
│   ├── dataset_preguntas_viales.json
│   ├── dataset_preguntas_viales.csv
│   ├── load_chromadb.py
│   └── README.md
└── E5-POWERBI/
    ├── instrucciones_conexion.md
    └── README.md
```

---

## 🛠️ Stack Tecnológico

| Tecnología | Versión | Uso |
|-----------|---------|-----|
| PostgreSQL | 16 | Base de datos relacional principal |
| FastAPI | 0.115 | API REST con Swagger automático |
| SQLAlchemy | 2.0 | ORM para Python |
| ChromaDB | 0.5 | Base de datos vectorial para RAG |
| Docker | 29+ | Contenedores |
| Python | 3.11 | Lenguaje principal |
| Power BI | Desktop | Dashboard de análisis |

---

## 📊 Entregables

| # | Entregable | Descripción | Estado |
|---|-----------|-------------|--------|
| E1 | Modelo E-R + SQL | 14 tablas, 3 vistas, índices | ✅ |
| E2 | BD con datos reales | 40+ motos, 20+ llantas, 30+ equipamiento, 6 perfiles, 8 brechas | ✅ |
| E3 | API REST + Swagger | 13 endpoints, motor de clasificación de perfiles | ✅ |
| E4 | Dataset 200+ Q&A + ChromaDB | Dataset vial + base vectorial RAG | 🔄 S4 |
| E5 | Dashboard Power BI | Conectado a PostgreSQL | 🔄 S5 |
| E6 | Repositorio GitHub | Este repositorio | ✅ |

---

## 📡 Endpoints Principales

```
GET  /                          → Info del proyecto
GET  /health                    → Health check
GET  /motos                     → Lista motos (filtros: marca, tipo, año, precio)
GET  /motos/{id}                → Detalle de una moto
GET  /motos/recomendar/por-perfil → Motos recomendadas por perfil
GET  /llantas                   → Lista llantas (filtros: gama, tipo)
GET  /llantas/recomendar        → Llanta por tipo de moto y uso
GET  /equipamiento              → Catálogo equipamiento (filtros: tipo, gama)
GET  /perfiles                  → Lista perfiles de motociclista
POST /perfiles/clasificar       → Clasifica usuario → asigna perfil automático
GET  /preguntas                 → Lista preguntas viales
GET  /preguntas/quiz            → Quiz aleatorio de N preguntas
POST /evaluaciones              → Registra resultado de evaluación
GET  /evaluaciones/usuario/{id} → Historial de un usuario
GET  /estadisticas/brechas      → Mapa de brechas de conocimiento
GET  /estadisticas/catalogo     → Stats del catálogo
GET  /estadisticas/resumen      → Resumen general del sistema
```

---

## 🔗 Repositorio

**GitHub:** https://github.com/AddrisuJS/MotoEduEC-Pasantias-2026

---

*MotoEdu EC · UPS Cuenca 2026 · Pasantías de Ingeniería de Sistemas*
