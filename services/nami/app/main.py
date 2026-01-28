from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World v2"}


@app.get("/python/v2/version")
async def version():
    return {"version": "v2.0.0...."}
