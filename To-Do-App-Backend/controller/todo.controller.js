const ToDoModel = require('../model/todo.model');
const ToDoService = require('../services/todo.service');

exports.createTodo = async (req, res, next) => {
    try {
        const { userId, title, desc } = req.body;
        let todoData = await ToDoService.createTodo(userId, title, desc);
        res.json({ status: true, success: todoData })
    } catch (error) {
        throw error
    }
}

