const express = require('express');
const app = express();
const mongoose = require('mongoose');
const cors = require('cors');
const {router} = require('./src/routes/routes');


app.use(cors())
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/', router);

const dbURI = "mongodb://localhost:27017/examyy";
mongoose.connect( dbURI ,{ useNewUrlParser:true, useUnifiedTopology:true })
.then(()=>{
    console.log('db connected');
})
.catch((e)=>{
    console.log(e);
})


app.listen(8000,()=>{
    console.log('server is running on port 8000');
})