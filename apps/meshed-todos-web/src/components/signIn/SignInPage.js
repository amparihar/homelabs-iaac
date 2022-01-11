import React, { useState, useContext, useEffect } from 'react';
import { Redirect, Link } from 'react-router-dom';

import * as userActions from '../../store/actions';
import { UserContext } from '../../common';

import { connect } from 'react-redux';
import { Alert, AlertTitle } from '@material-ui/lab';

const SignIn = ({ location, currentUser, requestUserSignIn, ...props }) => {
  const [signInForm, setSignInForm] = useState({
    userName: '',
    password: '',
  });
  const { user, setUser } = useContext(UserContext);
  const { referrer } = location.state || { referrer: '/todos' };

  const handleOnChange = (event) => {
    const { target = {} } = event || {};
    const { name = '', value = '' } = target || {};
    setSignInForm((form) => ({ ...form, [name]: value.trim() }));
  };

  const handleLogin = (event) => {
    event.preventDefault();
    requestUserSignIn(signInForm.userName, signInForm.password);
    // (async () => {
    //   const auth = await authLogin(user.userName, user.password);
    //   setUser(user => ({ ...user, isAuthenticated: auth.isAuthenticated }));
    // })();
  };

  useEffect(() => {
    if (currentUser && currentUser.identity) {
      setUser((user) => ({
        ...user,
        userName: currentUser.identity.username,
        isAuthenticated: currentUser.isAuthenticated,
      }));
    }
  }, [currentUser, setUser]);

  return (
    <React.Fragment>
      {user.isAuthenticated && <Redirect to={referrer} />}
      <h3 style={{ color: 'blue' }}>Sign In</h3>
      {currentUser && currentUser.error && (
        <div style={{ marginBottom: '10px' }}>
          <Alert severity="error">
            <AlertTitle>Error</AlertTitle>
            We didn't recognize the username or password you entered. Please try
            again.
          </Alert>
        </div>
      )}

      <form onSubmit={handleLogin}>
        <div className="row">
          <div className="col-sm-6">
            <div className="form-group">
              <input
                type="text"
                value={signInForm.userName}
                onChange={handleOnChange}
                name="userName"
                className="form-control"
                placeholder="User Name"
                autoComplete="off"
                required
              />
            </div>
            <div className="form-group">
              <input
                type="password"
                value={signInForm.password}
                onChange={handleOnChange}
                name="password"
                className="form-control"
                placeholder="Password"
                autoComplete="off"
                required
              />
            </div>

            <button type="submit" className="btn btn-primary">
              Sign In
            </button>
          </div>
        </div>
      </form>
      <div style={{ marginTop: '10px' }}>
        Don't have an account yet. <Link to="/signUp">Sign Up</Link>
      </div>
    </React.Fragment>
  );
};

// export default () => {
//   return (
//     <UserStateProvider>
//       <LoginPage />
//     </UserStateProvider>
//   );
// };

function mapStateToProps(state, ownProps) {
  return {
    currentUser: state.user,
  };
}

const mapDispatchToProps = {
  requestUserSignIn: userActions.requestUserSignIn,
};

export const SignInPage = connect(mapStateToProps, mapDispatchToProps)(SignIn);
