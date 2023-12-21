const router = require('express').Router();
const ToDoController = require('../controller/todo.controller');

router.post("/storeTodo", ToDoController.createTodo);
router.post("/getTodo", ToDoController.getTodo);
router.post("/delTodo", ToDoController.delTodo);
module.exports = router;