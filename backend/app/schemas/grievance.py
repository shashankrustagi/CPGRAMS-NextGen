from pydantic import BaseModel
from datetime import datetime

class GrievanceCreate(BaseModel):
    title: str
    description: str
    category: str
    location: str

class GrievanceResponse(BaseModel):
    id: int
    title: str
    status: str
    created_at: datetime

    class Config:
        from_attributes = True
