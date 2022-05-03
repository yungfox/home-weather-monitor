#include <Arduino.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include <secrets.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>

#define DHTPIN 32
#define DHTTYPE DHT11

//initialize constants
const char *SSID = WIFI_SSID;
const char *PASSWORD = WIFI_PASSWORD;
const char *MQTT_BROKER = HOST_ADDRESS;
const char *TOPIC = MQTT_TOPIC;
const int MQTT_PORT = 1883;
const int PUBLISH_INTERVAL = 5000;

//instantiate wifi, pubsub and sensor clients
WiFiClient espClient;
PubSubClient client(espClient);
DHT dht(DHTPIN, DHTTYPE);

void setup() {
    Serial.begin(9600);

    //initialize 
    dht.begin();
    
    //connect to wifi
    WiFi.begin(SSID, PASSWORD);
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.println("Connecting to WiFi..");
    }
    Serial.println("Connected to the WiFi network!");

    //connect to the mqtt broker
    client.setServer(MQTT_BROKER, MQTT_PORT);
    client.connect("esp32");

    while (client.connected()) {
        //get readings
        float humidity = dht.readHumidity();
        float temperature = dht.readTemperature();
        float heat_index = dht.computeHeatIndex(temperature, humidity, false);

        //convert readings to string
        char temperature_str[10], humidity_str[10], heat_index_str[10];
        sprintf(temperature_str, "%f", temperature);
        sprintf(humidity_str, "%f", humidity);
        sprintf(heat_index_str, "%f", heat_index);

        //build message string by concatenating all readings separated by a comma
        char message[100];
        strcat(message, temperature_str);
        strcat(message, ",");
        strcat(message, humidity_str);
        strcat(message, ",");
        strcat(message, heat_index_str);
        
        //publish to the broker
        client.publish(TOPIC, message);
        
        //reset message buffer
        message[0] = '\0';

        //wait for the specified interval
        delay(PUBLISH_INTERVAL);
    }
}

void loop() {
    //keep the connection to the broker open
    client.loop();
}