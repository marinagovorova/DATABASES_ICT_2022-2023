const express = require('express')
const bodyParser = require('body-parser');
const db = require('./src/modules/database');
const port = Number(process.env.PORT ?? 3000);

require('dotenv').config();

db.createTables();
const pool = db.pool;
const app = express()
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)
app.use(bodyParser.json()) ;

app.get('/exercises', async (req, res) => {
  try {
    const query = 'SELECT * FROM exercises';
    const { rows } = await pool.query(query);
    res.json(rows);
  } catch (error) {
    console.error('Error getting exercises', error);
    res.status(500).json({ error: 'Could not get exercises' });
  }
});

app.post('/exercises', async (req, res) => {
  const { name, description } = req.body;
  try {
    const query = `
      INSERT INTO exercises (name, description) 
      VALUES ($1, $2)
      RETURNING *
    `;
    const values = [name, description];
    const { rows } = await pool.query(query, values);
    console.log('Exercise created:', rows[0]);
    res.status(201).json(rows[0]);
  } catch (error) {
    console.error('Error creating exercise', error);
    res.status(500).json({ error: 'Could not create exercise' });
  }
});

app.delete('/exercises/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const query = `
      DELETE FROM exercises 
      WHERE id = $1 
      RETURNING *
    `;
    const values = [id];
    const { rows } = await pool.query(query, values);
    console.log('Exercise deleted:', rows[0]);
    res.json(rows[0]);
  } catch (error) {
    console.error('Error deleting exercise', error);
    res.status(500).json({ error: 'Could not delete exercise' });
  }
});

app.put('/exercises/:id', async (req, res) => {
  const { id } = req.params;
  const { name, description } = req.body;
  try {
    if (!name || !description) {
      return res.status(400).json({ error: 'Name and description are required' });
    }

    const query = `
      UPDATE exercises 
      SET name = $2, description = $3 
      WHERE id = $1 
      RETURNING *
    `;
    const values = [id, name, description];
    const { rows } = await pool.query(query, values);
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Exercise not found' });
    }
    console.log('Exercise updated:', rows[0]);
    res.json(rows[0]);
  } catch (error) {
    console.error('Error updating exercise', error);
    res.status(500).json({ error: 'Could not update exercise' });
  }
});



app.listen(port, () => {
  console.log(`🚀 Server ready`);
});


app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');

})