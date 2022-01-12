import React, { useState } from 'react';
import { CircularProgressbar, buildStyles } from 'react-circular-progressbar';
import { connect } from 'react-redux';
import { Link, withRouter } from 'react-router-dom';
import { Modal } from '../../common';
import ManageGroup from './ManageGroup';

const WrappedTaskList = ({
  id: groupId,
  name: groupName,
  progresspercent = 0,
  tasks,
  ...props
}) => {
  const [displayModal, setDisplayModal] = useState(false);
  const handleEditGroupClick = (e) => {
    e.preventDefault();
    setDisplayModal(true);
  };

  return (
    <div className="card">
      <div className="card-header" onClick={handleEditGroupClick}>
        <div className="row">
          <div className="col-sm-6">
            <h4 style={{ cursor: 'pointer', color: 'blue' }}>{groupName} </h4>
          </div>
          <div className="col-sm-6">
            <div style={{ width: 40, height: 40 }} className="float-right">
              <CircularProgressbar
                value={progresspercent}
                text={`${progresspercent}%`}
                strokeWidth={12}
                styles={buildStyles({
                  textColor: 'red',
                  pathColor: `turquoise`,
                  trailColor: `gold`,
                  textSize: '25px',
                })}
              />
            </div>
          </div>
        </div>
      </div>
      <ul className="list-group list-group-flush">
        {tasks.map((task) => (
          <li key={task.id} className="list-group-item">
            <Link to={`${props.match.url}/task/${task.id}/${groupId}`}>
              {' '}
              <span
                style={
                  task.isCompleted
                    ? { textDecoration: 'line-through' }
                    : { textDecoration: 'none' }
                }
              >
                {task.name}
              </span>
            </Link>
          </li>
        ))}
      </ul>
      <div className="card-body">
        <Link to={`${props.match.url}/task/0/${groupId}`}>
          <button className="btn btn-primary" type="button">
            Add New Task
          </button>
        </Link>
      </div>
      <Modal display={displayModal}>
        <div className="modal-header">
          <h4>Edit Group</h4>
          <button
            type="button"
            className="close"
            onClick={() => setDisplayModal(false)}
          >
            <span>&times;</span>
          </button>
        </div>
        <div className="modal-body">
          <ManageGroup
            groupId={groupId}
            onClose={() => setDisplayModal(false)}
          />
        </div>
      </Modal>
    </div>
  );
};

const mapStateToProps = (state, ownProps) => {
  const { id: groupId } = ownProps;
  // completed task appear last
  const tasks = state.todos.task.tasks
    .filter((task) => task.groupId === groupId)
    .sort((a, b) =>
      a.isCompleted === b.isCompleted ? 0 : a.isCompleted ? 1 : -1
    );
  return {
    tasks,
  };
};

export const ConnectedTaskList = connect(mapStateToProps)(
  withRouter(WrappedTaskList)
);
