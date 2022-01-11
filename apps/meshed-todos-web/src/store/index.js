import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import reduxImmutableStateInvariant from 'redux-immutable-state-invariant';
import rootReducer from './reducers';

import { createLogger } from 'redux-logger';

// function configureAppStore(initialState) {
//   return createStore(
//     appReducer,
//     initialState,
//     applyMiddleware(createLogger(), reduxImmutableStateInvariant())
//   );
// }

// export default configureAppStore;

export const store = createStore(
  rootReducer,
  applyMiddleware(thunk, reduxImmutableStateInvariant(),createLogger({}))
);
