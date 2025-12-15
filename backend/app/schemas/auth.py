from pydantic import BaseModel

class OTPRequest(BaseModel):
    phone: str

class OTPVerify(BaseModel):
    phone: str
    otp: str

class TokenResponse(BaseModel):
    access_token: str
