import React, { useContext } from 'react';
import { Redirect } from 'react-router-dom';

import { UserContext } from '../../common';

function AuthGuard(Component, ignoreAuth) {
  const { user } =  useContext(UserContext);
  const withAuthGuard = props => {
    return ignoreAuth ? (
      <Component {...props} />
    ) : user.isAuthenticated ? (
      <Component {...props} />
    ) : (
      <Redirect
        to={{
          pathname: '/',
          state: { referrer: props.location.pathname }
        }}
      />
    );
  };

  return withAuthGuard;
}

export default AuthGuard;
