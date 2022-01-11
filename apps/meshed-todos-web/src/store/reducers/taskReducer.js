import produce from 'immer';

import * as actionTypes from '../actions/actionTypes';

const initialState = {
  tasks: [],
  error: '',
  loading: false,
};

function taskReducer(state = initialState, action) {
  switch (action.type) {
    case actionTypes.GET_TASKS_SUCCESS:
      return produce(state, (draft) => {
        draft.tasks = [...action.tasks];
        draft.error = '';
      });
    case actionTypes.GET_TASKS_FAIL:
      return produce(state, (draft) => {
        draft.tasks = [];
        draft.error = action.errorMsg;
      });
    case actionTypes.LOADING_TASKS:
      return produce(state, (draft) => {
        draft.loading = action.loading;
      });
    case actionTypes.ADD_TASK_SUCCESS:
      return produce(state, (draft) => {
        draft.tasks.push({ ...action.task });
        draft.error = '';
      });
    case actionTypes.UPDATE_TASK_SUCCESS:
      return produce(state, (draft) => {
        for (let task of draft.tasks) {
          if (task.id === action.task.id) {
            task.name = action.task.name;
            task.isCompleted = action.task.isCompleted;
            break;
          }
        }
        draft.error = '';
      });
    case actionTypes.SAVE_TASK_FAIL:
      return produce(state, (draft) => {
        draft.error = action.errorMsg;
      });
    default:
      return state;
  }
}

export default taskReducer;
