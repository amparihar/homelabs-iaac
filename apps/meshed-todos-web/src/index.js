import React from 'react';
import ReactDOM from 'react-dom';
import { Provider as ReduxProvider } from 'react-redux';
import { BrowserRouter as BRouter } from 'react-router-dom';

import App from './app';
import { store } from './store';
import { UserStateProvider } from './common';
import './style.css';

ReactDOM.render(
  <ReduxProvider store={store}>
    <BRouter>
      <UserStateProvider>
        <App />
      </UserStateProvider>
    </BRouter>
  </ReduxProvider>,
  document.getElementById('root')
);

/*
const renderFn = () => {
  document.getElementById("diffing").innerHTML = `
<input/>
<pre>${new Date().toLocaleTimeString()}</pre>
`;
};

setInterval(renderFn, 1000)
*/
