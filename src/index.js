import './main.css';
const Elm = require('./App.elm');

const root = document.getElementById('root');
const application = {
  id: 1,
  term: 36,
  amount: 1000
};

Elm.App.embed(root, application);
