"""Router: Perfiles + Motor de Clasificación — MotoEdu EC"""
from fastapi import APIRouter, Depends, Body
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db

router = APIRouter()

@router.get("/", summary="Lista todos los perfiles de motociclista")
def listar_perfiles(db: Session = Depends(get_db)):
    result = db.execute(text("SELECT * FROM perfiles_motociclista ORDER BY id")).mappings().all()
    return {"total": len(result), "perfiles": [dict(r) for r in result]}


@router.post("/clasificar", summary="Clasifica a un usuario segun sus respuestas")
def clasificar_motociclista(
    datos: dict = Body(..., example={
        "uso_principal": "delivery",
        "tipo_moto": "utilitaria",
        "anos_experiencia": 2,
        "cilindrada_cc": 150,
        "horas_diarias": 8,
        "provincia": "Guayas"
    }),
    db: Session = Depends(get_db)
):
    uso = datos.get("uso_principal", "").lower()
    tipo = datos.get("tipo_moto", "").lower()
    anos = datos.get("anos_experiencia", 0)
    cilindrada = datos.get("cilindrada_cc", 125)
    horas = datos.get("horas_diarias", 0)

    # Motor de clasificacion de perfiles
    perfil = "Urbano Diario"  # default

    if "delivery" in uso or "mensajeria" in uso or horas >= 6:
        perfil = "Delivery"
    elif "enduro" in uso or "enduro" in tipo or "motocross" in tipo:
        perfil = "Enduro"
    elif "aventura" in uso or "off-road" in uso or "doble" in tipo:
        perfil = "Aventura Off-road"
    elif "touring" in uso or "carretera" in uso or cilindrada >= 400:
        perfil = "Touring"
    elif "deport" in uso or "sport" in tipo or "naked" in tipo and cilindrada >= 300:
        perfil = "Deportivo"
    elif "urbano" in uso or "ciudad" in uso or cilindrada < 200:
        perfil = "Urbano Diario"

    # Obtener datos del perfil
    perfil_data = db.execute(text(
        "SELECT * FROM perfiles_motociclista WHERE nombre = :nombre"
    ), {"nombre": perfil}).mappings().first()

    # Obtener motos recomendadas para ese perfil
    motos_rec = db.execute(text("""
        SELECT ma.nombre AS marca, m.modelo, m.cilindrada_cc, m.precio_usd
        FROM motocicletas m
        JOIN marcas_moto ma ON m.marca_id = ma.id
        JOIN tipos_moto t ON m.tipo_id = t.id
        WHERE t.nombre = ANY(:tipos) AND m.disponible_ec = TRUE
        ORDER BY m.precio_usd ASC LIMIT 3
    """), {"tipos": _tipos_por_perfil(perfil)}).mappings().all()

    return {
        "perfil_asignado": perfil,
        "datos_perfil": dict(perfil_data) if perfil_data else {},
        "motos_recomendadas": [dict(m) for m in motos_rec],
        "recomendaciones_seguridad": _recomendaciones_seguridad(perfil)
    }


def _tipos_por_perfil(perfil: str) -> list:
    mapa = {
        "Delivery":          ["Utilitaria"],
        "Urbano Diario":     ["Utilitaria", "Scooter", "Naked/Street"],
        "Touring":           ["Adventure/Touring", "Naked/Street"],
        "Aventura Off-road": ["Doble proposito", "Adventure/Touring"],
        "Enduro":            ["Enduro/Trail", "Motocross"],
        "Deportivo":         ["Deportiva", "Naked/Street"],
    }
    return mapa.get(perfil, ["Utilitaria"])


def _recomendaciones_seguridad(perfil: str) -> list:
    mapa = {
        "Delivery":          ["Casco integral certificado ECE/DOT", "Chaleco reflectivo OBLIGATORIO", "Botas de trabajo cerradas", "Guantes urbanos"],
        "Urbano Diario":     ["Casco integral o modular ECE", "Chaqueta 3 en 1 (frio sierra)", "Guantes touring", "Botas touring o urbanas"],
        "Touring":           ["Casco modular o integral premium", "Chaqueta cuero o 3 en 1", "Guantes touring reforzados", "Botas touring", "Espaldera nivel 2"],
        "Aventura Off-road": ["Casco adventure dual sport", "Chaqueta off-road con pechera", "Guantes off-road exteriores", "Botas enduro", "Rodilleras articuladas", "Coderas"],
        "Enduro":            ["Casco cross o enduro", "Body armor completo", "Rodilleras articuladas nivel 2", "Botas enduro rigidas", "Gogles"],
        "Deportivo":         ["Casco integral premium (Shoei/Arai/AGV)", "Chaqueta cuero completa CE nivel 2", "Guantes racing CE nivel 2", "Botas racing", "Espaldera nivel 2"],
    }
    return mapa.get(perfil, ["Casco certificado", "Chaleco reflectivo"])
