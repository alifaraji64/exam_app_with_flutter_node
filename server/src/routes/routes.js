const { Router } = require("express");
const router = Router();
const {ExamController} = require('../controllers/exam.controller')

router.post('/add-exam', ExamController.addExam);
module.exports={router};