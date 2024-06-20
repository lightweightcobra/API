from .. import models, schemas, utils, oauth2
from fastapi import FastAPI, Response, status, Depends, HTTPException, APIRouter
from sqlalchemy.orm import Session
from ..database import get_db

router = APIRouter(
    prefix = "/posts",
    tags = ['Posts']
)
## Working for Post Database

@router.get("/")
def post(db: Session = Depends(get_db)):
    posts = db.query(models.Post).all()
    return posts

@router.post("/", response_model=schemas.PostResponse, status_code=status.HTTP_201_CREATED)
def create_posts(post: schemas.PostCreate, db: Session = Depends(get_db), get_current_user: int = Depends(oauth2.get_current_user)):
    new_post = models.Post(title=post.title, content=post.content, published=post.published)
    db.add(new_post)
    db.commit()
    db.refresh(new_post)
    return new_post

@router.get("/{id}", response_model=schemas.PostResponse)
def get_post(id: int, db: Session = Depends(get_db)):
    post = db.query(models.Post).filter(models.Post.id == id).first()
    if not post:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Post with id {id} was not found")
    return post

@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_post(id: int, db: Session = Depends(get_db)):
    post_query = db.query(models.Post).filter(models.Post.id == id)
    post = post_query.first()
    if post is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Post with id: {id} does not exist")

    post_query.delete(synchronize_session=False)
    db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)

@router.put("/{id}", response_model=schemas.PostResponse)
def update_post(id: int, updated_post: schemas.Post, db: Session = Depends(get_db)):
    post_query = db.query(models.Post).filter(models.Post.id == id)
    post = post_query.first()

    if post is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Post with id: {id} does not exist")

    post_query.update(updated_post.dict(), synchronize_session=False)
    db.commit()
    db.refresh(post)
    return post
