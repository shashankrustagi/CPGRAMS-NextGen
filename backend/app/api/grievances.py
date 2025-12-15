from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from app.db.session import SessionLocal
from app.schemas.grievance import GrievanceCreate, GrievanceResponse
from app.services.grievance_service import GrievanceService

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=GrievanceResponse)
def create(grievance: GrievanceCreate, db: Session = Depends(get_db)):
    return GrievanceService(db).create(grievance, user_id=1)

@router.get("/", response_model=List[GrievanceResponse])
def list_all(db: Session = Depends(get_db)):
    return GrievanceService(db).list(user_id=1)
