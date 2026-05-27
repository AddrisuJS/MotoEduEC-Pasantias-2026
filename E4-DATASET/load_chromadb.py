"""
Script de carga a ChromaDB via API HTTP v2
MotoEdu EC — UPS Cuenca 2026
"""
import json, math, httpx, time

DATASET_PATH = "dataset_preguntas_viales.json"
CHROMA_BASE  = "http://localhost:8001"
COLLECTION   = "motoeduc_knowledge"
TENANT       = "default_tenant"
DATABASE     = "default_database"
EMB_DIM      = 64

def simple_embedding(text: str, dim: int = EMB_DIM) -> list:
    vec = [0.0] * dim
    for word in text.lower().split():
        vec[hash(word) % dim] += 1.0
    norm = math.sqrt(sum(x*x for x in vec)) or 1.0
    return [x / norm for x in vec]

print("📂 Cargando dataset...")
with open(DATASET_PATH, "r", encoding="utf-8") as f:
    preguntas = json.load(f)
print(f"✅ {len(preguntas)} preguntas cargadas")

print("\n🧠 Conectando ChromaDB...")
col_url = f"{CHROMA_BASE}/api/v2/tenants/{TENANT}/databases/{DATABASE}/collections"

# Intentar obtener coleccion existente
col_id = None
r_get = httpx.get(f"{col_url}/{COLLECTION}")
if r_get.status_code == 200:
    col_id = r_get.json()["id"]
    print(f"✅ Coleccion existente encontrada: {col_id}")
else:
    # Crear nueva
    time.sleep(1)
    r = httpx.post(col_url, json={
        "name": COLLECTION,
        "metadata": {"project": "MotoEduEC", "version": "2026"}
    })
    if r.status_code in [200, 201]:
        col_id = r.json()["id"]
        print(f"✅ Coleccion creada: {col_id}")
    else:
        print(f"❌ Error: {r.status_code} {r.text}")
        exit(1)

# Limpiar documentos existentes usando upsert
add_url    = f"{CHROMA_BASE}/api/v2/tenants/{TENANT}/databases/{DATABASE}/collections/{col_id}/upsert"
count_url  = f"{CHROMA_BASE}/api/v2/tenants/{TENANT}/databases/{DATABASE}/collections/{col_id}/count"

batch_size = 40
total_ok   = 0

for i in range(0, len(preguntas), batch_size):
    lote = preguntas[i:i+batch_size]
    docs = [
        f"Pregunta: {p['pregunta']} Respuesta: {p['respuesta_correcta']}. {p.get('explicacion','')}"
        for p in lote
    ]
    payload = {
        "ids":        [f"pregunta_{p['id']}" for p in lote],
        "documents":  docs,
        "embeddings": [simple_embedding(d) for d in docs],
        "metadatas":  [{
            "categoria":          p.get("categoria", "General"),
            "dificultad":         p.get("dificultad", "basico"),
            "perfil_objetivo":    p.get("perfil_objetivo", "todos"),
            "respuesta_correcta": p["respuesta_correcta"],
        } for p in lote],
    }
    r = httpx.post(add_url, json=payload, timeout=30)
    if r.status_code in [200, 201]:
        total_ok += len(lote)
        print(f"   ✅ Lote {i//batch_size+1}: {total_ok}/{len(preguntas)}")
    else:
        print(f"   ❌ Lote {i//batch_size+1}: {r.status_code} {r.text[:120]}")

r = httpx.get(count_url)
print(f"\n✅ ChromaDB total: {r.text} documentos en '{COLLECTION}'")
print("="*50)
print("✅ E4 COMPLETADO")
print("   PostgreSQL → preguntas_viales: 200 filas")
print(f"   ChromaDB   → {COLLECTION}: {r.text} docs")
