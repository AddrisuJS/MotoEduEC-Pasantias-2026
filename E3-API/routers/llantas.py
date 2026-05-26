"""
Router: Llantas
MotoEdu EC — UPS Cuenca 2026
"""
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db
from typing import Optional

router = APIRouter()

@router.get("/", summary="Lista todas las llantas disponibles")
def listar_llantas(
    db: Session = Depends(get_db),
    gama: Optional[str] = Query(None, description="alta / media / economica"),
    tipo: Optional[str] = Query(None, description="Carretera, Trail, Off-road..."),
):
    query = """
        SELECT l.id, ml.nombre AS marca, ml.gama, tl.nombre AS tipo,
               l.modelo, l.medida_ejemplo, l.precio_min_usd, l.precio_max_usd, l.descripcion,
               tl.terreno_ideal, tl.clima_ideal
        FROM llantas l
        JOIN marcas_llanta ml ON l.marca_id = ml.id
        JOIN tipos_llanta tl ON l.tipo_id = tl.id
        WHERE 1=1
    """
    params = {}
    if gama:
        query += " AND ml.gama = :gama"
        params["gama"] = gama
    if tipo:
        query += " AND LOWER(tl.nombre) LIKE LOWER(:tipo)"
        params["tipo"] = f"%{tipo}%"
    query += " ORDER BY ml.gama, ml.nombre"
    result = db.execute(text(query), params).mappings().all()
    return {"total": len(result), "llantas": [dict(r) for r in result]}


@router.get("/recomendar", summary="Recomienda llanta segun tipo de moto y uso")
def recomendar_llanta(
    tipo_moto: str = Query(..., description="Tipo de moto: utilitaria, doble proposito, sport, touring, enduro"),
    uso: str = Query(..., description="ciudad, carretera, offroad, lluvia"),
    db: Session = Depends(get_db)
):
    tipo_llanta_map = {
        ("utilitaria",     "ciudad"):    "Carretera (Road)",
        ("utilitaria",     "carretera"): "Carretera (Road)",
        ("sport",          "carretera"): "Carretera (Road)",
        ("sport",          "ciudad"):    "Carretera (Road)",
        ("doble proposito","carretera"): "Trail/Adventure",
        ("doble proposito","offroad"):   "Off-road/Enduro",
        ("touring",        "carretera"): "Trail/Adventure",
        ("enduro",         "offroad"):   "Off-road/Enduro",
        ("scooter",        "ciudad"):    "Scooter",
        ("utilitaria",     "lluvia"):    "Lluvia/Rain",
    }
    tipo_llanta = tipo_llanta_map.get((tipo_moto.lower(), uso.lower()), "Trail/Adventure")
    result = db.execute(text("""
        SELECT l.id, ml.nombre AS marca, ml.gama, tl.nombre AS tipo,
               l.modelo, l.medida_ejemplo, l.precio_min_usd, l.precio_max_usd
        FROM llantas l
        JOIN marcas_llanta ml ON l.marca_id = ml.id
        JOIN tipos_llanta tl ON l.tipo_id = tl.id
        WHERE tl.nombre = :tipo_llanta
        ORDER BY ml.gama DESC, l.precio_min_usd ASC
        LIMIT 5
    """), {"tipo_llanta": tipo_llanta}).mappings().all()
    return {
        "tipo_moto": tipo_moto,
        "uso": uso,
        "tipo_llanta_recomendada": tipo_llanta,
        "opciones": [dict(r) for r in result]
    }
