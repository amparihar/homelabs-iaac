export async function authLogin(userName, password) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve({
        userName,
        isAuthenticated: true
      });
    }, 500);
  });
}
