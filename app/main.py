from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from query_engine import ask_llm

app = FastAPI(
    title="Atthena Financial Query API",
    description="Recebe perguntas em linguagem natural e retorna dados financeiros com rastreabilidade.",
    version="1.0.0",
)

class QueryRequest(BaseModel):
    question: str

class SourceInfo(BaseModel):
    document: str
    page: int | None
    section: str | None

class QueryResponse(BaseModel):
    answer: str
    value: float | None = None
    unit: str | None = None
    source: SourceInfo | None = None

@app.post("/query", response_model=QueryResponse)
def query(request: QueryRequest):
    if not request.question.strip():
        raise HTTPException(status_code=400, detail="A pergunta não pode ser vazia.")
    result = ask_llm(request.question)
    return result

@app.get("/health")
def health():
    return {"status": "ok"}
