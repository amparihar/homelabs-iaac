import React, {
  useState,
  forwardRef,
  useImperativeHandle,
  useEffect
} from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';

const styles = {
  wrapper: {
    position: 'fixed',
    top: '0',
    left: '0',
    bottom: '0',
    right: '0'
  },
  backdrop: {
    position: 'fixed',
    top: '0',
    left: '0',
    bottom: '0',
    right: '0',
    zIndex: '100',
    backgroundColor: 'rgba(0, 0, 0, 0.3)'
  },
  content: {
    position: 'relative',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    minHeight: '40%',
    width: '60%',
    overflowY: 'auto',
    backgroundColor: 'white',
    boxShadow: '0 0 10px, rgba(0,0,0,0.25)',
    zIndex: '200',
    padding: '10px'
  }
};

const Modal = (props) => {
  const { children } = props;
  const [display, setDisplay] = useState(false);

  const show = () => setDisplay(true);
  const hide = () => setDisplay(false);

  useEffect(() => {
    setDisplay(props.display);
    return () => setDisplay(false);
  }, [props.display, setDisplay]);

  // useImperativeHandle(
  //   ref,
  //   () => ({
  //     show,
  //     hide
  //   }),
  //   [display, setDisplay]
  // );

  // if (display) {
  //   return ReactDOM.createPortal(
  //     <div style={styles.wrapper}>
  //       <div style={styles.backdrop} onClick={hide} />
  //       <div style={styles.content}>{children}</div>
  //     </div>,
  //     document.getElementById('modal-root')
  //   );
  // }
  // return null;

  return (
    <>
      {display
        ? ReactDOM.createPortal(
            <div style={styles.wrapper}>
              <div style={styles.backdrop} onClick={hide} />
              <div style={styles.content}>{children}</div>
            </div>,
            document.getElementById('modal-root')
          )
        : null}
    </>
  );
};

Modal.propTypes = {
  display: PropTypes.bool.isRequired
};

export default Modal;
