from app.models.user import User
from app.core.security import create_access_token

class AuthService:
    def __init__(self, db):
        self.db = db

    def login(self, phone: str):
        user = self.db.query(User).filter(User.phone == phone).first()

        if not user:
            user = User(phone=phone)
            self.db.add(user)
            self.db.commit()
            self.db.refresh(user)

        token = create_access_token({"sub": str(user.id)})
        return token
