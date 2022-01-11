import React from "react";
import { useRenderer } from "../../common";

const PageLimit = React.memo(({ limit, onLimitClick, selected = 10 }) => {
  //useRenderer('PageLimit');
  let className = "btn btn-primary";
  {
    if (selected === limit) {
      className = className + " active";
    }
  }

  return (
    <div className="btn-group mr-1" role="group">
      <button
        type="button"
        className={className}
        onClick={() => onLimitClick(limit)}
      >
        {limit}
      </button>
    </div>
  );
});

export default PageLimit;
