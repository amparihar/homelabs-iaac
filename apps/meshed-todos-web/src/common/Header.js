import React, { useContext, useEffect } from 'react';
import { NavLink, withRouter } from 'react-router-dom';

import * as actions from '../store/actions';
import { UserContext } from './UserContext';

import { useDispatch } from 'react-redux';

const WrappedHeader = ({ history }) => {
  const dispatch = useDispatch();
  const { user, setUser } = useContext(UserContext);

  // useEffect(() => {
  //   console.log('Header', user);
  // }, [user]);

  const activeStyle = { color: 'orange' };

  const handleLogout = () => {
    dispatch(actions.requestUserSignOut());
    setUser((user) => ({
      ...user,
      userName: '',
      isAuthenticated: false,
    }));
    history.push('/');
  };

  return (
    <nav className="navbar navbar-expand navbar-dark bg-dark">
      <div className="collapse navbar-collapse" id="navbarNav">
        <div className="navbar-nav">
          {/* <NavLink
            to="/character"
            exact
            activeStyle={activeStyle}
            className="nav-item nav-link"
          >
            Characters
          </NavLink>
          <NavLink
            to="/counter"
            activeStyle={activeStyle}
            className="nav-item nav-link"
          >
            Counter
          </NavLink>
          <NavLink
            to="/diffing"
            activeStyle={activeStyle}
            className="nav-item nav-link"
          >
            Diffing
          </NavLink>
          <NavLink
            to="/events"
            activeStyle={activeStyle}
            className="nav-item nav-link"
          >
            Events
          </NavLink> */}
          <NavLink
            to="/todos"
            activeStyle={activeStyle}
            className="nav-item nav-link"
          >
            My ToDo List
          </NavLink>
        </div>
      </div>

      {user.isAuthenticated && (
        <span className="navbar-text">
          <a
            href="#"
            onClick={handleLogout}
            className="nav-item nav-link float-right"
          >
            <span className="glyphicon glyphicon-user" />
            Logout {user.userName}
          </a>
        </span>
      )}
    </nav>
  );
};

export default withRouter(WrappedHeader);
