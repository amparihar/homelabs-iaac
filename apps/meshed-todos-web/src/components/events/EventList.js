import React, { useEffect } from "react";
import { connect } from "react-redux";

import * as eventsApi from "../../api/eventsApi";
import EventCard from "./EventCard";

function EventList(props) {
  useEffect(() => {
    // const getEvents = async () => {
    //   const response = await eventsApi.getEvents();
    //   const updated = {...response[0], name:"test"}
    //   const saveResponse = await eventsApi.saveEvent(updated)
    //   const newresponse = await eventsApi.getEvents();
    //   console.log(newresponse)
    // };
    // getEvents();
  }, []);
  return (
    <div>
      <EventCard />
    </div>
  );
}

const mapStateToProps = state => ({
  events: state.events
});

export const ConnectedEventList = connect(mapStateToProps)(EventList);

//export default connect(mapStateToProps)(EventList);
