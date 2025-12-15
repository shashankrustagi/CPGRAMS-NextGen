from fastapi import FastAPI
from app.db.session import engine
from app.db.base import Base

app = FastAPI()

@app.on_event("startup")
def startup():
    Base.metadata.create_all(bind=engine)
