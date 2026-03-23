import os
import psycopg2
import psycopg2.extras
from dotenv import load_dotenv
from pathlib import Path

# Procura o .env na raiz do projeto (um nível acima de /app)
load_dotenv(dotenv_path=Path(__file__).parent.parent / ".env")

def get_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME", "atthena"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", ""),
    )

def run_query(sql: str) -> list[dict]:
    """Executa um SQL e retorna lista de dicts."""
    with get_connection() as conn:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
            cur.execute(sql)
            return [dict(row) for row in cur.fetchall()]
