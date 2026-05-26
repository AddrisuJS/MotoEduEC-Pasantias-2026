"""Router: Evaluaciones — MotoEdu EC"""
from fastapi import APIRouter, Depends, Body
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db
import uuid

router = APIRouter()

@router.post("/", summary="Registra el resultado de una evaluacion")
def registrar_evaluacion(
    datos: dict = Body(..., example={
        "usuario_id": "uuid-del-usuario",
        "pregunta_id": 1,
        "respuesta_dada": "50 km/h",
        "correcta": True,
        "tiempo_seg": 12
    }),
    db: Session = Depends(get_db)
):
    try:
        db.execute(text("""
            INSERT INTO historial_evaluaciones
                (usuario_id, pregunta_id, respuesta_dada, correcta, tiempo_seg)
            VALUES (:usuario_id, :pregunta_id, :respuesta_dada, :correcta, :tiempo_seg)
        """), {
            "usuario_id": datos.get("usuario_id"),
            "pregunta_id": datos.get("pregunta_id"),
            "respuesta_dada": datos.get("respuesta_dada"),
            "correcta": datos.get("correcta", False),
            "tiempo_seg": datos.get("tiempo_seg")
        })
        db.commit()
        return {"mensaje": "Evaluacion registrada correctamente"}
    except Exception as e:
        db.rollback()
        return {"error": str(e)}


@router.get("/usuario/{usuario_id}", summary="Historial de evaluaciones de un usuario")
def historial_usuario(usuario_id: str, db: Session = Depends(get_db)):
    result = db.execute(text("""
        SELECT h.id, c.nombre AS categoria, p.pregunta,
               h.respuesta_dada, h.correcta, h.tiempo_seg, h.fecha
        FROM historial_evaluaciones h
        JOIN preguntas_viales p ON h.pregunta_id = p.id
        JOIN categorias_pregunta c ON p.categoria_id = c.id
        WHERE h.usuario_id = :uid
        ORDER BY h.fecha DESC
    """), {"uid": usuario_id}).mappings().all()
    total = len(result)
    correctas = sum(1 for r in result if r["correcta"])
    return {
        "usuario_id": usuario_id,
        "total_respuestas": total,
        "correctas": correctas,
        "pct_acierto": round(100 * correctas / total, 1) if total > 0 else 0,
        "historial": [dict(r) for r in result]
    }
