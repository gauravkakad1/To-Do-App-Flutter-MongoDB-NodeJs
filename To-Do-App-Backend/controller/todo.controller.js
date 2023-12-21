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


exports.getTodo = async (req, res, next) => {
    try {
        const { userId } = req.body;
        let getData = await ToDoService.getTodo(userId);
        res.json({ status: true, success: getData })
    } catch (error) {
        throw error
    }
}

exports.delTodo = async (req, res, next) => {
    try {
        const { id } = req.body;
        let delData = await ToDoService.delTodo(id);
        res.json({ status: true, success: delData });
    } catch (error) {
        throw error;
    }

}