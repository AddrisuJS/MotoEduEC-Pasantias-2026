"""
MotoEdu EC — API REST
Universidad Politécnica Salesiana — Cuenca 2026
Pasantías: Sanango Romero José Addrisu
Tutor: Omar Gustavo Bravo Quezada Ph.D
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import motos, llantas, equipamiento, perfiles, preguntas, evaluaciones, estadisticas

app = FastAPI(
    title="MotoEdu EC — API",
    description="""
    ## Plataforma Inteligente de Educación Vial para Motociclistas Ecuatorianos
    
    API REST desarrollada con FastAPI para la plataforma MotoEdu EC.
    
    ### Módulos disponibles:
    - **Motos** — Catálogo de motocicletas disponibles en Ecuador 2024-2026
    - **Llantas** — Tipos y marcas de llantas recomendadas
    - **Equipamiento** — Catálogo de equipamiento de seguridad por gama
    - **Perfiles** — Clasificación de motociclistas por perfil de uso
    - **Preguntas** — Dataset de preguntas viales para evaluaciones
    - **Evaluaciones** — Registro de resultados de evaluaciones de usuarios
    - **Estadísticas** — Dashboard de brechas y KPIs de conocimiento vial
    
    **UPS Cuenca 2026** | Tutor: Omar Gustavo Bravo Quezada Ph.D
    """,
    version="1.0.0",
    contact={
        "name": "Sanango Romero José Addrisu",
        "email": "jsanangor@est.ups.edu.ec",
    },
    license_info={
        "name": "UPS Cuenca — Uso Académico",
    }
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Registrar routers
app.include_router(motos.router,         prefix="/motos",         tags=["🏍️ Motocicletas"])
app.include_router(llantas.router,       prefix="/llantas",       tags=["🔵 Llantas"])
app.include_router(equipamiento.router,  prefix="/equipamiento",  tags=["🪖 Equipamiento"])
app.include_router(perfiles.router,      prefix="/perfiles",      tags=["👤 Perfiles"])
app.include_router(preguntas.router,     prefix="/preguntas",     tags=["❓ Preguntas Viales"])
app.include_router(evaluaciones.router,  prefix="/evaluaciones",  tags=["📊 Evaluaciones"])
app.include_router(estadisticas.router,  prefix="/estadisticas",  tags=["📈 Estadísticas"])


@app.get("/", tags=["🏠 Home"])
def root():
    return {
        "proyecto": "MotoEdu EC",
        "version": "1.0.0",
        "descripcion": "Plataforma Inteligente de Educacion Vial para Motociclistas Ecuatorianos",
        "institucion": "Universidad Politecnica Salesiana — Cuenca",
        "docs": "/docs",
        "redoc": "/redoc",
        "estado": "activo"
    }


@app.get("/health", tags=["🏠 Home"])
def health_check():
    return {"status": "ok", "mensaje": "MotoEdu EC API funcionando correctamente"}
