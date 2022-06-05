const Str = require('@supercharge/strings')
const Question = require('../db/Question');
const Exam = require('../db/Exam');

class ExamController {

  static addExam (req, res) {

    const { questions,exam } = req.body;

    if(questions.length<1 || !exam.name || !exam.category){
      return res.status(400).json({'error':'missing credentials'})
    }

    new Exam({name:exam.name, category:exam.category}).save()
      .then((savedExam)=> {
        console.log(savedExam._id);
        Question.insertMany(questions.map(question => ({ ...question, examUid:savedExam._id })))
         .then(() => res.sendStatus(200))
         .catch(e=> res.status(400).json({'error':'error occured while adding questions to database'}))
      })
      .catch(e=> res.status(400).json({'error':'error occured while adding exam to database'}))


  }
  static fetchExams(req,res){
    console.log('fetch exams');
    Exam.find({})
    .then(exams=>res.status(200).json({exams}))
    .catch(e=>res.status(400).json({'error':'error occured while adding exam to database'}))
  }

  static fetchQuestions(req,res){
    console.log('fetch questions');
    const {_id} = req.body;
    Question.find({examUid:_id})
    .then(questions => res.status(200).json({questions}))
    .catch(e => res.status(400).json({'error':'error occured while adding exam to database'}))
  }

}

module.exports = { ExamController }
