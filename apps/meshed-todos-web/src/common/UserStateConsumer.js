import React, { useContext } from 'react';

import { UserContext } from './';

// ** User State Container Consumer
const UserStateConsumer = ({ children, ...props }) => {
  const { user, setUser } = useContext(UserContext);
  return children({ user, setUser, props });
};

export default UserStateConsumer;
