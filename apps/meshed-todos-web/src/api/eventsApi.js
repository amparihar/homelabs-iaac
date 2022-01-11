// https://my-json-server.typicode.com/amparihar/api
// https://github.com/amparihar

import { handleResponse, handleError } from "./apiUtils";
const baseUrl = "https://my-json-server.typicode.com/amparihar/api/events/";

export const getEvents = () => {
  return fetch(baseUrl)
    .then(handleResponse)
    .catch(handleError);
};

export const saveEvent = event => {
  return fetch(baseUrl + (event.id || ""), {
    method: event.id ? "PUT" : "POST", // POST for create, PUT to update when id already exists.
    headers: { "content-type": "application/json", "Authorization": `Bearer` },
    body: JSON.stringify(event)
  })
    .then(handleResponse)
    .catch(handleError);
};
