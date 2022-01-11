import React, { useState } from 'react';
import { PropTypes } from 'prop-types';
import { UserContext } from './UserContext';

// ** User State Container Provider
const UserStateProvider = ({ children }) => {
  const [user, setUser] = useState({
    userName: '',
    isAuthenticated: false
  });

  const childrenCount = React.Children.count(children)
  return (
    <UserContext.Provider value={{ user, setUser }}>
      {children}
    </UserContext.Provider>
  );
};

UserStateProvider.propTypes = {
  children : PropTypes.oneOfType([PropTypes.func, PropTypes.node])
}

export default UserStateProvider;


