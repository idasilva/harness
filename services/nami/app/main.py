from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/python/v1/version")
async def version():
    return {"version": "v1.0.0"}