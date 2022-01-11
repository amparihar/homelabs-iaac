import React, { Component } from 'react';

class AppErrorBoundary extends Component {
  state = {
    hasError: false,
    error: '',
    errorInfo: ''
  };

  componentDidCatch(error, errorInfo) {
    console.log(`Error: ${error} ErrorInfo: ${errorInfo}`)
    this.setState(state => ({ ...state, hasError: true, error, errorInfo }));
  }

  render() {
    const { render, children } = this.props;
    if (this.state.hasError) {
      return render(this.state.error, this.state.errorInfo);
    }
    return children;
  }
}

export default AppErrorBoundary;
