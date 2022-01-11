import React, { Fragment, useState } from 'react';

const GroupForm = ({ group, onSave, ...props }) => {
  const [formState, setFormState] = useState({ ...group });
  const handleOnChange = (e) => {
    const { name, value } = e.target;
    setFormState((prev) => ({
      ...prev,
      [name]: value,
    }));
  };
  const handleSubmit = (e) => {
    e.preventDefault();
    // Exclude progresspercent attribute from the group object as it is a computed field
    const { progresspercent, ...group } = formState;
    onSave(group);
  };
  return (
    <Fragment>
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <input
            type="text"
            name="name"
            value={formState.name}
            onChange={handleOnChange}
            className="form-control"
            placeholder="Enter Group Name"
            autoComplete="off"
            required
          />
        </div>
        <button type="submit" className="btn btn-primary">
          {group.id ? 'Update Group' : 'Add Group'}
        </button>
      </form>
    </Fragment>
  );
};

export default GroupForm;