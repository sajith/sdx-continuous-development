"""NApp responsible for sdx topology management."""
from flask import Flask, jsonify
from flask_restx import Resource, Api


# instantiate the app
app = Flask(__name__)

api = Api(app)

# set config
app.config.from_object('app.config.DevelopmentConfig')


class Ping(Resource):
    """ Test """
    @staticmethod
    def get():
        """ get method """
        return {
            'status': 'success',
            'message': 'pong!'
        }


api.add_resource(Ping, '/ping')
