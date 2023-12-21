const app = require('./app');
const db = require('./config/db');
const UserModel = require('./model/user.model');
const ToDoModel = require('./model/todo.model');
const port = 3000;

app.get('/', (req, res) => {
    res.send("Welcome");
});
app.get('/home', (req, res) => {
    res.send("Home page"); ṇ
});

app.listen(port, () => {
    console.log('running at => http://localhost:3000');
});
