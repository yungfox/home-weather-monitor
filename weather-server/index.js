require('dotenv').config({path: __dirname + '/.env'})

const app = require('./src/app')

app.listen(3000, () => console.log('app listening on port 3000'))