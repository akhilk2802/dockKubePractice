const sequelize = require("../database/config");
const User = require("./User");

// Define associations here if you have multiple models
// Example:
// User.hasMany(Post);
// Post.belongsTo(User);

const models = {
  User,
  sequelize, // Export sequelize instance for sync
};

module.exports = models;
