import * as actionTypes from './actionTypes';
import { v4 as uuid } from 'uuid';

import * as todosApi from '../../api/todosApi';

// Action Creators
// get
function getGroupsSuccess(groups) {
  return { type: actionTypes.GET_GROUPS_SUCCESS, groups };
}
function getGroupsFail(errorMsg) {
  return { type: actionTypes.GET_GROUPS_FAIL, errorMsg };
}
function loadingGroups(loading) {
  return { type: actionTypes.LOADING_GROUPS, loading };
}

function getTasksSuccess(tasks) {
  return { type: actionTypes.GET_TASKS_SUCCESS, tasks };
}
function getTasksFail(errorMsg) {
  return { type: actionTypes.GET_TASKS_FAIL, errorMsg };
}
function loadingTasks(loading) {
  return { type: actionTypes.LOADING_TASKS, loading };
}

// put
function addGroupSuccess(group) {
  return { type: actionTypes.ADD_GROUP_SUCCESS, group };
}
function updateGroupSuccess(group) {
  return { type: actionTypes.UPDATE_GROUP_SUCCESS, group };
}
function saveGroupsFail(errorMsg) {
  return { type: actionTypes.SAVE_GROUP_FAIL, errorMsg };
}

function addTaskSuccess(task) {
  return { type: actionTypes.ADD_TASK_SUCCESS, task };
}
function updateTaskSuccess(task) {
  return { type: actionTypes.UPDATE_TASK_SUCCESS, task };
}
function saveTaskFail(errorMsg) {
  return { type: actionTypes.SAVE_TASK_FAIL, errorMsg };
}

function updateGroupProgress(progress) {
  return { type: actionTypes.UPDATE_GROUP_PROGRESS, progress };
}

// thunks
export function requestGroups() {
  return (dispatch, getState) => {
    dispatch(loadingGroups(true));
    return todosApi
      .getGroups(getState().user.identity.accessToken)
      .then((groups) => dispatch(getGroupsSuccess(groups)))
      .catch((err) => {
        dispatch(getGroupsFail(`Get groups request failed with error ${err}`));
      })
      .finally(() => dispatch(loadingGroups(false)));
  };
}

export function requestSaveGroup(group) {
  return (dispatch, getState) => {
    return todosApi
      .saveGroup(
        group.id ? group : { ...group, id: uuid() },
        getState().user.identity.accessToken
      )
      .then(
        (rsp) => {
          group.id
            ? dispatch(updateGroupSuccess(rsp))
            : dispatch(addGroupSuccess(rsp));
        },
        (err) =>
          dispatch(
            saveGroupsFail(`Save group request failed with error ${err}`)
          )
      );
  };
}

export function requestTasks() {
  return (dispatch, getState) => {
    dispatch(loadingTasks(true));
    return todosApi
      .getTasks(getState().user.identity.accessToken)
      .then((tasks) => dispatch(getTasksSuccess(tasks)))
      .catch((err) => {
        dispatch(getTasksFail(`Get Tasks request failed with error ${err}`));
      })
      .finally(() => dispatch(loadingTasks(false)));
  };
}

export function requestSaveTask(task) {
  return (dispatch, getState) => {
    return todosApi
      .saveTask(
        task.id ? task : { ...task, id: uuid() },
        getState().user.identity.accessToken
      )
      .then(
        (rsp) => {
          dispatch(
            updateGroupProgress({
              groupId: rsp.groupId,
              progresspercent: rsp.progresspercent,
            })
          );
          task.id
            ? dispatch(updateTaskSuccess(rsp))
            : dispatch(addTaskSuccess(rsp));
        },
        (err) =>
          dispatch(saveTaskFail(`Save group request failed with error ${err}`))
      );
  };
}
