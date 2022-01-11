import * as actionTypes from "../actions/actionTypes";
import { InitialState } from "./initialState";

const eventReducer = (state = InitialState.events, action) => {
  switch (action.type) {
    case actionTypes.CREATE_EVENT:
      //return [...state, action.event];
      return [...state, { ...action.event }];
    default:
      return state;
  }
};

export default eventReducer;
