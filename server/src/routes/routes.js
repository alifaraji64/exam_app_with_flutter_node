const { Router } = require("express");
const router = Router();
const {ExamController} = require('../controllers/exam.controller')

router.post('/add-exam', ExamController.addExam);
router.get('/fetch-exams', ExamController.fetchExams);
router.post('/fetch-questions', ExamController.fetchQuestions);
router.get('/new-exam-exists', ExamController.newExamExists);
module.exports={router};