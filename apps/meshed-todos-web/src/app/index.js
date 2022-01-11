import React, { useContext } from 'react';
import { Switch, Route } from 'react-router-dom';
// @flow
import {
  LoginPage,
  CounterWidget,
  CharacterList,
  Diffing,
  ConnectedEventList,
  ConnectedGroupList,
  ConnectedManageTask,
  NotFound,
  AuthGuard,
} from './../components';
import { Header, UserContext } from './../common';
import { AuthRoute } from './../router/guards';
import { RouteConfig } from './../router/routeConfig';
import { AppErrorBoundary } from '../errorBoundary';

const App = () => {
  const { user } = useContext(UserContext);
  const routes = RouteConfig.map(
    ({ path, exact, component: Component, ignoreAuth, active }, idx) => {
      // <AuthRoute
      //   key={idx}
      //   path={path}
      //   exact={exact}
      //   component={Component}
      //   ignoreAuth={ignoreAuth}
      // />
      return active ? (
        <Route key={idx} path={path} exact={exact}>
          {AuthGuard(Component, ignoreAuth)}
        </Route>
      ) : null;
    }
  );
  return (
    //React.createElement(Header, null)
    <>
      {/*<UserContext.Provider> */}
      {user.isAuthenticated && <Header />}
      <Switch>{routes}</Switch>
      {/*</UserContext.Provider> */}
    </>
  );
};

export default () => {
  return (
    <AppErrorBoundary
      render={({ error, errorInfo }) => (
        <p className="alert alert-danger">{`An error has occurred`}</p>
      )}
    >
      <App />
    </AppErrorBoundary>
  );
};
