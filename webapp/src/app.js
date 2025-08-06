const express = require("express");
const routes = require("./routes/router");
const { sequelize } = require("./models");
require("dotenv").config();

const port = process.env.PORT || 3000;

const app = express();
app.use(express.json());

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "OK",
    timestamp: new Date().toISOString(),
    database: "connected",
  });
});

app.use("/api", routes);

// Database connection and sync
const startServer = async () => {
  try {
    await sequelize.authenticate();
    console.log("✅ Database connection has been established successfully.");

    // Sync database (create tables)
    await sequelize.sync({
      force: false, // Set to true to recreate tables on every restart (be careful in production!)
      alter: false, // Set to true to alter existing tables to match models
    });
    console.log("✅ Database tables synced successfully.");

    app.listen(port, "0.0.0.0", () => {
      console.log(`Server running at http://localhost:${port}`);
    });
  } catch (error) {
    console.error("DB connection failed. Retrying in 5s...", error);
    setTimeout(startServer, 5000);
  }
};

startServer();
