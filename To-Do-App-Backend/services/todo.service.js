const ToDoModel = require('../model/todo.model');
const { findOne, findOneAndDelete } = require('../model/user.model');

class ToDoService {
    static async createTodo(userId, title, description) {
        try {
            const createTodo = new ToDoModel({ userId, title, description });
            return await createTodo.save();

        } catch (err) {
            throw err;
        }
    }

    static async getTodo(userId) {
        try {
            const todoList = await ToDoModel.find({ userId });
            return todoList;
        } catch (error) {
            throw error;
        }

    }

    static async delTodo(id) {
        try {
            const deleted = await ToDoModel.findOneAndDelete({ _id: id });
            return deleted;
        } catch (error) {
            throw error;
        }
    }



}
module.exports = ToDoService;