import React, { useRef, useEffect, useState } from 'react';
import { connect } from 'react-redux';

import { Modal } from '../../common';
import ManageGroup from './ManageGroup';
import * as actions from '../../store/actions';
import { ConnectedTaskList } from './TaskList';

const GroupList = ({
  groups = [],
  requestGroups,
  loadingGroups,
  tasks = [],
  requestTasks,
  loadingTasks,
}) => {
  const [displayModal, setDisplayModal] = useState(false);
  const handleAddNewClick = (e) => {
    e.preventDefault();
    //newGroupModalRef.current.show();
    setDisplayModal(true);
  };
  //const newGroupModalRef = useRef();

  useEffect(() => {
    if (groups.length === 0) {
      requestGroups();
    }
    if (tasks.length === 0) {
      requestTasks();
    }
  }, []);

  return (
    <>
      <h4>My Todos</h4>
      <a href="#" onClick={handleAddNewClick} style={{ color: 'blue' }}>
        Add New
      </a>
      <hr />
      <div className="card-columns">
        {groups.map((group) => (
          <div key={group.id}>
            <ConnectedTaskList
              id={group.id}
              name={group.name}
              progresspercent={group.progresspercent}
            />
          </div>
        ))}
      </div>
      <Modal display={displayModal}>
        <div className="modal-header">
          <h4>Add New Group</h4>
          <button
            type="button"
            className="close"
            onClick={() => setDisplayModal(false)}
          >
            <span>&times;</span>
          </button>
        </div>
        <div className="modal-body">
          <ManageGroup onClose={() => setDisplayModal(false)} />
        </div>
      </Modal>
    </>
  );
};

function mapStateToProps(state, ownProps) {
  return {
    loadingGroups: state.todos.group.loading,
    groups: state.todos.group.groups,
    groupError: state.todos.group.error,
    loadingTasks: state.todos.task.loading,
    tasks: state.todos.task.tasks,
    taskError: state.todos.task.error,
  };
}

const mapDispatchToProps = {
  requestGroups: actions.requestGroups,
  requestTasks: actions.requestTasks,
};

export const ConnectedGroupList = connect(
  mapStateToProps,
  mapDispatchToProps
)(GroupList);
