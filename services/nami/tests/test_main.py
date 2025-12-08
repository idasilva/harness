from fastapi.testclient import TestClient
from app.main import app


def test_read_root():
    """Test the root endpoint returns Hello World"""
    client = TestClient(app)  # Create client inside test
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}


def test_version_endpoint():
    """Test the version endpoint returns v1.0.0"""
    client = TestClient(app)  # Create client inside test
    response = client.get("/python/v1/version")
    assert response.status_code == 200
    assert response.json() == {"version": "v1.0.0"}