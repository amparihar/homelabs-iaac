import React, { useEffect, useState } from 'react';
import { render } from 'react-dom';

function CurrentTime(props) {
  const [currentTime, setCurrentTime] = useState(
    new Date().toLocaleTimeString()
  );

  useEffect(() => {
    let interval = setInterval(
      () => setCurrentTime(new Date().toLocaleTimeString()),
      1000
    );

    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    const docClick = evt => {
      console.log(`x: ${evt.clientX} y: ${evt.clientY}`);
    };
    document.addEventListener('click', docClick);
    return () => {
      document.removeEventListener('click', docClick);
    }
  }, []);

  return (
    <div>
      <h4>Current Time</h4>
      <input type="text" />
      <pre>{currentTime}</pre>
    </div>
  );
}

function Diffing() {
  return (
    <>
      <CurrentTime />
    </>
  );
}

export default Diffing;
