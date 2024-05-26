from random import randrange
from typing import Optional

from fastapi import FastAPI, Response, status
from fastapi.exceptions import HTTPException
from pydantic import BaseModel
from starlette.status import HTTP_204_NO_CONTENT, HTTP_404_NOT_FOUND
import psycopg2
from psycopg2 import extras
import time

app = FastAPI()


class Products(BaseModel):
    name: str
    price: int
    id: int
    is_sale: bool
    inventory: int

class Users(BaseModel):
    id: Optional[int]
    fname: str
    lname: str
    city: str

class UserIn(BaseModel):
    fname: str
    lname: str
    city: str

class UserOut(BaseModel):
    id: int
    fname: str
    lname: str
    city: str

class ProductIn(BaseModel):
    name: str
    price: int
    is_sale: bool
    inventory: int

class ProductOut(BaseModel):
    id: int
    name: str
    price: int
    is_sale: bool
    inventory: int


class OrderIn(BaseModel):
    user_id: int
    item_id: int
    quantity: int

class OrderOut(BaseModel):
    id: int
    user_id: int
    item_id: int
    quantity: int


while True:
    try:
        conn = psycopg2.connect(host='localhost', port='5432',database='fastapi', user='postgres', password='1234', cursor_factory=extras.RealDictCursor)
        cursor = conn.cursor()
        print("Successfully Connected")
        break
    except Exception as error:
        print("Connection Failed")
        print("Error: ",error)
        time.sleep(1)


@app.get('/')
def root():
    return {"Message": "Here is my new project"}

@app.get('/products')
def get_products():
    cursor.execute("SELECT * FROM products")
    posts = cursor.fetchall()
    return {"Message": posts}

@app.get('/users')
def get_users():
    cursor.execute("SELECT * FROM users")
    posts = cursor.fetchall()
    return {"Message": posts}


@app.post('/users', status_code=status.HTTP_201_CREATED)
def new_user(user: UserIn):
    try:
        cursor.execute(
            "INSERT INTO users (fname, lname, city) VALUES (%s, %s, %s) RETURNING *",
            (user.fname, user.lname, user.city)
        )
        new_user = cursor.fetchone()
        conn.commit()  # Commit the transaction to the database
        return new_user
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")


@app.get("/users/{id}")
def get_user_by_id(id: int, response: Response):
    try:
        cursor.execute("SELECT * FROM users WHERE id = %s", (id,))
        user = cursor.fetchone()
        if not user:
            raise HTTPException(status_code=HTTP_404_NOT_FOUND, detail=f"User with id {id} was not found")
        return user
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")


@app.get("/products/{id}", response_model=ProductOut)
def get_product_by_id(id: int, response: Response):
    try:
        cursor.execute("SELECT * FROM products WHERE id = %s", (id,))
        product = cursor.fetchone()
        if not product:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Product with id {id} was not found")
        return product
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")

@app.post('/products', status_code=status.HTTP_201_CREATED, response_model=ProductOut)
def add_product(product: ProductIn):
    try:
        cursor.execute(
            "INSERT INTO products (name, price, is_sale, inventory) VALUES (%s, %s, %s, %s) RETURNING *",
            (product.name, product.price, product.is_sale, product.inventory)
        )
        new_product = cursor.fetchone()
        conn.commit()  
        return new_product
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")


@app.get('/orders')
def get_orders():
    try:
        cursor.execute('SELECT * FROM orders')
        orders = cursor.fetchall()
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")


@app.post('/orders', status_code=status.HTTP_201_CREATED)
def add_orders(order: OrderIn):
    try:
        cursor.execute(
            "INSERT INTO orders (user_id, item_id, quantity) VALUES (%s, %s, %s) RETURNING *",
            (order.user_id, order.item_id, order.quantity)
        )
        new_order = cursor.fetchone()
        conn.commit()  
        return new_order
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal Server Error")

