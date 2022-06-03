const Str = require('@supercharge/strings')
const Question = require('../db/Question')

class ExamController {

  static addExam (req, res) {
    const { questions } = req.body
    const examUid = Str.random(50)
    console.log(examUid)
    console.log(questions)
    Question.insertMany(
      questions.map(question => ({ ...question, examUid }))
    ).then(() => console.log('questions added to db'))
     .catch(e=>console.log(e))
  }

}
module.exports = { ExamController }
