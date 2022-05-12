const moment = require('moment')
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

    // format date so that it can be accepted by realtime database as
    // a valid document name. date output will be YYYY-MM-DDTHH:mm:ss
    let formattedDate = moment(date).format(moment.HTML5_FMT.DATETIME_LOCAL_SECONDS)

    //store values passed to the method on database
    return await db.child(formattedDate).set({
        temperature: temperature,
        humidity: humidity,
        heat_index: heat_index,
        date: date.toUTCString()
    }, (error) => {
        if (!error) {
            console.log({ temperature: temperature, humidity: humidity, heat_index: heat_index, date: date })
        } else {
            console.log(error)
        }
    })
}