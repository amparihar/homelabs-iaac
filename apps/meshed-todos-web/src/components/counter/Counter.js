import React from "react";
import { useState as state, useEffect, useCallback } from "react";
import PropTypes from "prop-types";

import { useRenderer } from "../../common";

const Counter = React.memo(
  ({ count = 0, handleAdd, handleSubstract, disabled = false }) => {
    useRenderer("Counter");
    return (
      <>
        <button onClick={handleSubstract} className="mr-1" disabled={count === 0 ? disabled : false}>
          -
        </button>
        <Display message={count} />
        <button onClick={handleAdd} className="ml-1">
          +
        </button>
      </>
    );
  }
);

Counter.propTypes = {
  count: PropTypes.number,
  handleAdd: PropTypes.func,
  handleSubstract: PropTypes.func
};

function Display({ message }) {
  return <div className="badge">{message}</div>;
}

function CounterWidget() {
  const [counter, setCounter] = state(0);
  const addFn = useCallback(() => setCounter(prev => prev + 1), [setCounter]);
  const substractFn = useCallback(() => setCounter(prev => prev - 1), [
    setCounter
  ]);
  useRenderer("CounterWidget");

  // const foo = () => {}
  // useEffect(() => {
  //   console.log("On Render");
  //   return () => console.log("on unmount");
  // }, [foo]);

  return (
    <>
      <h3>Counter Widget</h3>
      <Counter
        handleAdd={addFn}
        handleSubstract={substractFn}
        count={counter}
      />
    </>
  );
}

export default CounterWidget;
