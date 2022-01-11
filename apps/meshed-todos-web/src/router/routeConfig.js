import * as component from './../components';
// List configs from specific to generic in order
const config = [
  {
    path: '/',
    exact: true,
    component: component.SignInPage,
    ignoreAuth: true,
    active: true,
  },
  {
    path: '/signUp',
    exact: true,
    component: component.SignUpPage,
    ignoreAuth: true,
    active: true,
  },
  {
    path: '/character',
    exact: false,
    component: component.CharacterList,
    ignoreAuth: false,
    active: false,
  },
  {
    path: '/counter',
    exact: false,
    component: component.CounterWidget,
    ignoreAuth: false,
    active: false,
  },
  {
    path: '/diffing',
    exact: false,
    component: component.Diffing,
    active: false,
  },
  {
    path: '/events',
    exact: false,
    component: component.ConnectedEventList,
    ignoreAuth: false,
    active: false,
  },
  {
    path: '/todos/task/:taskId/:groupId',
    exact: false,
    component: component.ConnectedManageTask,
    ignoreAuth: false,
    active: true,
  },
  // {
  //   path: '/todos/task',
  //   exact: false,
  //   component: component.ConnectedManageTask,
  //   ignoreAuth: false
  // },
  {
    path: '/todos',
    exact: false,
    component: component.ConnectedGroupList,
    ignoreAuth: false,
    active: true,
  },
  {
    path: '/health-check',
    exact: false,
    component: component.HealthCheck,
    ignoreAuth: true,
    active: false,
  },
  {
    path: '*',
    exact: false,
    component: component.NotFound,
    ignoreAuth: true,
    active: true,
  },
];

export const RouteConfig = config;
