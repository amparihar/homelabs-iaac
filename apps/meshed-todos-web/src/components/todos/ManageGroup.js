import React from 'react';
import { useDispatch, useSelector } from 'react-redux';

import GroupForm from './GroupForm';
import * as actions from '../../store/actions';

const ManageGroup = ({ groupId = '', ...props }) => {
  const dispatch = useDispatch();
  const group = useSelector(
    (state) =>
      state.todos.group.groups.find((group) => group.id === groupId) || {
        id: '',
        name: '',
      }
  );
  const handleSave = (group) => {
    dispatch(actions.requestSaveGroup(group));
    props.onClose();
  };

  return <GroupForm group={group} onSave={handleSave} />;
};

export default ManageGroup;
