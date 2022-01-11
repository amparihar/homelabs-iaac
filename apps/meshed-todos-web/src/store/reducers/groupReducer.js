import produce from 'immer';

import * as actionTypes from '../actions/actionTypes';

const initialState = {
  groups: [],
  error: '',
  loading: false,
};

function groupReducer(state = initialState, action) {
  switch (action.type) {
    case actionTypes.GET_GROUPS_SUCCESS:
      return produce(state, (draft) => {
        draft.groups = [...action.groups];
        draft.error = '';
      });
    case actionTypes.GET_GROUPS_FAIL:
      return produce(state, (draft) => {
        draft.groups = [];
        draft.error = action.errorMsg;
      });
    case actionTypes.LOADING_GROUPS:
      return produce(state, (draft) => {
        draft.loading = action.loading;
      });
    case actionTypes.ADD_GROUP_SUCCESS:
      return produce(state, (draft) => {
        draft.groups.push(action.group);
      });
    case actionTypes.UPDATE_GROUP_SUCCESS:
      return produce(state, (draft) => {
        for (let group of draft.groups) {
          if (group.id === action.group.id) {
            group.name = action.group.name;
            break;
          }
        }
      });
    case actionTypes.UPDATE_GROUP_PROGRESS:
      return produce(state, (draft) => {
        for (let group of draft.groups) {
          if (group.id === action.progress.groupId) {
            group.progresspercent = action.progress.progresspercent;
            break;
          }
        }
      });
    case actionTypes.SAVE_GROUP_FAIL:
      return produce(state, (draft) => {
        draft.error = action.errorMsg;
      });

    default:
      return state;
  }
}

export default groupReducer;
