import { combineReducers } from 'redux';
import produce from 'immer';

import { InitialState } from './initialState';
import * as actionTypes from '../actions/actionTypes';
import task from './taskReducer';
import group from './groupReducer';

const todoReducer = combineReducers({ task, group });

// function todoReducer_1(state = InitialState.todos, action) {
//   switch (action.type) {
//     case actionTypes.ADD_TASK_SUCCESS:
//       return produce(state, draft => {
//         draft.tasks.push({ ...action.task });
//       });
//     // return {
//     //   groups: [...state.groups],
//     //   comments: [...state.comments],
//     //   tasks: [...state.tasks, { ...action.task }]
//     // };
//     case actionTypes.UPDATE_TASK_SUCCESS:
//       return produce(state, draft => {
//         for (let task of draft.tasks) {
//           if (task.id === action.task.id) {
//             task.name = action.task.name;
//             task.isCompleted = action.task.isCompleted;
//             break;
//           }
//         }
//       });
//     // return {
//     //   groups: [...state.groups],
//     //   comments: [...state.comments],
//     //   tasks: state.tasks.map(task =>
//     //     task.id === action.task.id ? action.task : task
//     //   )
//     // };
//     default:
//       return state;
//   }
// }

export default todoReducer;
