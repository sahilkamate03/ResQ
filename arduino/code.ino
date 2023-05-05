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
        int dist = doc["dist"];
        Serial.println(dist);
        return dist;
    }
}

void emergencyFxn()
{
    Serial.println("Emergency");
}

void normal()
{
    while (true)
    {
        if (emergency)
        {
            emergencyFxn();
            return;
        }
        // normalFxn() code here
        // ...
        Serial.println("Normal");
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
    normal();
}