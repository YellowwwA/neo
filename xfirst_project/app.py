import pandas as pd
from fastapi import FastAPI
from database import db_conn
from models import Kids, Per10_kids, Per10_senior
from sqlalchemy import *
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI(debug=True)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 개발 중에는 *로 두세요
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

db = db_conn()
session = db.sessionmaker()

#df = pd.read_csv('total_sido_kids.csv', encoding='utf-8')
@app.get('/get')
async def GetKid():
    result = session.query(Kids)
    return result.all()
    
@app.get('/r_getKidsAcc')
async def GetKidsAcc(year=None, region=None):

    if (year is None) or (region is None):
        return "연도와 지역을 입력하세요.@@"
    else :
        result = session.query(Kids).filter(Kids.YEAR == year, Kids.REGION == region).all()
        
        if result:
            print(result)
            return {
                "resultcode": "success",
                "data": result
            }
        else:
            return "연도와 지역을 찾을 수 없습니다."
        
@app.get('/r_getper10kids')
async def GetPer10KidsAcc(year=None):

    if year is None:
        return "연도를 입력하세요.@@"
    else :
        data = session.query(Per10_kids).filter(Per10_kids.YEAR == year).all()
        result = []
        for row in data:
            per10acc = round((row.ACCIDENT_COUNT / row.POPULATION) * 100000)
            result.append({
                "year": row.YEAR,
                "accident_count" : row.ACCIDENT_COUNT,
                "population" : row.POPULATION,
                "per10acc" : per10acc
            })
        if result:
            print(result)
            return {
                "resultcode": "success",
                "data": result
            }
        else:
            return "연도를 찾을 수 없습니다."
        
    
@app.get('/r_getper10senior')
async def GetPer10SeniorAcc(year=None):

    if year is None:
        return "연도를 입력하세요.@@"
    else :
        data = session.query(Per10_senior).filter(Per10_senior.YEAR == year).all()
        result = []
        for row in data:
            per10acc = round((row.ACCIDENT_COUNT / row.POPULATION) * 100000)
            result.append({
                "year": row.YEAR,
                "accident_count" : row.ACCIDENT_COUNT,
                "population" : row.POPULATION,
                "per10acc" : per10acc
            })
        if result:
            print(result)
            return {
                "resultcode": "success",
                "data": result
            }
        else:
            return "연도를 찾을 수 없습니다."