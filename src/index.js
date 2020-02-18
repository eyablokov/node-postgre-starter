var express = require('express'),
    config = require('dotenv/config');

const app = express();
const product = 'Fake Product';

app.get('/', (req, res) => {
  return res.send(`Hello ${product}.`);
});

app.listen(process.env.PORT, () =>
  console.log(`App listening on port ${process.env.PORT}.`),
);
