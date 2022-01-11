import { combineReducers } from 'redux';

import * as actionTypes from '../actions/actionTypes';
import events from './eventReducer';
import todos from './todoReducer';
import user from './userReducer';

const appReducer = combineReducers({ events, todos, user });

const rootReducer = (state, action) => {
  if (action.type === actionTypes.USER_SIGNOUT) {
    state = undefined;
  }
  return appReducer(state, action);
};

export default rootReducer;
