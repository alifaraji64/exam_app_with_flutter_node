const mongoose = require('mongoose');
const questionSchema = new mongoose.Schema({
    url:{
        type:String,
        required:false
    },
    question:{
        type:String,
        required:true
    },
    wAnswerOne:{
        type:String,
        required:true
    },
    wAnswerTwo:{
        type:String,
        required:true
    },
    wAnswerThree:{
        type:String,
        required:true
    },
    correctAnswer:{
        type:String,
        required:true
    },
    order:{
        type:Number,
        required:true
    },
    examUid:{
        type:String,
        required:true
    }
})

module.exports = mongoose.model('question',questionSchema);