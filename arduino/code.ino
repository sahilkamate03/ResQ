#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

// Lane Config
const int LANE1_R = 22;
const int LANE1_G = 23;

const int LANE2_R = 21;
const int LANE2_G = 19;

const int LANE3_R = 18;
const int LANE3_G = 5;

const int LANE4_R = 2;
const int LANE4_G = 15;

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
    HTTPClient http;
    http.begin(url);

    int httpResponseCode = http.GET();
    if (httpResponseCode > 0)
    {
        String payload = http.getString();
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
    if (sourceLane == 0)
    {
        digitalWrite(LANE1_R, LOW);
        digitalWrite(LANE2_R, HIGH);
        digitalWrite(LANE3_R, HIGH);
        digitalWrite(LANE4_R, HIGH);

        digitalWrite(LANE1_G, HIGH);
        digitalWrite(LANE2_G, LOW);
        digitalWrite(LANE3_G, LOW);
        digitalWrite(LANE4_G, LOW);
    }
    else if (sourceLane == 1)
    {
        digitalWrite(LANE1_R, HIGH);
        digitalWrite(LANE2_R, LOW);
        digitalWrite(LANE3_R, HIGH);
        digitalWrite(LANE4_R, HIGH);

        digitalWrite(LANE1_G, LOW);
        digitalWrite(LANE2_G, HIGH);
        digitalWrite(LANE3_G, LOW);
        digitalWrite(LANE4_G, LOW);
    }
    else if (sourceLane == 2)
    {
        digitalWrite(LANE1_R, HIGH);
        digitalWrite(LANE2_R, HIGH);
        digitalWrite(LANE3_R, LOW);
        digitalWrite(LANE4_R, HIGH);

        digitalWrite(LANE1_G, LOW);
        digitalWrite(LANE2_G, LOW);
        digitalWrite(LANE3_G, HIGH);
        digitalWrite(LANE4_G, LOW);
    }
    else
    {
        digitalWrite(LANE1_R, HIGH);
        digitalWrite(LANE2_R, HIGH);
        digitalWrite(LANE3_R, HIGH);
        digitalWrite(LANE4_R, LOW);

        digitalWrite(LANE1_G, LOW);
        digitalWrite(LANE2_G, LOW);
        digitalWrite(LANE3_G, LOW);
        digitalWrite(LANE4_G, HIGH);
    }
    backgroundFxn();
}

void normal(int lane)
{
    if (lane == 0)
    {
        Serial.println(lane);
        digitalWrite(LANE1_R, LOW);
        digitalWrite(LANE2_R, HIGH);
        digitalWrite(LANE3_R, HIGH);
        digitalWrite(LANE4_R, HIGH);

        digitalWrite(LANE1_G, HIGH);
        digitalWrite(LANE2_G, LOW);
        digitalWrite(LANE3_G, LOW);
        digitalWrite(LANE4_G, LOW);
    }
    else if (lane == 1)
    {
        Serial.println(lane);
        digitalWrite(LANE1_R, HIGH);
        digitalWrite(LANE2_R, LOW);
        digitalWrite(LANE3_R, HIGH);
        digitalWrite(LANE4_R, HIGH);

        digitalWrite(LANE1_G, LOW);
        digitalWrite(LANE2_G, HIGH);
        digitalWrite(LANE3_G, LOW);
        digitalWrite(LANE4_G, LOW);
    }
    else if (lane == 2)
    {
        Serial.println(lane);
        digitalWrite(LANE1_R, HIGH);
        digitalWrite(LANE2_R, HIGH);
        digitalWrite(LANE3_R, LOW);
        digitalWrite(LANE4_R, HIGH);

        digitalWrite(LANE1_G, LOW);
        digitalWrite(LANE2_G, LOW);
        digitalWrite(LANE3_G, HIGH);
        digitalWrite(LANE4_G, LOW);
    }
    else
    {
        Serial.println(lane);
        digitalWrite(LANE1_R, HIGH);
        digitalWrite(LANE2_R, HIGH);
        digitalWrite(LANE3_R, HIGH);
        digitalWrite(LANE4_R, LOW);

        digitalWrite(LANE1_G, LOW);
        digitalWrite(LANE2_G, LOW);
        digitalWrite(LANE3_G, LOW);
        digitalWrite(LANE4_G, HIGH);
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
        unsigned long currentMillisLane = millis(); // get the current time

        if (!emergency && currentMillisLane - previousMillis >= interval)
        { // check if the interval has elapsed
            previousMillis = currentMillisLane;
            if (lane == 0)
                lane = totalLane; // update the last time the function was called
            normal(totalLane - lane);
            lane--;
        }
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

    pinMode(LANE1_R, OUTPUT);
    pinMode(LANE1_G, OUTPUT);

    pinMode(LANE2_R, OUTPUT);
    pinMode(LANE2_G, OUTPUT);

    pinMode(LANE3_R, OUTPUT);
    pinMode(LANE3_G, OUTPUT);

    pinMode(LANE4_R, OUTPUT);
    pinMode(LANE4_G, OUTPUT);
}

void loop()
{
    runner();
}