# Introduction

Traffic jams can cause delays for emergency vehicles, causing loss of lives. Our product aims to improve traffic management by detecting and manipulating traffic signals, allowing free access for emergency vehicles. It uses real-time traffic data and GPS data to monitor traffic flow and identify congestion areas. The system also controls intersection traffic signals, creating green corridors for safe navigation.


# Purpose

The project ResQ aims towards developing a software product which will detect emergency vehicles and provide a free way by manipulating the traffic flow through traffic lights.


# Architecture
The project can be borken down into three following parts.


## System Design
![alt System Design](https://raw.githubusercontent.com/sahilkamate03/ResQ/main/images/system_design.png)
 
# ESP32
## Smart Traffic Light Controller

This ESP32 code implements a smart traffic light controller that communicates with a remote server to receive real-time traffic data. The system controls four traffic lanes, each with red and green LEDs. The traffic light operates in two modes: normal mode and emergency mode.

## Features:

- **WiFi Connectivity:** The controller connects to a WiFi network to communicate with the remote server.
- **Dynamic Lane Configuration:** The number of traffic lanes is configurable, with default settings for four lanes.
- **Real-time Data Retrieval:** Utilizes the HTTPClient library to fetch real-time traffic data from a specified server.
- **Emergency Mode:** Activates emergency mode based on predefined conditions, changing the traffic light configuration accordingly.
- **Background Task:** Periodically checks for updates in the background, ensuring the traffic light controller has the latest traffic information.

## Emergency Mode:

In emergency mode, the system responds to specific conditions retrieved from the server. The affected lane's red light is turned off, and the green light is activated, allowing emergency vehicles to pass through.

## Usage:

1. Set your WiFi credentials (SSID and password) in the code.
2. Update the `url` variable with the server endpoint providing traffic data.
3. Configure the pin assignments for each traffic lane.
4. Upload the code to your Arduino device.

The system continuously runs in a loop, checking for updates and adjusting the traffic lights based on the received information. The background task runs at defined intervals to ensure timely data retrieval.

**Note:** This code is designed to work with a specific server providing traffic data in a JSON format. Ensure compatibility with your server or modify the code accordingly.

### Screenshot
![alt Home Page](https://github.com/sahilkamate03/ResQ/blob/main/images/screenshots/esp32.png?raw=true)



# Flask Server

This Flask server provides real-time data for a smart traffic light controller system. The server calculates the distance between an ambulance and an Arduino device, considering their respective coordinates. It also allows updating the positions of the ambulance and Arduino dynamically.

## Endpoints:

### 1. GET `/`

- **Description:** Retrieves real-time data for the traffic light controller.
- **Response:**
  ```json
  {
    "name": "ResQ",
    "sourceLane": [current source lane],
    "destinationLane": [current destination lane],
    "dist": [distance between Arduino and ambulance in kilometers]
  }

### 2. POST `/post-location`

   - **Description:** Updates the location of the ambulance.
   
    Request Parameters:
        latitude: Latitude of the ambulance
        longitude: Longitude of the ambulance
    Response: "Success"

### 3. POST `/post-coordinates`

- **Description:** Updates the coordinates of the Arduino device, hospital, and the traffic flow details.

        Request Parameters:
            sourceLane: Current source lane for traffic flow
            destinationLane: Current destination lane for traffic flow
            arduinoLatitude: Latitude of the Arduino device
            arduinoLongitude: Longitude of the Arduino device
            hospitalLatitude: Latitude of the hospital
            hospitalLongitude: Longitude of the hospital
        Response: "Success"

### Usage:

    - Run the Flask server using the command python filename.py.
    - The server will be hosted at http://0.0.0.0:5000/ by default.
    - The traffic light controller can make requests to the provided endpoints to receive real-time data.

**Note:**  This server is part of a system and is intended to be used in conjunction with an Arduino-based traffic light controller. Ensure that the traffic light controller is configured to communicate with this server.
  
### Screenshot
![alt Home Page](https://github.com/sahilkamate03/ResQ/blob/main/images/screenshots/server.png?raw=true)


#  Flutter App

The ResQ Flutter app is designed to complement the smart traffic light controller system by providing a user interface for monitoring and managing emergency situations. The app is built using Flutter, a UI toolkit from Google, and Firebase for backend support.

## Prerequisites:

- Ensure that Firebase is properly set up and configured. Update the Firebase options in `firebase_options.dart`.

## Getting Started:

1. Open the terminal and navigate to the project directory.
2. Run `flutter pub get` to fetch the dependencies.
3. Launch the app using `flutter run`.

## Features:

- **Splash Screen:** The app starts with a splash screen while initializing the Firebase services.
- **Home Page (`home_page.dart`):** The main landing page of the app, providing an overview of the current traffic conditions.
- **Login Page (`login_page.dart`):** Allows users to log in and access personalized features.
- **Profile Page (`profile_page.dart`):** Displays user information and allows for profile customization.
- **Data Page (`data_page.dart`):** Presents detailed data and statistics related to traffic and emergency situations.
- **Test Mode (`test_mode.dart`):** A page for testing and debugging purposes, providing tools to simulate various scenarios.

## Usage:

1. Ensure that the Firebase services are properly configured.
2. Launch the app on a compatible device or emulator.

## Note:

This Flutter app is part of the ResQ system, working in conjunction with a smart traffic light controller and a Flask server. It provides a user interface to monitor emergency situations. Additional features and pages are expected to be added in future releases.

**Important:** The app may require additional configuration and the implementation of further features. Refer to the app's source code for more details.

## Screenshots

<p align="center">
  <img src="https://github.com/sahilkamate03/ResQ/blob/main/images/screenshots/homePageApp.png?raw=true" width="200" />
  <img src="https://github.com/sahilkamate03/ResQ/blob/main/images/screenshots/testMode.png?raw=true" width="200" />
</p>

## Explore More about the Project
Download apk from [here](https://github.com/sahilkamate03/ResQ/raw/main/ResQ.apk).

    Credentials
    Username: sahilkamate03@gmail.com
    Password: 123456



- **Server Code:** Check out the [Server Repository](https://replit.com/@SahilKamate/ResQ) for an in-depth look at the server-side code.

- **IoT/ESP32 Details:** Dive into the details of the ESP32 implementation by visiting the [Iot/ESP32 Project on Wokwi](https://wokwi.com/projects/363907460902039553).

- **Project Report:** For a comprehensive understanding of the project, you can read the [Project Report](https://docs.google.com/document/d/18p56d6-H-P4OafdVXcifjPQ2d7gooMJoQi3T3GeFa5w/edit?pli=1).

Feel free to explore each section to gain insights into different aspects of the project.
