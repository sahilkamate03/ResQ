from flask import Flask, jsonify
import random

app = Flask(__name__)


@app.route("/")
def hello_world():
    dist = random.randint(1, 100)
    response = {'name': 'ResQ', 'sourceLane': 0, 'destinationLane': 1, 'dist': dist}
    return jsonify(response)


if (__name__ == "__main__"):
    app.run(host='0.0.0.0', debug=True)
