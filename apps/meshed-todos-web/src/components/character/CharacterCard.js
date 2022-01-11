import React from "react";

import { useRenderer } from "../../common";

import './style.css'

const CharacterCard = React.memo((props) => {
  //useRenderer('CharacterCard')
  return (
    <>
      <div className="card">
        <img
          className="card-image img-fluid"
          src={`${props.thumbnail.path}.${props.thumbnail.extension}`}
          alt="Card image cap"
        />
        <div className="card-body">
          <h6 className="card-title">{props.name}</h6>
        </div>
      </div>
    </>
  );
})

export default CharacterCard;
