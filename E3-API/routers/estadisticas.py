"""Router: Estadísticas y Brechas — MotoEdu EC"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from models.database import get_db

router = APIRouter()

@router.get("/brechas", summary="Mapa de brechas de conocimiento vial")
def mapa_brechas(db: Session = Depends(get_db)):
    result = db.execute(text(
        "SELECT * FROM brechas_conocimiento ORDER BY nivel_riesgo, pct_con_brecha DESC"
    )).mappings().all()
    return {"total_brechas": len(result), "brechas": [dict(r) for r in result]}


@router.get("/catalogo", summary="Estadisticas del catalogo de motos y llantas")
def estadisticas_catalogo(db: Session = Depends(get_db)):
    motos_por_tipo = db.execute(text("""
        SELECT t.nombre AS tipo, COUNT(*) AS total
        FROM motocicletas m JOIN tipos_moto t ON m.tipo_id = t.id
        GROUP BY t.nombre ORDER BY total DESC
    """)).mappings().all()
    motos_por_marca = db.execute(text("""
        SELECT ma.nombre AS marca, COUNT(*) AS total
        FROM motocicletas m JOIN marcas_moto ma ON m.marca_id = ma.id
        GROUP BY ma.nombre ORDER BY total DESC
    """)).mappings().all()
    llantas_por_gama = db.execute(text("""
        SELECT ml.gama, COUNT(*) AS total
        FROM llantas l JOIN marcas_llanta ml ON l.marca_id = ml.id
        GROUP BY ml.gama
    """)).mappings().all()
    preguntas_por_cat = db.execute(text("""
        SELECT c.nombre AS categoria, COUNT(*) AS total,
               COUNT(*) FILTER (WHERE p.dificultad='basico') AS basico,
               COUNT(*) FILTER (WHERE p.dificultad='intermedio') AS intermedio,
               COUNT(*) FILTER (WHERE p.dificultad='avanzado') AS avanzado
        FROM preguntas_viales p JOIN categorias_pregunta c ON p.categoria_id = c.id
        WHERE p.activa = TRUE
        GROUP BY c.nombre ORDER BY total DESC
    """)).mappings().all()
    return {
        "motos_por_tipo":    [dict(r) for r in motos_por_tipo],
        "motos_por_marca":   [dict(r) for r in motos_por_marca],
        "llantas_por_gama":  [dict(r) for r in llantas_por_gama],
        "preguntas_por_categoria": [dict(r) for r in preguntas_por_cat],
    }


@router.get("/resumen", summary="Resumen general del sistema")
def resumen_sistema(db: Session = Depends(get_db)):
    counts = {}
    tablas = ["motocicletas", "llantas", "equipamiento", "perfiles_motociclista",
              "preguntas_viales", "usuarios", "historial_evaluaciones"]
    for tabla in tablas:
        r = db.execute(text(f"SELECT COUNT(*) AS total FROM {tabla}")).scalar()
        counts[tabla] = r
    return {"resumen": counts, "estado": "activo"}
