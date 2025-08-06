const express = require("express");
const router = express.Router();

const userController = require("../controller/userController");

router.get("/users", userController.getAllUsers);
router.get("/users/id", userController.getUserById);
router.post("/users", userController.createUser);
router.post("/users:id", userController.deleteUser);
router.post("/users:id", userController.updateUser);

module.exports = router;
