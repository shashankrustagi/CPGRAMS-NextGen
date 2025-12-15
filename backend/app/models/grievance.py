from sqlalchemy import Column, Integer, String, Text, DateTime, Enum, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
import enum
from app.db.base import Base

class GrievanceStatus(str, enum.Enum):
    submitted = "submitted"
    in_progress = "in_progress"
    resolved = "resolved"
    escalated = "escalated"

class Grievance(Base):
    __tablename__ = "grievances"

    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=False)
    category = Column(String, nullable=False)
    location = Column(String, nullable=False)
    status = Column(Enum(GrievanceStatus), default=GrievanceStatus.submitted)
    user_id = Column(Integer, ForeignKey("users.id"))
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    history = relationship("GrievanceStatusHistory", back_populates="grievance")
