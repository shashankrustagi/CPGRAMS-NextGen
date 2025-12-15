from sqlalchemy.orm import Session
from app.models.grievance import Grievance, GrievanceStatus
from app.models.grievance_status import GrievanceStatusHistory
from app.schemas.grievance import GrievanceCreate

class GrievanceService:
    def __init__(self, db: Session):
        self.db = db

    def create(self, data: GrievanceCreate, user_id: int):
        grievance = Grievance(
            **data.model_dump(),
            user_id=user_id,
            status=GrievanceStatus.submitted
        )
        self.db.add(grievance)
        self.db.commit()
        self.db.refresh(grievance)

        history = GrievanceStatusHistory(
            grievance_id=grievance.id,
            status=GrievanceStatus.submitted.value
        )
        self.db.add(history)
        self.db.commit()

        return grievance

    def list(self, user_id: int):
        return self.db.query(Grievance).filter_by(user_id=user_id).all()
