const { Router } = require("express");
const router = Router();
const {ExamController} = require('../controllers/exam.controller')

router.post('/add-exam', ExamController.addExam);
router.get('/fetch-exams', ExamController.fetchExams);
module.exports={router};