export const baseUserUrl = window.API_BASE_URL.USER;
export const baseGroupUrl = window.API_BASE_URL.GROUP;
export const baseTaskUrl = window.API_BASE_URL.TASK;

export async function handleResponse(response) {
  if (response.ok) {
    return response.json();
  }
  if (response.status === 400) {
    const error = await response.text();
    throw new Error(error);
  }
  throw new Error('Network response was not ok.');
}

export function handleError(error) {
  if (error.name === 'AbortError') {
    console.log('Fetch request cancelled');
  } else {
    console.error('API call failed. ' + error);
    throw error;
  }
}
