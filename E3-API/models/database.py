"""
Conexión a PostgreSQL con SQLAlchemy
MotoEdu EC — UPS Cuenca 2026
"""
import os
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker, DeclarativeBase

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://motoeduc_user:MotoEduC_2026$@localhost:5432/motoeduc"
)

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class Base(DeclarativeBase):
    pass


def get_db():
    """Dependency para obtener sesión de DB en cada request."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def check_connection():
    """Verifica que la conexión a PostgreSQL esté activa."""
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        return True
    except Exception as e:
        print(f"Error de conexión: {e}")
        return False
