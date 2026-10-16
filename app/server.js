const express = require("express");
const fs = require("fs");
const path = require("path");
const app = express();
app.use(express.json());
const region = process.env.REGION_NAME || "unknown";
const dataFile = process.env.DATA_FILE || "/data/data.json";

function ensureFile() {
  fs.mkdirSync(path.dirname(dataFile), { recursive: true });
  if (!fs.existsSync(dataFile)) {
    fs.writeFileSync(dataFile, JSON.stringify({ createdAt: new Date().toISOString(), records: [] }, null, 2));
  }
}
function readData() {
  ensureFile();
  return JSON.parse(fs.readFileSync(dataFile, "utf8"));
}
app.get("/", (req, res) => res.json({ project: "Disaster Recovery Platform", servingRegion: region }));
app.get("/health", (req, res) => res.json({ status: "healthy", servingRegion: region, timestamp: new Date().toISOString() }));
app.get("/data", (req, res) => res.json({ servingRegion: region, data: readData() }));
app.post("/data", (req, res) => {
  if (!req.body || Object.keys(req.body).length === 0) return res.status(400).json({ error: "Send a non-empty JSON body" });
  const data = readData();
  data.records.push({ id: data.records.length + 1, createdAt: new Date().toISOString(), payload: req.body });
  fs.writeFileSync(dataFile, JSON.stringify(data, null, 2));
  res.status(201).json({ message: "Record saved", servingRegion: region, recordCount: data.records.length });
});
ensureFile();
app.listen(5000, "0.0.0.0", () => console.log(`${region} app listening on port 5000`));
