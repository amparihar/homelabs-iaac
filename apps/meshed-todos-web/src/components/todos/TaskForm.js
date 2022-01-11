import React, { useState } from 'react';
import { withRouter, useHistory } from 'react-router-dom';

const WrappedTaskForm = ({ task, ...props }) => {
  const [formState, setFormState] = useState({ ...task });
  const handleBack = () => props.history.push('/todos');
  const handleOnChange = (e) => {
    const { name, value, checked, type } = e.target;
    setFormState((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value,
    }));
  };
  const handleSubmit = (e) => {
    e.preventDefault();
    // Exclude progresspercent attribute from the task object as it is a computed field
    const { progresspercent, ...task } = formState;
    props.save(task);
    handleBack();
  };
  return (
    <div className="row">
      <div className="col-sm-6">
        <div className="card p-2 w-75">
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <input
                type="text"
                name="name"
                value={formState.name}
                onChange={handleOnChange}
                className="form-control"
                placeholder="Enter Task Name"
                autoComplete="off"
                required
              />
            </div>
            <div>
              <label className="mr-2">Completed</label>
              <input
                type="checkbox"
                name="isCompleted"
                checked={formState.isCompleted}
                onChange={handleOnChange}
              />
            </div>
            <hr />
            <button type="submit" className="btn btn-primary">
              {task.id ? 'Update Task' : 'Add Task'}
            </button>
          </form>
        </div>
        <div className="pt-2">
          <button
            type="button"
            className="btn btn-primary"
            onClick={handleBack}
          >
            Back
          </button>
        </div>
      </div>
    </div>
  );
};

export default withRouter(WrappedTaskForm);
