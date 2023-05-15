from flask import Flask, jsonify, request
import math

app = Flask(__name__)

ambulanceLat = 80
ambulanceLon = 80

arduinoLat = 200
arduinoLon = 200

hospitalLat = 18.553107087008183
hospitalLon = 73.83820119465052

sourceLane = 0
destinationLane = 3


def distance(lat1, lon1, lat2, lon2):
    # convert decimal degrees to radians
    lon1, lat1, lon2, lat2 = map(math.radians, [lon1, lat1, lon2, lat2])
    # haversine formula
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = math.sin(
        dlat / 2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2)**2
    c = 2 * math.asin(math.sqrt(a))
    km = 6367 * c
    return km

@app.route("/")
def hello_world():
    global sourceLane
    global destinationLane

    response = {
        'name': 'ResQ',
        'sourceLane': int(sourceLane),
        'destinationLane': int(destinationLane),
        'dist': distance(arduinoLat, arduinoLon, ambulanceLat, ambulanceLon)
    }
    return jsonify(response)


@app.route('/post-location', methods=['POST'])
def post_location():
    global ambulanceLat
    global ambulanceLon

    ambulanceLat = float(request.form['latitude'])
    ambulanceLon = float(request.form['longitude'])

    return 'Success'


@app.route('/post-coordinates', methods=['POST'])
def post_coordinates():
    global sourceLane
    global destinationLane

    global arduinoLat
    global arduinoLon

    global hospitalLat
    global hospitalLon

    if (request.form['sourceLane']):
        sourceLane = int(request.form['sourceLane'])
    if (request.form['destinationLane']):
        destinationLane = int(request.form['destinationLane'])

    if (request.form['arduinoLatitude']):
        arduinoLat = float(request.form['arduinoLatitude'])
    if (request.form['arduinoLongitude']):
        arduinoLon = float(request.form['arduinoLongitude'])

    if (request.form['hospitalLatitude']):
        hospitalLat = float(request.form['hospitalLatitude'])
    if (request.form['hospitalLongitude']):
        hospitalLon = float(request.form['hospitalLongitude'])

    return 'Success'


if (__name__ == "__main__"):
    app.run(host='0.0.0.0', debug=True)
