const express = require('express')
const app = express()
const mqtt = require('mqtt')
const model = require('./model')

//connect to local broker
const client = mqtt.connect('mqtt://127.0.0.1')
const topic = 'esp32/readings'

//subscribe to topic at connect
client.on('connect', () => {
    client.subscribe(topic)
})

//initializing variables
let temperature = null
let humidity = null
let heat_index = null

//callback on message
client.on('message', (topic, message) => {
    //split the raw string into separate values
    let reading = message.toString().split(',')

    //assign values to their respective variables
    temperature = reading[0]
    humidity = reading[1]
    heat_index = reading[2]

    //store values from the reading on database
    model.store(temperature, humidity, heat_index)
})

module.exports = app