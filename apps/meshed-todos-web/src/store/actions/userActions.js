import { v4 as uuid } from 'uuid';

import * as actionTypes from './actionTypes';
import * as userApi from '../../api/userApi';

// Action Creators

function userSignUpFail(errorMsg) {
  return { type: actionTypes.USER_SIGNUP_FAIL, errorMsg };
}

function userSignInFail(errorMsg) {
  return { type: actionTypes.USER_SIGNIN_FAIL, errorMsg };
}

// process user signIn
function userSignIn(user) {
  return { type: actionTypes.USER_SIGNIN, user };
};

export function requestUserSignOut() {
  return { type: actionTypes.USER_SIGNOUT };
};

// thunks
export function requestUserSignUp(username, password) {
  return (dispatch, getState) => {
    
    return userApi
      .signUp(uuid(), username, password)
      .then((user) => dispatch(userSignIn(user)), err => {
        dispatch(userSignUpFail('Failed to create user account.'))
      });
  };
}

// export function requestUserSignUp(username, password) {
//   return (dispatch, getState) => {
//     dispatch(userSignIn({ id: uuid(), username, password }));
//   };
// }

export function requestUserSignIn(username, password) {
  return (dispatch, getState) => {
    return userApi
      .signIn(username, password)
      .then((user) => dispatch(userSignIn(user)), err => {
        dispatch(userSignInFail('Failed to SignIn.'))
      });
  };
}
