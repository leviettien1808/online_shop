const mysql2 = require("mysql2");

const pool = mysql2.createPool({
  host: "",
  user: "",
  database: "",
  password: "",
});

module.exports = pool.promise();
