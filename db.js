require('dotenv').config();
const {createConnection} = require("mysql2");

/* DATABASE FUNCTIONS: */
const mysql = createConnection({
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    charset: process.env.MYSQL_CHARSET,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD
});

mysql.connect(err => {
    if (err) return console.log(err);
    console.log(`[ MySQL ] Connected to the database.`);
});

function db(str) {
    return new Promise((resolve, reject) => {
        mysql.query(str,
            (error, data) => {
                if (error) {
                    reject(error);
                } else {
                    resolve(data);
                }
            }
        );
    });
}

module.exports = {db};