"""Router: Equipamiento — MotoEdu EC"""
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db
from typing import Optional

router = APIRouter()

@router.get("/", summary="Catalogo completo de equipamiento de seguridad")
def listar_equipamiento(
    db: Session = Depends(get_db),
    tipo: Optional[str] = Query(None, description="Casco, Chaqueta, Guantes, Botas..."),
    gama: Optional[str] = Query(None, description="alta / media / economica"),
    precio_max: Optional[float] = Query(None),
):
    query = """
        SELECT e.id, te.nombre AS tipo, e.marca, e.modelo, e.subtipo,
               e.gama, e.certificacion, e.precio_min_usd, e.precio_max_usd,
               e.clima_uso, e.descripcion
        FROM equipamiento e
        JOIN tipos_equipamiento te ON e.tipo_id = te.id
        WHERE 1=1
    """
    params = {}
    if tipo:
        query += " AND LOWER(te.nombre) LIKE LOWER(:tipo)"
        params["tipo"] = f"%{tipo}%"
    if gama:
        query += " AND e.gama = :gama"
        params["gama"] = gama
    if precio_max:
        query += " AND e.precio_min_usd <= :precio_max"
        params["precio_max"] = precio_max
    query += " ORDER BY te.nombre, e.gama, e.precio_min_usd"
    result = db.execute(text(query), params).mappings().all()
    return {"total": len(result), "equipamiento": [dict(r) for r in result]}
