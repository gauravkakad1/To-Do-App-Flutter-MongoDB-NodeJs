const UserModel = require('../model/user.model');
const UserService = require('../services/user.service');

exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const sucessRes = await UserService.registerUser(email, password);
        res.json({ status: true, success: "Registered Successfully" })
    } catch (error) {
        throw error
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserService.checkUser(email);
        if (!user) {
            throw new Error("User doesn't exixst");
        }
        const isMatch = await user.comparePassword(password);
        if (isMatch === false) {
            throw new Error("Wrong password");
        };

        let tokenData = { _id: user._id, email: user.email };
        const token = await UserService.generateToken(tokenData, "secretKey", '1h');
        res.status(200).json({ status: true, success: "sendData", token: token });


    } catch (error) {
        throw error
    }
}