from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.db.base import Base

class GrievanceStatusHistory(Base):
    __tablename__ = "grievance_status_history"

    id = Column(Integer, primary_key=True)
    grievance_id = Column(Integer, ForeignKey("grievances.id"))
    status = Column(String)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    grievance = relationship("Grievance", back_populates="history")
