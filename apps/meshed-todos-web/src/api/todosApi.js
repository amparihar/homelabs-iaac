import {
  handleResponse,
  handleError,
  baseGroupUrl,
  baseTaskUrl,
} from './apiUtils';

export const getGroups = (token) => {
  return fetch(`${baseGroupUrl}/group/list`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  })
    .then(handleResponse)
    .catch(handleError);
};

export const saveGroup = (group, token) => {
  return fetch(`${baseGroupUrl}/group`, {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(group),
  })
    .then(handleResponse)
    .catch(handleError);
};

export const getTasks = (token) => {
  return fetch(`${baseTaskUrl}/task/list`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  })
    .then(handleResponse)
    .catch(handleError);
};

export const saveTask = (task, token) => {
  return fetch(`${baseTaskUrl}/task`, {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(task),
  })
    .then(handleResponse)
    .catch(handleError);
};
