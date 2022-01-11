import * as actionTypes from "./actionTypes";

// Action Creators
const createEvent = event => ({ type: actionTypes.CREATE_EVENT, event }); // concise property

export default createEvent;
