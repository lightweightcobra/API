from fastapi import FastAPI, Response, status, Depends, HTTPException
from pydantic import BaseModel

# import psycopg2
# from psycopg2 import extras
import time
from passlib.context import CryptContext
from sqlalchemy.orm import Session
from . import models, schemas, utils
from .database import engine, SessionLocal, get_db
from .routers import post, user, auth

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Database connection code (commented out)
# while True:
#     try:
#         conn = psycopg2.connect(
#             host='localhost',
#             port='5432',
#             database='fastapi',
#             user='postgres',
#             password='1234',
#             cursor_factory=extras.RealDictCursor
#         )
#         cursor = conn.cursor()
#         print("Successfully Connected")
#         break
#     except Exception as error:
#         print("Connection Failed")
#         print("Error: ", error)
#         time.sleep(1)

# Include the routers for posts and users
app.include_router(post.router)
app.include_router(user.router)
app.include_router(auth.router)
