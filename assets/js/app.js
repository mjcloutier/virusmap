// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import '../css/app.scss';

import 'phoenix_html';
import 'phoenix_ujs';
import 'airbnb-browser-shims';
import 'datatables.net-bs4';
import 'jquery';
import 'popper.js';
import 'bootstrap';
import 'react-phoenix';

import Turbolinks from 'turbolinks';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import SimpleMap from './components/simple_map.jsx';

Turbolinks.start();

window.Components = {
  SimpleMap,
};
