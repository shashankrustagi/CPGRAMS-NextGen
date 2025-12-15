from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import SessionLocal
from app.schemas.auth import OTPRequest, OTPVerify, TokenResponse
from app.services.auth_service import AuthService

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/send-otp")
def send_otp(req: OTPRequest):
    # TEMP: hardcoded OTP
    return {"message": "OTP sent", "otp": "123456"}

@router.post("/verify-otp", response_model=TokenResponse)
def verify_otp(req: OTPVerify, db: Session = Depends(get_db)):
    if req.otp != "123456":
        raise HTTPException(status_code=401, detail="Invalid OTP")

    token = AuthService(db).login(req.phone)
    return {"access_token": token, "token_type": "bearer"}
