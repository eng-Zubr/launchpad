# Observatory Service

# Import framework
from flask import Flask
from flask_restful import Resource, Api
import os

# Instantiate the app
app = Flask(__name__)
api = Api(app)

class Observatory(Resource):
    def get(self):
        return {
            'Hello': ['iTechForum', '2018!',
            'Launchpad Terraform Demo',
            'Please eat me!'
            ],
            'ENV': os.environ['ENV']
        }

# Create routes
api.add_resource(Observatory, '/api/hello')

# Run the application
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)
