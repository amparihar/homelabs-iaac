import React, { Component } from "react";
import { render } from "react-dom";

class Counter extends Component {
  // constructor(props) {
  //   super(props);

  //   this.state = {
  //     counter: 0
  //   };
  // }

  state = {
    counter : 0
  }

  render() {
    return (
      <>
        <button
          onClick={() => this.setState({ counter: this.state.counter - 1 })}
        >
          -
        </button>
        <div className="badge">{this.state.counter}</div>
        <button
          onClick={() => this.setState({ counter: this.state.counter + 1 })}
        >
          +
        </button>
      </>
    );
  }
}

export default Counter;
