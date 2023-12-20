const ToDoModel = require('../model/todo.model');

class ToDoService {
    static async createTodo(userId, title, description) {
        try {
            const createTodo = new ToDoModel({ userId, title, description });
            return await createTodo.save();

        } catch (err) {
            throw err;
        }
    }



}
module.exports = ToDoService;