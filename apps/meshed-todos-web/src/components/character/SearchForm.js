import React, { useState } from "react";

function SearchForm(props) {
  const [character, setCharacter] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    setCharacter("");
    props.onSearch(character || "");
  };

  const handleOnChange = event => {
    const { target = {} } = event || {};
    const { value = "" } = target || {};
    setCharacter(value);
  };
  return (
    <React.Fragment>
      <form className="form-inline" onSubmit={handleSubmit}>
        <div className="form-group mb-2">
          <label className="sr-only">Search</label>
          <input
            required
            autoComplete="off"
            type="text"
            name="character"
            className="form-control"
            placeholder="Search Character"
            value={character}
            onChange={handleOnChange}
          />
        </div>
        <button type="submit" className="btn btn-primary mb-2">
          Search
        </button>
      </form>
    </React.Fragment>
  );
}

export default SearchForm;
