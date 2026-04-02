const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get("/", (_req, res) => {
  res.json({
    name: "lab-status-api",
    message: "Lab status: OK",
    version: "1.0.0",
  });
});

app.get("/status", (_req, res) => {
  res.json({
    labStatus: "OK",
  });
});

app.listen(PORT, () => {
  console.log(`lab-status-api listening on port ${PORT}`);
});
