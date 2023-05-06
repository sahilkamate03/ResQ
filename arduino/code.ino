#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

// for background task
bool emergency = false;
unsigned long backgroundLastRunTime = 0;       // the last time backgroundFxn() was run
const unsigned long backgroundInterval = 1000; // the interval at which to run backgroundFxn()

// wifi settings
const char *ssid = "Wokwi-GUEST";
const char *password = "";

const String url = "https://resq.sahilkamate.repl.co";

// lane variables
int totalLane = 4;
int lane = totalLane;
const long interval = 10000;
unsigned long previousMillis = 0;

// for emergencyfxn
int sourceLane = 0;
int destinationLane = 0;
int distance = 100;
int range = 50;

int backgroundFxn()
{
    // Serial.print("Fetching " + url + "... ");

    HTTPClient http;
    http.begin(url);

    int httpResponseCode = http.GET();
    if (httpResponseCode > 0)
    {
        // Serial.print("HTTP ");
        // Serial.println(httpResponseCode);
        String payload = http.getString();
        // Serial.println();
        DynamicJsonDocument doc(1024); // 1024 is the JSON document size
        deserializeJson(doc, payload);
        distance = doc["dist"];
        sourceLane = doc["sourceLane"];
        destinationLane = doc["destinationLane"];
        Serial.println(distance);
        return distance;
    }
}

void emergencyFxn()
{
    Serial.println("Emergency");
    backgroundFxn();
}

void normal(int lane)
{
    if (lane == 0)
    {
        Serial.println(lane);
    }
    else if (lane == 1)
    {
        Serial.println(lane);
    }
    else if (lane == 2)
    {
        Serial.println(lane);
    }
    else
    {
        Serial.println(lane);
    }
}

void runner()
{
    while (true)
    {
        if (distance <= range)
        {
            emergency = true;
            emergencyFxn();
            return;
        }
        else
        {
            emergency = false;
        }
        // normalFxn() code here
        // ...
        unsigned long currentMillisLane = millis(); // get the current time

        if (!emergency && currentMillisLane - previousMillis >= interval)
        { // check if the interval has elapsed
            previousMillis = currentMillisLane;
            if (lane == 0)
                lane = totalLane; // update the last time the function was called
            normal(totalLane - lane);
            lane--;
        }
        // periodically check if it's time to run backgroundFxn()
        unsigned long currentMillis = millis();
        if (currentMillis - backgroundLastRunTime >= backgroundInterval)
        {
            backgroundLastRunTime = currentMillis;
            backgroundFxn();
        }
    }
}

void setup()
{
    Serial.begin(115200);
    WiFi.begin(ssid, password, 6);

    Serial.print("Connecting to WiFi");
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(100);
        Serial.print(".");
    }
}

void loop()
{
    runner();
}