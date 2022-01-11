import produce from 'immer';
import * as actionTypes from '../actions/actionTypes';

const initialState = {
  identity: null,
  error: '',
  isAuthenticated: false
};

function userReducer(state = initialState, action) {
  switch (action.type) {
    case actionTypes.USER_SIGNIN:
      return produce(state, draft => {
        draft.identity = { ...action.user };
        draft.isAuthenticated = true;
        draft.error = '';
      });
    case actionTypes.USER_SIGNUP_FAIL:
    case actionTypes.USER_SIGNIN_FAIL:
      return produce(state, draft => {
        draft.identity = null;
        draft.error = action.errorMsg;
      });
    default:
      return state;
  }
}

export default userReducer;
