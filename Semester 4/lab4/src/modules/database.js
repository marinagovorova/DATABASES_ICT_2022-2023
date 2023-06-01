const { Pool } = require('pg');


require('dotenv').config();

const pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT
});

pool.connect((err) => {
    if (err) throw err;
    console.log('Connected to PostgreSQL server');
});

const createTables = async () => {
    try {
        await pool.query(`
        CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    `)
        await pool.query(`
        CREATE TABLE IF NOT EXISTS exercises (
            id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT
          );
    
    `);
        console.log('Created tables');
    }
    catch (error) {
        console.error('Error creating ', error);
    }
};

module.exports = {
    createTables,
    pool
};