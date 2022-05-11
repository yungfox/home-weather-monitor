const firebase = require('firebase-admin')
const { getDatabase } = require('firebase-admin/database')
    //read firebase service account key
const serviceAccount = require('../firemqtt-d434cd712131.json')

//initialize the app using the service account key
firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount),
    databaseURL: process.env.FIREBASE_DATABASEURL
})

const db = getDatabase().ref('firemqtt')

module.exports.store = async(temperature, humidity, heat_index) => {
    //generate timestamp
    let date = new Date()

    //store values passed to the method on database
    return await db.child(date.toString()).set({
        temperature: temperature,
        humidity: humidity,
        heat_index: heat_index,
        date: date.toUTCString()
    }).then(() => {
        console.log({ temperature: temperature, humidity: humidity, heat_index: heat_index, date: date })
    }).catch((error) => {
        console.log(error)
    })
}