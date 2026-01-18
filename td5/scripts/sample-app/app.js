const express = require('express');

const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.get('/name/:name', (req, res) => {
	const name = req.params.name;
  res.send(`Hello, ${name}!`);
});

app.get('/add/:a/:b', (req, res) => {
  const a = Number(req.params.a);
  const b = Number(req.params.b);

  if (isNaN(a) || isNaN(b)) {
    return res.status(400).send('Both a and b must be numbers');
  }

  const sum = a + b;
  res.send(`Sum: ${sum}`);
});



module.exports = app;
