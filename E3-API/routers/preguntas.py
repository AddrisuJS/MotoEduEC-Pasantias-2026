"""Router: Preguntas Viales — MotoEdu EC"""
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db
from typing import Optional
import random

router = APIRouter()

@router.get("/", summary="Lista preguntas viales con filtros")
def listar_preguntas(
    db: Session = Depends(get_db),
    categoria: Optional[str] = Query(None),
    dificultad: Optional[str] = Query(None, description="basico / intermedio / avanzado"),
    activa: bool = Query(True),
):
    query = """
        SELECT p.id, c.nombre AS categoria, p.pregunta,
               p.respuesta_correcta, p.opcion_b, p.opcion_c, p.opcion_d,
               p.dificultad, p.perfil_objetivo, p.fuente
        FROM preguntas_viales p
        JOIN categorias_pregunta c ON p.categoria_id = c.id
        WHERE p.activa = :activa
    """
    params = {"activa": activa}
    if categoria:
        query += " AND LOWER(c.nombre) LIKE LOWER(:categoria)"
        params["categoria"] = f"%{categoria}%"
    if dificultad:
        query += " AND p.dificultad = :dificultad"
        params["dificultad"] = dificultad
    query += " ORDER BY c.nombre, p.dificultad"
    result = db.execute(text(query), params).mappings().all()
    return {"total": len(result), "preguntas": [dict(r) for r in result]}


@router.get("/quiz", summary="Genera un quiz aleatorio de N preguntas")
def generar_quiz(
    n: int = Query(10, description="Numero de preguntas (max 20)", le=20, ge=1),
    dificultad: Optional[str] = Query(None),
    categoria: Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    query = """
        SELECT p.id, c.nombre AS categoria, p.pregunta,
               p.respuesta_correcta, p.opcion_b, p.opcion_c, p.opcion_d,
               p.dificultad
        FROM preguntas_viales p
        JOIN categorias_pregunta c ON p.categoria_id = c.id
        WHERE p.activa = TRUE
    """
    params = {}
    if dificultad:
        query += " AND p.dificultad = :dificultad"
        params["dificultad"] = dificultad
    if categoria:
        query += " AND LOWER(c.nombre) LIKE LOWER(:categoria)"
        params["categoria"] = f"%{categoria}%"
    result = db.execute(text(query), params).mappings().all()
    preguntas = [dict(r) for r in result]
    if len(preguntas) > n:
        preguntas = random.sample(preguntas, n)
    # Mezclar opciones en cada pregunta
    for p in preguntas:
        opciones = [p["respuesta_correcta"]]
        for k in ["opcion_b", "opcion_c", "opcion_d"]:
            if p.get(k):
                opciones.append(p[k])
        random.shuffle(opciones)
        p["opciones_mezcladas"] = opciones
    return {"total_preguntas": len(preguntas), "quiz": preguntas}
