import {
  handleResponse,
  handleError,
  baseUserUrl as baseUrl,
} from './apiUtils';

export const signUp = (id, username, password) => {
  return fetch(`${baseUrl}/user`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ id, username, password }),
  })
    .then(handleResponse)
    .catch(handleError);
};

export const signIn = (username, password) => {
  return fetch(`${baseUrl}/user/signin`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ username, password }),
  })
    .then(handleResponse)
    .catch(handleError);
};
