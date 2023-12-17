const app = require('./app');
const db = require('./config/db');
const UserModel = require('./model/user.model');
const port = 3000;

app.get('/', (req, res) => {
    res.send("Hello World");
});
app.get('/home', (req, res) => {
    res.send("Home page"); ṇ
});

app.listen(port, () => {
    console.log('running at => http://localhost:3000');
});
