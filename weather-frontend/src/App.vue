<template>
    <div class="parent">
        <div class="card" style="--animation-order: 1">
            <div class="card-title">temperature</div>
            <div class="card-body">
                <div class="card-value">
                    {{temperature ? `${temperature} °C` : waiting_for_data_message}}
                </div>
                <div class="card-icon">
                    <i class="bi bi-thermometer-half"></i>
                </div>
            </div>
        </div>
        <div class="card" style="--animation-order: 2">
            <div class="card-title">humidity</div>
            <div class="card-body">
                <div class="card-value">
                    {{humidity ? `${humidity}%` : waiting_for_data_message}}
                </div>
                <div class="card-icon">
                    <i class="bi bi-droplet-fill"></i>
                </div>
            </div>
        </div>
        <div class="card" style="--animation-order: 3">
            <div class="card-title">heat index</div>
            <div class="card-body">
                <div class="card-value">
                    {{heat_index ? `${heat_index} °C` : waiting_for_data_message}}
                </div>
                <div class="card-icon">
                    <i class="bi bi-thermometer-sun"></i>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .parent {
        display: flex;
        flex-direction: row;
        margin: 2rem 0;
        max-width: 1200px;
        width: 100%;
        padding: 2rem;
    }

    .card {
        display: flex;
        flex-direction: column;
        background-color: #242528;
        width: 100%;
        border-radius: 10px;
        box-shadow: 2px 2px 12px 15px rgb(0 0 0 / 14%);
        padding: 1.5rem;
        margin: 1.5rem 1vw;
        animation: animateIn 0.3s both ease-in-out;
        animation-delay: calc(var(--animation-order) * 100ms);
    }

    .card-title {
        font-size: 2.5rem;
    }

    .card-body {
        display: flex;
        justify-content: space-between;
        align-items: baseline;
    }

    .card-value {
        font-size: 1.75rem;
    }

    .card-icon {
        color: #70777f;
        font-size: 3rem;
    }

    @keyframes animateIn {
        0% {
            opacity: 0;
            transform: scale(0.6) translateY(-8px);
        }
        
        100% {
            opacity: 1;
        }
    }

    @media screen and (max-width: 992px) {
        .parent {
            flex-direction: column;
            align-items: center;
        }
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
            readings: [],
        }
    },
    created() {
        //assigning vue's this keyword to a variable in order to be able to reference it later
        let self = this

        //sign in with credentials retrieved from env
        auth.signInWithEmailAndPassword(process.env.VUE_APP_FIREBASE_USER, process.env.VUE_APP_FIREBASE_PASSWORD)
            .then(() => {
                //attach listener for the new entries in the database
                db.collection('readings').onSnapshot(snap => {
                    //get the most recent entry in the database
                    snap.query.orderBy('date', 'desc').limit(1).get()
                    .then((querySnapshot) => {
                        //access data from the query result
                        let result = querySnapshot.docs[0]._delegate._document.data.value.mapValue.fields
                        console.log(result)
                        
                        //update vue's reactive properties with the data fetched from the query result
                        self.temperature = parseFloat(result.temperature.stringValue).toFixed(1)
                        self.humidity = parseFloat(result.humidity.stringValue).toFixed(1)
                        self.heat_index = parseFloat(result.heat_index.stringValue).toFixed(1)
                    })
                })
            })
            .catch((error) => {
                console.log(`authentication failed: ${error}`)
            })
    },
}
</script>
