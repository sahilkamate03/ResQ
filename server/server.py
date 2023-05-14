from flask import Flask, jsonify, request
import random
import math

app = Flask(__name__)

ambulanceLat = 80
ambulanceLon = 80

arduinoLat = 200
arduinoLon = 200

sourceLane =0
destinationLane =3

def distance(lat1, lon1, lat2, lon2):
    # convert decimal degrees to radians
    lon1, lat1, lon2, lat2 = map(math.radians, [lon1, lat1, lon2, lat2])
    # haversine formula
    dlon = lon2 - lon1 
    dlat = lat2 - lat1 
    a = math.sin(dlat/2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon/2)**2
    c = 2 * math.asin(math.sqrt(a)) 
    # 6367 km is the radius of the Earth
    km = 6367 * c
    return km

@app.route("/")
def hello_world():
    global sourceLane
    global destinationLane
    
    dist = random.randint(1, 100)
    response = {
        'name': 'ResQ',
        'sourceLane': int(sourceLane),
        'destinationLane': int(destinationLane),
        'dist': distance(arduinoLat, arduinoLon, ambulanceLat, ambulanceLon)
    }
    return jsonify(response)


@app.route('/post-location', methods=['POST'])
def post_location():
    # Retrieve the latitude and longitude from the request
    global ambulanceLat
    global ambulanceLon
    global sourceLane
    global destinationLane
    
    
    ambulanceLat = float(request.form['latitude'])
    ambulanceLon = float(request.form['longitude'])
    sourceLane = int(request.form['sourceLane'])
    destinationLane =int(request.form['destinationLane'])
    # print(lat, lon)

    return 'Success'


@app.route('/post-coordinates', methods=['POST'])
def post_coordinates():
    # Retrieve the latitude and longitude from the request
    for key, value in request.form.items():
        print(key, value)

    return 'Success'


if (__name__ == "__main__"):
    app.run(host='0.0.0.0', debug=True)
