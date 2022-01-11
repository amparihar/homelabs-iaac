import React, { useContext } from 'react';
import { Route, Redirect } from 'react-router-dom';

import { UserContext } from '../../common';

function AuthRoute({
  component: Component,
  ignoreAuth = false,
  ...routeProps
}) {
  const { user } = useContext(UserContext);
  return (
    <Route {...routeProps}>
      {/* render props children (rPc) */}
      {componentProps => {
        //console.log(componentProps);
        return ignoreAuth ? (
          <Component {...componentProps} />
        ) : user.isAuthenticated ? (
          <Component {...componentProps} />
        ) : (
          <Redirect
            to={{
              pathname: '/',
              state: { referrer: componentProps.location.pathname }
            }}
          />
        );
      }}
    </Route>
  );
}

export default AuthRoute;
