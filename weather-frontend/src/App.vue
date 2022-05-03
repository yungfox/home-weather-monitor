<template>
    <div class="parent">
        <div class="row">
            <div class="key">temperature</div>
            <div class="value">{{temperature ? temperature : waiting_for_data_message}}</div>
        </div>
        <div class="row">
            <span class="key">humidity</span>
            <span class="value">{{humidity ? humidity : waiting_for_data_message}}</span>
        </div>
        <div class="row">
            <div class="key">heat index</div>
            <div class="value">{{heat_index ? heat_index : waiting_for_data_message}}</div>
        </div>
    </div>
</template>

<style scoped>
    .parent {
        display: flex;
        flex-direction: column;
        margin: 3rem 5vw;
        font-size: 1.5rem;
    }

    .row {
        display: flex;
        margin-bottom: 1.5rem;
    }

    .key {
        font-weight: 600;
    }

    .value {
        margin-left: 0.5rem;
    }
</style>

<script>
import { db, auth } from './firebase'

export default {
    data() {
        return {
            waiting_for_data_message: 'waiting for data...',
            temperature: null,
            humidity: null,
            heat_index: null,
        }
    },
    created() {
        //assigning vue's this keyword to a variable in order to be able to reference it later
        let self = this

        //sign in with credentials retrieved from env
        auth.signInWithEmailAndPassword(process.env.VUE_APP_FIREBASE_USER, process.env.VUE_APP_FIREBASE_PASSWORD)
            .then(() => {
                //attach listener for the new entries in the database
                db.collection('readings').onSnapshot((snap) => {
                    //get the most recent entry in the database
                    snap.query.orderBy('date', 'desc').limit(1).get()
                    .then((querySnapshot) => {
                        //making sure the query doesn't return empty
                        if(!querySnapshot.empty) {
                            //access data from the query result
                            let result = querySnapshot.docs[0].data()

                            //update vue's reactive properties with the data fetched from the query result
                            self.temperature = result.temperature
                            self.humidity = result.humidity
                            self.heat_index = result.heat_index
                        }
                    })
                })
            })
            .catch((error) => {
                console.log(`authentication failed: ${error}`)
            })
    },
}
</script>
