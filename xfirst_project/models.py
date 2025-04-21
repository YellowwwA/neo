from sqlalchemy import Column, TEXT, INT
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class Kids(Base):
    __tablename__ = 'kids'
    
    id = Column(INT, primary_key=True, autoincrement=True)
    
    YEAR = Column(INT, nullable=False)
    REGION = Column(TEXT, nullable=False)
    ACCIDENT_COUNT = Column(INT, nullable=False)
    DEATH_COUNT = Column(INT, nullable=False)
    INJURY_COUNT = Column(INT, nullable=False)
    
class Per10_kids(Base):
    __tablename__ = 'per10_kids'
    
    id = Column(INT, primary_key=True, autoincrement=True)
    
    YEAR = Column(INT, nullable=False)
    ACCIDENT_COUNT = Column(INT, nullable=False)
    POPULATION = Column(INT, nullable=False)

    
class Per10_senior(Base):
    __tablename__ = 'per10_senior'
    
    id = Column(INT, primary_key=True, autoincrement=True)
    
    YEAR = Column(INT, nullable=False)
    ACCIDENT_COUNT = Column(INT, nullable=False)
    POPULATION = Column(INT, nullable=False)    
