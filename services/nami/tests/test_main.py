import sys
sys.path.insert(0, "app")

import pytest
from fastapi.testclient import TestClient
from main import app


@pytest.fixture
def client():
    return TestClient(app)
        
def test_read_root(client):
    """Test the root endpoint returns Hello World"""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}


def test_version_endpoint(client):
    """Test the version endpoint returns v1.0.0"""
    response = client.get("/python/v1/version")
    assert response.status_code == 200
    assert response.json() == {"version": "v1.0.0"}