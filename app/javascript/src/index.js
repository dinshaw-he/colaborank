import * as React from 'react';
import * as ReactDOM from 'react-dom';

window.onload = function() {
  const container = document.querySelector('#react-target')
  console.log('container', container);
  const element = <p>Hello World!</p>;
  ReactDOM.render(element, container)
}
