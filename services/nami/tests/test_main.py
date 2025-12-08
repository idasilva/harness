from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_read_root():
    """Test the root endpoint returns Hello World"""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}


def test_version_endpoint():
    """Test the version endpoint returns v1.0.0"""
    response = client.get("/python/v1/version")
    assert response.status_code == 200
    assert response.json() == {"version": "v1.0.0"}