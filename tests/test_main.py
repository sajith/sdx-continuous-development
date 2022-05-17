""" main test """
from app import main


def test_main(test_app):
    response = test_app.get("/")
    assert response.status_code == 200
    assert response.json() == {"environment": "dev", "message": "Welcome to SDX API!!!", "testing": True}
