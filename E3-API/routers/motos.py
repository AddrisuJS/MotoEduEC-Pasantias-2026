"""
Router: Motocicletas
MotoEdu EC — UPS Cuenca 2026
"""
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db
from typing import Optional

router = APIRouter()


@router.get("/", summary="Lista todas las motos disponibles en Ecuador")
def listar_motos(
    db: Session = Depends(get_db),
    marca: Optional[str] = Query(None, description="Filtrar por marca (Honda, Yamaha, KTM...)"),
    tipo: Optional[str] = Query(None, description="Filtrar por tipo (Utilitaria, Naked/Street...)"),
    anio: Optional[int] = Query(None, description="Filtrar por año"),
    precio_max: Optional[float] = Query(None, description="Precio máximo en USD"),
    disponible: bool = Query(True, description="Solo motos disponibles en Ecuador")
):
    query = """
        SELECT m.id, ma.nombre AS marca, m.modelo, m.anio, t.nombre AS tipo,
               m.cilindrada_cc, m.potencia_hp, m.peso_kg, m.precio_usd,
               m.uso_recomendado, m.observaciones
        FROM motocicletas m
        JOIN marcas_moto ma ON m.marca_id = ma.id
        JOIN tipos_moto t ON m.tipo_id = t.id
        WHERE m.disponible_ec = :disponible
    """
    params = {"disponible": disponible}
    if marca:
        query += " AND LOWER(ma.nombre) LIKE LOWER(:marca)"
        params["marca"] = f"%{marca}%"
    if tipo:
        query += " AND LOWER(t.nombre) LIKE LOWER(:tipo)"
        params["tipo"] = f"%{tipo}%"
    if anio:
        query += " AND m.anio = :anio"
        params["anio"] = anio
    if precio_max:
        query += " AND m.precio_usd <= :precio_max"
        params["precio_max"] = precio_max
    query += " ORDER BY ma.nombre, m.modelo"
    result = db.execute(text(query), params).mappings().all()
    return {"total": len(result), "motos": [dict(r) for r in result]}


@router.get("/{moto_id}", summary="Detalle completo de una moto")
def detalle_moto(moto_id: int, db: Session = Depends(get_db)):
    result = db.execute(text("""
        SELECT m.*, ma.nombre AS marca_nombre, ma.distribuidor_ec, ma.sitio_web,
               t.nombre AS tipo_nombre, t.uso_tipico
        FROM motocicletas m
        JOIN marcas_moto ma ON m.marca_id = ma.id
        JOIN tipos_moto t ON m.tipo_id = t.id
        WHERE m.id = :id
    """), {"id": moto_id}).mappings().first()
    if not result:
        from fastapi import HTTPException
        raise HTTPException(status_code=404, detail="Moto no encontrada")
    return dict(result)


@router.get("/recomendar/por-perfil", summary="Recomienda motos segun perfil de motociclista")
def recomendar_motos(
    perfil: str = Query(..., description="Perfil: Delivery, Urbano Diario, Touring, Aventura Off-road, Enduro, Deportivo"),
    presupuesto_max: Optional[float] = Query(None, description="Presupuesto maximo en USD"),
    db: Session = Depends(get_db)
):
    # Mapeo de perfil a tipos y precios sugeridos
    perfil_config = {
        "Delivery":          {"tipos": ["Utilitaria"], "precio_max": 3000},
        "Urbano Diario":     {"tipos": ["Utilitaria", "Scooter", "Naked/Street"], "precio_max": 4000},
        "Touring":           {"tipos": ["Adventure/Touring", "Naked/Street"], "precio_max": 20000},
        "Aventura Off-road": {"tipos": ["Doble proposito", "Adventure/Touring"], "precio_max": 15000},
        "Enduro":            {"tipos": ["Enduro/Trail", "Motocross"], "precio_max": 15000},
        "Deportivo":         {"tipos": ["Deportiva", "Naked/Street"], "precio_max": 15000},
    }
    config = perfil_config.get(perfil, {"tipos": ["Utilitaria"], "precio_max": 5000})
    precio_limite = presupuesto_max or config["precio_max"]
    tipos_str = ", ".join([f"'{t}'" for t in config["tipos"]])
    result = db.execute(text(f"""
        SELECT m.id, ma.nombre AS marca, m.modelo, m.anio, t.nombre AS tipo,
               m.cilindrada_cc, m.precio_usd, m.uso_recomendado
        FROM motocicletas m
        JOIN marcas_moto ma ON m.marca_id = ma.id
        JOIN tipos_moto t ON m.tipo_id = t.id
        WHERE t.nombre IN ({tipos_str})
          AND m.precio_usd <= :precio_max
          AND m.disponible_ec = TRUE
        ORDER BY m.precio_usd ASC
        LIMIT 5
    """), {"precio_max": precio_limite}).mappings().all()
    return {
        "perfil": perfil,
        "presupuesto_max_usd": precio_limite,
        "recomendaciones": [dict(r) for r in result]
    }
